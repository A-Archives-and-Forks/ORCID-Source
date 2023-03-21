package org.orcid.internal.server;

import static org.orcid.core.api.OrcidApiConstants.INTERNAL_API_FIND_ORCID_BY_EMAIL;
import static org.orcid.core.api.OrcidApiConstants.INTERNAL_API_PERSON_READ;
import static org.orcid.core.api.OrcidApiConstants.INTERNAL_API_TOGGLZ_READ;
import static org.orcid.core.api.OrcidApiConstants.MEMBER_INFO;
import static org.orcid.core.api.OrcidApiConstants.STATUS_PATH;
import static org.orcid.core.api.OrcidApiConstants.OAUTH_TOKEN;

import javax.annotation.Resource;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedHashMap;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.core.Response;

import org.apache.commons.net.util.Base64;
import org.orcid.api.common.oauth.OrcidClientCredentialEndPointDelegator;
import org.orcid.core.oauth.OAuthError;
import org.orcid.core.oauth.OAuthErrorUtils;
import org.orcid.internal.server.delegator.InternalApiServiceDelegator;
import org.orcid.internal.server.delegator.InternalClientCredentialEndPointDelegator;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

//import io.swagger.annotations.ApiOperation;

/**
 * 
 * @author Angel Montenegro
 * 
 */
@Component
@Path("/")
public class InternalApiServiceImplBase {
    private InternalApiServiceDelegator serviceDelegator;

    @Resource
    private InternalClientCredentialEndPointDelegator orcidInternalClientCredentialEndPointDelegator;
    
    public void setServiceDelegator(InternalApiServiceDelegator serviceDelegator) {
        this.serviceDelegator = serviceDelegator;
    }
    
    /**
     * @return Plain text message indicating health of service
     */
    @GET
    @Produces(value = { MediaType.TEXT_PLAIN })
    @Path(STATUS_PATH)
    //@ApiOperation(value = "Check the server status", hidden = true)
    public Response viewStatusText() {
        return serviceDelegator.viewStatusText();
    }
    
    /**
     * 
     * @param formParams
     * @return
     */
    @POST
    @Path(OAUTH_TOKEN)
    @Produces(value = { MediaType.APPLICATION_JSON })
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public Response obtainOauth2TokenPost(@FormParam("client_id") String clientId, @FormParam("scope") String scopeList, @FormParam("grant_type") String grantType) {
        return orcidInternalClientCredentialEndPointDelegator.obtainOauth2Token(clientId, scopeList, grantType);        
    }
    
    @GET
    @Produces(value = { MediaType.APPLICATION_JSON })
    @Path(INTERNAL_API_PERSON_READ)
    public Response viewPersonDetails(@PathParam("orcid") String orcid) {
        return serviceDelegator.viewPersonLastModified(orcid);         
    }
    
    /**
     * 
     * @param formParams
     * @return
     */
    @POST
    @Path(MEMBER_INFO)
    @Produces(value = { MediaType.APPLICATION_JSON })
    public Response viewMemberDetails(@RequestParam String member) {
        return serviceDelegator.viewMemberInfo(member);
    }
    
    @GET
    @Produces(value = { MediaType.APPLICATION_JSON })
    @Path(INTERNAL_API_TOGGLZ_READ)
    public Response viewTogglz() {
        return serviceDelegator.viewTogglz();
    }

    /**
     *
     * @param email must be encoded in Base64 format
     * @return
     */
    @GET
    @Produces(value = { MediaType.APPLICATION_JSON })
    @Path(INTERNAL_API_FIND_ORCID_BY_EMAIL)
    public Response findOrcidByEmail(@PathParam("email") String email) {
        return serviceDelegator.findOrcidByEmail(new String(Base64.decodeBase64(email.getBytes())));
    }
}
