package org.orcid.frontend.email;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.xml.bind.JAXBException;

import org.apache.commons.lang3.LocaleUtils;
import org.junit.Test;
import org.mockito.Mock;
import org.orcid.core.adapter.v3.JpaJaxbNotificationAdapter;
import org.orcid.core.common.manager.EmailFrequencyManager;
import org.orcid.core.manager.EncryptionManager;
import org.orcid.core.manager.ProfileEntityCacheManager;
import org.orcid.core.manager.v3.EmailManager;
import org.orcid.core.manager.v3.SourceManager;
import org.orcid.core.manager.v3.impl.NotificationManagerImpl;
import org.orcid.core.oauth.OrcidOauth2TokenDetailService;
import org.orcid.jaxb.model.common.AvailableLocales;
import org.orcid.jaxb.model.v3.release.record.Email;
import org.orcid.persistence.dao.GenericDao;
import org.orcid.persistence.dao.NotificationDao;
import org.orcid.persistence.dao.ProfileDao;
import org.orcid.persistence.jpa.entities.EmailEventEntity;
import org.orcid.persistence.jpa.entities.ProfileEntity;
import org.orcid.persistence.jpa.entities.ProfileEventEntity;
import org.orcid.test.TargetProxyHelper;
import org.orcid.utils.email.MailGunManager;

public class RecordEmailSenderTest {

    @Mock
    private GenericDao<ProfileEventEntity, Long> profileEventDao;

    @Mock
    private SourceManager sourceManager;

    @Mock
    private NotificationDao mockNotificationDao;

    @Mock
    private MailGunManager mockMailGunManager;

    @Mock
    private OrcidOauth2TokenDetailService mockOrcidOauth2TokenDetailService;

    @Mock
    private ProfileEntityCacheManager mockProfileEntityCacheManager;

    @Mock
    private EmailManager mockEmailManager;

    @Mock
    private ProfileDao mockProfileDao;

    @Mock
    private ProfileDao mockProfileDaoReadOnly;

    @Mock
    private JpaJaxbNotificationAdapter mockNotificationAdapter;

    @Mock
    public GenericDao<EmailEventEntity, Long> mockEmailEventDao;

    @Mock
    public EmailFrequencyManager mockEmailFrequencyManager;
    
    @Resource
    RecordEmailSender recordEmailSender;
    
    @Test
    public void testSendWelcomeEmail() throws JAXBException, IOException, URISyntaxException {
        ProfileEntity p = new ProfileEntity();
        p.setLocale("EN");
        when(mockProfileEntityCacheManager.retrieve(anyString())).thenReturn(p);

        Email email = new Email();
        email.setEmail("josiah_carberry@brown.edu");
        when(mockEmailManager.findPrimaryEmail(anyString())).thenReturn(email);

        recordEmailSender.sendWelcomeEmail("4444-4444-4444-4446", "josiah_carberry@brown.edu");
    }

    @Test
    public void testSendVerificationEmail() throws JAXBException, IOException, URISyntaxException {
        ProfileEntity p = new ProfileEntity();
        p.setLocale("EN");
        when(mockProfileEntityCacheManager.retrieve(anyString())).thenReturn(p);

        Email email = new Email();
        email.setEmail("josiah_carberry@brown.edu");
        when(mockEmailManager.findPrimaryEmail(anyString())).thenReturn(email);

        recordEmailSender.sendVerificationEmail("4444-4444-4444-4446", "josiah_carberry@brown.edu");
    }

    @Test
    public void testResetEmail() throws Exception {
        String userOrcid = "0000-0000-0000-0003";
        String primaryEmail = "public_0000-0000-0000-0003@test.orcid.org";
        for (AvailableLocales locale : AvailableLocales.values()) {
            EncryptionManager mockEncypter = mock(EncryptionManager.class);
            when(mockEncypter.encryptForExternalUse(any(String.class)))
                    .thenReturn("Ey+qsh7G2BFGEuqqkzlYRidL4NokGkIgDE+1KOv6aLTmIyrppdVA6WXFIaQ3KsQpKEb9FGUFRqiWorOfhbB2ww==");
            recordEmailSender.sendPasswordResetEmail(primaryEmail, userOrcid);
        }
    }

    @Test
    public void testResetNotFoundEmail() throws Exception {        
        String submittedEmail = "email_not_in_orcid@test.orcid.org";
        for (AvailableLocales curLocale : AvailableLocales.values()) {
            recordEmailSender.sendPasswordResetNotFoundEmail(submittedEmail, LocaleUtils.toLocale(curLocale.value()));
        }
    }
    
    @Test
    public void testSendDeactivateEmail() throws JAXBException, IOException, URISyntaxException {
        final String orcid = "0000-0000-0000-0003";

        ProfileEntity profile = new ProfileEntity(orcid);

        Email email = new Email();
        email.setEmail("test@email.com");

        when(mockProfileEntityCacheManager.retrieve(orcid)).thenReturn(profile);
        when(mockEmailManager.findPrimaryEmail(orcid)).thenReturn(email);

        for (org.orcid.jaxb.model.common_v2.Locale locale : org.orcid.jaxb.model.common_v2.Locale.values()) {
            profile.setLocale(locale.name());
            recordEmailSender.sendOrcidDeactivateEmail(orcid);
        }
    }
    
    @Test
    public void testClaimReminderEmail() throws JAXBException, IOException, URISyntaxException {
        String userOrcid = "0000-0000-0000-0003";
        ProfileEntity profile = new ProfileEntity(userOrcid);
        for (AvailableLocales locale : AvailableLocales.values()) {
            profile.setLocale(locale.name());
            when(mockProfileEntityCacheManager.retrieve(userOrcid)).thenReturn(profile);
            recordEmailSender.sendClaimReminderEmail(userOrcid, 2, "test@test.com");
        }
    }

    @Test
    public void testChangeEmailAddress() throws Exception {
        final String orcid = "0000-0000-0000-0003";

        ProfileEntity profile = new ProfileEntity(orcid);
        Email email = new Email();
        email.setEmail("test@email.com");

        when(mockProfileEntityCacheManager.retrieve(orcid)).thenReturn(profile);
        when(mockEmailManager.findPrimaryEmail(orcid)).thenReturn(email);

        for (org.orcid.jaxb.model.common_v2.Locale locale : org.orcid.jaxb.model.common_v2.Locale.values()) {
            profile.setLocale(locale.name());
            recordEmailSender.sendEmailAddressChangedNotification(orcid, "new@email.com", "original@email.com");
        }
    }

    @Test
    public void testSendReactivationEmail() throws Exception {
        ProfileEntity p = new ProfileEntity();
        p.setLocale("EN");
        when(mockProfileEntityCacheManager.retrieve(anyString())).thenReturn(p);

        String userOrcid = "0000-0000-0000-0003";
        String email = "original@email.com";
        for (AvailableLocales locale : AvailableLocales.values()) {
            recordEmailSender.sendReactivationEmail(email, userOrcid);
        }
    }
    
    @Test
    public void testSend2FADisabledEmail() throws JAXBException, IOException, URISyntaxException {
        ProfileEntity p = new ProfileEntity();
        p.setLocale("EN");
        when(mockProfileEntityCacheManager.retrieve(anyString())).thenReturn(p);

        org.orcid.jaxb.model.v3.release.record.Emails emails = new org.orcid.jaxb.model.v3.release.record.Emails();
        List<org.orcid.jaxb.model.v3.release.record.Email> emailsList = new ArrayList<>();
        org.orcid.jaxb.model.v3.release.record.Email email = new org.orcid.jaxb.model.v3.release.record.Email();
        email.setEmail("test@test.com");
        emailsList.add(email);
        emails.setEmails(emailsList);
        when(mockEmailManager.getEmails(anyString())).thenReturn(emails);

        recordEmailSender.send2FADisabledEmail("4444-4444-4444-4446");
    }
    
    @Test
    public void testSendForgottenIdEmail() throws JAXBException, IOException, URISyntaxException {
        String userOrcid = "0000-0000-0000-0003";
        ProfileEntity profile = new ProfileEntity(userOrcid);
        for (AvailableLocales locale : AvailableLocales.values()) {
            profile.setLocale(locale.name());
            when(mockProfileEntityCacheManager.retrieve(userOrcid)).thenReturn(profile);
            recordEmailSender.sendForgottenIdEmail("test@test.com", userOrcid);
        }
    }
    
    @Test
    public void testSendForgottenIdEmailNotFound() throws Exception {
        String submittedEmail = "email_not_in_orcid@test.orcid.org";
        for (AvailableLocales curLocale : AvailableLocales.values()) {
            recordEmailSender.sendForgottenIdEmailNotFoundEmail(submittedEmail, LocaleUtils.toLocale(curLocale.value()));
        }
    }

    @Test
    public void testSendOrcidLockedEmail() throws JAXBException, IOException, URISyntaxException {
        ProfileEntity p = new ProfileEntity();
        p.setLocale("EN");
        when(mockProfileEntityCacheManager.retrieve(anyString())).thenReturn(p);

        Email email = new Email();
        email.setEmail("josiah_carberry@brown.edu");
        when(mockEmailManager.findPrimaryEmail(anyString())).thenReturn(email);

        recordEmailSender.sendOrcidLockedEmail("4444-4444-4444-4446");
    }
}
