package org.orcid.core.manager;

import java.security.NoSuchAlgorithmException;
import java.util.Date;

import org.orcid.core.manager.read_only.ProfileEntityManagerReadOnly;
import org.orcid.jaxb.model.clientgroup.MemberType;
import org.orcid.jaxb.model.common_v2.Locale;
import org.orcid.pojo.ajaxForm.Claim;

/**
 * User: Declan Newman (declan) Date: 10/02/2012 </p>
 */
public interface ProfileEntityManager extends ProfileEntityManagerReadOnly {

    String findByCreditName(String creditName);
    
    boolean orcidExists(String orcid);

    boolean hasBeenGivenPermissionTo(String giverOrcid, String receiverOrcid);

    boolean existsAndNotClaimedAndBelongsTo(String messageOrcid, String clientId);    

    boolean isProfileDeprecated(String orcid);

    boolean enableDeveloperTools(String orcid);

    boolean disableDeveloperTools(String orcid);

    boolean isProfileClaimed(String orcid);
    
    boolean isProfileClaimedByEmail(String email);

    MemberType getGroupType(String orcid);    

    boolean isDeactivated(String deactivated);

    boolean unreviewProfile(String orcid);

    boolean reviewProfile(String orcid);
    
    void disableApplication(Long tokenId, String userOrcid);
    
    String getOrcidHash(String orcid) throws NoSuchAlgorithmException;
    
    String retrivePublicDisplayName(String orcid);
    
    boolean claimProfileAndUpdatePreferences(String orcid, String email, Locale locale, Claim claim);
    
    void updateLastModifed(String orcid);

    void updateLocale(String orcid, Locale locale);

    public void updatePassword(String orcid, String encryptedPassword);
    
    public void updateLastLoginDetails(String orcid, String ipAddress);
    
    public Locale retrieveLocale(String orcid);      
    
    Date getLastLogin(String orcid);
    
    void update2FASecret(String orcid, String secret);
}