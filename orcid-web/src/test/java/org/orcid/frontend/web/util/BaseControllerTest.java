package org.orcid.frontend.web.util;

import java.util.Arrays;

import javax.annotation.Resource;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.mockito.MockitoAnnotations;
import org.orcid.core.oauth.OrcidProfileUserDetails;
import org.orcid.core.security.OrcidUserDetailsService;
import org.orcid.core.security.OrcidWebRole;
import org.orcid.jaxb.model.message.OrcidMessage;
import org.orcid.jaxb.model.message.OrcidProfile;
import org.orcid.test.DBUnitTest;
import org.springframework.aop.framework.Advised;
import org.springframework.aop.support.AopUtils;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @author Declan Newman (declan) Date: 23/02/2012
 */
@Ignore
public class BaseControllerTest extends DBUnitTest {

    protected OrcidProfile orcidProfile;
    
    @Resource
    private OrcidUserDetailsService orcidUserDetailsService;

    @BeforeClass
    public static void beforeClass() throws Exception {
        initDBUnitData(Arrays.asList("/data/SourceClientDetailsEntityData.xml", "/data/ProfileEntityData.xml",
                "/data/RecordNameEntityData.xml", "/data/BiographyEntityData.xml"));
    }

    @Before
    public void beforeInstance() {
        SecurityContextHolder.getContext().setAuthentication(getAuthentication());
        MockitoAnnotations.initMocks(this);
    }

    @AfterClass
    public static void afterClass() throws Exception {
        removeDBUnitData(Arrays.asList("/data/ProfileEntityData.xml"));
    }

    protected Authentication getAuthentication() {
        return getAuthentication("4444-4444-4444-4446");
    }

    protected Authentication getAuthentication(String orcid) {
        if (orcidProfile == null) {
            orcidProfile = getOrcidProfile();
        }

        OrcidProfileUserDetails details = (OrcidProfileUserDetails) orcidUserDetailsService.loadUserByUsername(orcidProfile.retrieveOrcidPath());
        UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(orcid, details.getPassword(), Arrays.asList(OrcidWebRole.ROLE_USER));
        auth.setDetails(details);
        return auth;
    }

    protected static OrcidProfile getOrcidProfile() {
        try {
            JAXBContext context = JAXBContext.newInstance(OrcidMessage.class);
            Unmarshaller unmarshaller = context.createUnmarshaller();
            OrcidMessage orcidMessage = (OrcidMessage) unmarshaller.unmarshal(BaseControllerTest.class.getResourceAsStream(

                    "/orcid-internal-full-message-latest.xml"));
            return orcidMessage.getOrcidProfile();
        } catch (JAXBException e) {
            throw new RuntimeException(e);
        }
    }

    @SuppressWarnings({ "unchecked" })
    protected <T> T getTargetObject(Object proxy, Class<T> targetClass) throws Exception {
        while ((AopUtils.isJdkDynamicProxy(proxy))) {
            return (T) getTargetObject(((Advised) proxy).getTargetSource().getTarget(), targetClass);
        }
        return (T) proxy; // expected to be cglib proxy then, which is simply a
        // specialized class
    }

}
