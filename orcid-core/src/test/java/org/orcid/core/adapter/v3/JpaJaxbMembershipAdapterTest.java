package org.orcid.core.adapter.v3;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.io.InputStream;

import javax.annotation.Resource;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.orcid.core.adapter.MockSourceNameCache;
import org.orcid.core.manager.ClientDetailsEntityCacheManager;
import org.orcid.core.manager.ClientDetailsManager;
import org.orcid.core.manager.SourceNameCacheManager;
import org.orcid.core.manager.v3.read_only.RecordNameManagerReadOnly;
import org.orcid.jaxb.model.v3.release.common.Visibility;
import org.orcid.jaxb.model.v3.release.record.AffiliationType;
import org.orcid.jaxb.model.v3.release.record.Membership;
import org.orcid.jaxb.model.v3.release.record.summary.MembershipSummary;
import org.orcid.persistence.dao.RecordNameDao;
import org.orcid.persistence.jpa.entities.ClientDetailsEntity;
import org.orcid.persistence.jpa.entities.EndDateEntity;
import org.orcid.persistence.jpa.entities.OrgAffiliationRelationEntity;
import org.orcid.persistence.jpa.entities.OrgEntity;
import org.orcid.persistence.jpa.entities.ProfileEntity;
import org.orcid.persistence.jpa.entities.SourceEntity;
import org.orcid.persistence.jpa.entities.StartDateEntity;
import org.orcid.test.OrcidJUnit4ClassRunner;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.util.ReflectionTestUtils;

/**
 * 
 * @author Angel Montenegro
 * 
 */
@RunWith(OrcidJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:orcid-core-context.xml" })
public class JpaJaxbMembershipAdapterTest extends MockSourceNameCache {

    @Resource(name = "jpaJaxbMembershipAdapterV3")
    private JpaJaxbMembershipAdapter adapter;
    
    @Resource
    private ClientDetailsEntityCacheManager clientDetailsEntityCacheManager;
    
    @Resource
    private SourceNameCacheManager sourceNameCacheManager;
    
    @Mock
    private ClientDetailsManager mockClientDetailsManager;
    
    @Mock
    private RecordNameDao mockRecordNameDao;
    
    @Mock
    private RecordNameManagerReadOnly mockRecordNameManager;

    @Before
    public void setUp() {
        // by default return client details entity with user obo disabled
        Mockito.when(mockClientDetailsManager.findByClientId(Mockito.anyString())).thenReturn(new ClientDetailsEntity());
        ReflectionTestUtils.setField(clientDetailsEntityCacheManager, "clientDetailsManager", mockClientDetailsManager);
        
        Mockito.when(mockRecordNameDao.exists(Mockito.anyString())).thenReturn(true);
        Mockito.when(mockRecordNameManager.fetchDisplayablePublicName(Mockito.anyString())).thenReturn("test");
        ReflectionTestUtils.setField(sourceNameCacheManager, "recordNameDao", mockRecordNameDao);
        ReflectionTestUtils.setField(sourceNameCacheManager, "recordNameManagerReadOnlyV3", mockRecordNameManager);
    }
    
    @Test
    public void testToOrgAffiliationRelationEntity() throws JAXBException {
        Membership e = getMembership();
        assertNotNull(e);
        OrgAffiliationRelationEntity oar = adapter.toOrgAffiliationRelationEntity(e);
        assertNotNull(oar);
        //General info
        assertEquals(Long.valueOf(0), oar.getId());
        assertEquals(Visibility.PRIVATE.name(), oar.getVisibility());        
        assertEquals("department-name", oar.getDepartment());
        assertEquals("role-title", oar.getTitle());
        
        //Dates
        assertEquals(Integer.valueOf(2), oar.getStartDate().getDay());        
        assertEquals(Integer.valueOf(2), oar.getStartDate().getMonth());
        assertEquals(Integer.valueOf(1948), oar.getStartDate().getYear());
        assertEquals(Integer.valueOf(2), oar.getEndDate().getDay());
        assertEquals(Integer.valueOf(2), oar.getEndDate().getMonth());
        assertEquals(Integer.valueOf(1948), oar.getEndDate().getYear());
        
        // Source
        assertNull(oar.getSourceId());        
        assertNull(oar.getClientSourceId());        
        assertNull(oar.getElementSourceId());
        assertEquals("http://tempuri.org",oar.getUrl());
    }
    
    @Test
    public void clearOrgAffiliationRelationEntityFieldsTest() throws JAXBException {
        Membership e = getMembership();
        assertNotNull(e);
        OrgAffiliationRelationEntity oar = adapter.toOrgAffiliationRelationEntity(e);
        assertNotNull(oar);
        
        e.setUrl(null);
        adapter.toOrgAffiliationRelationEntity(e, oar);
        
        assertNotNull(oar);
        assertNull(oar.getUrl());
        
        //General info
        assertEquals(Long.valueOf(0), oar.getId());
        assertEquals(Visibility.PRIVATE.name(), oar.getVisibility());        
        assertEquals("department-name", oar.getDepartment());
        assertEquals("role-title", oar.getTitle());
        
        //Dates
        assertEquals(Integer.valueOf(2), oar.getStartDate().getDay());        
        assertEquals(Integer.valueOf(2), oar.getStartDate().getMonth());
        assertEquals(Integer.valueOf(1948), oar.getStartDate().getYear());
        assertEquals(Integer.valueOf(2), oar.getEndDate().getDay());
        assertEquals(Integer.valueOf(2), oar.getEndDate().getMonth());
        assertEquals(Integer.valueOf(1948), oar.getEndDate().getYear());
        
        // Source
        assertNull(oar.getSourceId());        
        assertNull(oar.getClientSourceId());        
        assertNull(oar.getElementSourceId());
    }
    
    @Test
    public void fromOrgAffiliationRelationEntityToMembership() {
        OrgAffiliationRelationEntity entity = getEntity();
        assertNotNull(entity);
        Membership membership = adapter.toMembership(entity);
        assertNotNull(membership);
        assertEquals("membership:department", membership.getDepartmentName());
        assertEquals(Long.valueOf(123456), membership.getPutCode());
        assertEquals("membership:title", membership.getRoleTitle());
        assertEquals("private", membership.getVisibility().value());
        assertNotNull(membership.getStartDate());
        assertEquals("2000", membership.getStartDate().getYear().getValue());
        assertEquals("01", membership.getStartDate().getMonth().getValue());
        assertEquals("01", membership.getStartDate().getDay().getValue());
        assertEquals("2020", membership.getEndDate().getYear().getValue());
        assertEquals("02", membership.getEndDate().getMonth().getValue());
        assertEquals("02", membership.getEndDate().getDay().getValue());
        assertNotNull(membership.getOrganization());
        assertEquals("org:name", membership.getOrganization().getName());
        assertNotNull(membership.getOrganization().getAddress());
        assertEquals("org:city", membership.getOrganization().getAddress().getCity());
        assertEquals("org:region", membership.getOrganization().getAddress().getRegion());
        assertEquals(org.orcid.jaxb.model.common.Iso3166Country.US, membership.getOrganization().getAddress().getCountry());
        assertNotNull(membership.getSource());        
        assertNotNull(membership.getSource().retrieveSourcePath());
        assertEquals(CLIENT_SOURCE_ID, membership.getSource().retrieveSourcePath());
        assertEquals("http://tempuri.org",membership.getUrl().getValue());
        
        // no user obo
        assertNull(membership.getSource().getAssertionOriginOrcid());
    }
    
    @Test
    public void fromOrgAffiliationRelationEntityToMembershipSummary() {
        OrgAffiliationRelationEntity entity = getEntity();
        assertNotNull(entity);
        MembershipSummary summary = adapter.toMembershipSummary(entity);
        assertNotNull(summary);
        assertEquals("membership:department", summary.getDepartmentName());
        assertEquals(Long.valueOf(123456), summary.getPutCode());
        assertEquals("membership:title", summary.getRoleTitle());
        assertEquals("private", summary.getVisibility().value());
        assertNotNull(summary.getStartDate());
        assertEquals("2000", summary.getStartDate().getYear().getValue());
        assertEquals("01", summary.getStartDate().getMonth().getValue());
        assertEquals("01", summary.getStartDate().getDay().getValue());
        assertEquals("2020", summary.getEndDate().getYear().getValue());
        assertEquals("02", summary.getEndDate().getMonth().getValue());
        assertEquals("02", summary.getEndDate().getDay().getValue());        
        assertNotNull(summary.getSource());
        assertNotNull(summary.getSource().retrieveSourcePath());
        assertEquals(CLIENT_SOURCE_ID, summary.getSource().retrieveSourcePath());
        assertEquals("http://tempuri.org",summary.getUrl().getValue());
        
        // no user obo
        assertNull(summary.getSource().getAssertionOriginOrcid());
    }
    
    @Test
    public void fromOrgAffiliationRelationEntityToUserOBOMembership() {
        // set client source to user obo enabled client
        ClientDetailsEntity userOBOClient = new ClientDetailsEntity();
        userOBOClient.setUserOBOEnabled(true);
        Mockito.when(mockClientDetailsManager.findByClientId(Mockito.anyString())).thenReturn(userOBOClient);
        
        OrgAffiliationRelationEntity entity = getEntity();
        assertNotNull(entity);
        Membership membership = adapter.toMembership(entity);
        assertNotNull(membership);
        assertEquals("membership:department", membership.getDepartmentName());
        assertEquals(Long.valueOf(123456), membership.getPutCode());
        assertEquals("membership:title", membership.getRoleTitle());
        assertEquals("private", membership.getVisibility().value());
        assertNotNull(membership.getStartDate());
        assertEquals("2000", membership.getStartDate().getYear().getValue());
        assertEquals("01", membership.getStartDate().getMonth().getValue());
        assertEquals("01", membership.getStartDate().getDay().getValue());
        assertEquals("2020", membership.getEndDate().getYear().getValue());
        assertEquals("02", membership.getEndDate().getMonth().getValue());
        assertEquals("02", membership.getEndDate().getDay().getValue());
        assertNotNull(membership.getOrganization());
        assertEquals("org:name", membership.getOrganization().getName());
        assertNotNull(membership.getOrganization().getAddress());
        assertEquals("org:city", membership.getOrganization().getAddress().getCity());
        assertEquals("org:region", membership.getOrganization().getAddress().getRegion());
        assertEquals(org.orcid.jaxb.model.common.Iso3166Country.US, membership.getOrganization().getAddress().getCountry());
        assertNotNull(membership.getSource());        
        assertNotNull(membership.getSource().retrieveSourcePath());
        assertEquals(CLIENT_SOURCE_ID, membership.getSource().retrieveSourcePath());
        assertEquals("http://tempuri.org",membership.getUrl().getValue());
        
        // user obo
        assertNotNull(membership.getSource().getAssertionOriginOrcid());
    }
    
    @Test
    public void fromOrgAffiliationRelationEntityToUserOBOMembershipSummary() {
        // set client source to user obo enabled client
        ClientDetailsEntity userOBOClient = new ClientDetailsEntity();
        userOBOClient.setUserOBOEnabled(true);
        Mockito.when(mockClientDetailsManager.findByClientId(Mockito.anyString())).thenReturn(userOBOClient);
        
        OrgAffiliationRelationEntity entity = getEntity();
        assertNotNull(entity);
        MembershipSummary summary = adapter.toMembershipSummary(entity);
        assertNotNull(summary);
        assertEquals("membership:department", summary.getDepartmentName());
        assertEquals(Long.valueOf(123456), summary.getPutCode());
        assertEquals("membership:title", summary.getRoleTitle());
        assertEquals("private", summary.getVisibility().value());
        assertNotNull(summary.getStartDate());
        assertEquals("2000", summary.getStartDate().getYear().getValue());
        assertEquals("01", summary.getStartDate().getMonth().getValue());
        assertEquals("01", summary.getStartDate().getDay().getValue());
        assertEquals("2020", summary.getEndDate().getYear().getValue());
        assertEquals("02", summary.getEndDate().getMonth().getValue());
        assertEquals("02", summary.getEndDate().getDay().getValue());        
        assertNotNull(summary.getSource());
        assertNotNull(summary.getSource().retrieveSourcePath());
        assertEquals(CLIENT_SOURCE_ID, summary.getSource().retrieveSourcePath());
        assertEquals("http://tempuri.org",summary.getUrl().getValue());
        
        // user obo
        assertNotNull(summary.getSource().getAssertionOriginOrcid());
    }

    private Membership getMembership() throws JAXBException {
        JAXBContext context = JAXBContext.newInstance(new Class[] { Membership.class });
        Unmarshaller unmarshaller = context.createUnmarshaller();
        String name = "/record_3.0_rc1/samples/read_samples/membership-3.0_rc1.xml";
        InputStream inputStream = getClass().getResourceAsStream(name);
        return (Membership) unmarshaller.unmarshal(inputStream);
    }
    
    private OrgAffiliationRelationEntity getEntity() {
        OrgEntity orgEntity = new OrgEntity();
        orgEntity.setCity("org:city");
        orgEntity.setCountry(org.orcid.jaxb.model.message.Iso3166Country.US.name());
        orgEntity.setName("org:name");
        orgEntity.setRegion("org:region");
        orgEntity.setUrl("org:url");
        
        ClientDetailsEntity clientDetailsEntity = new ClientDetailsEntity();
        clientDetailsEntity.setId(CLIENT_SOURCE_ID);

        SourceEntity sourceEntity = new SourceEntity();
        sourceEntity.setSourceClient(clientDetailsEntity);
        orgEntity.setSource(sourceEntity);
        
        OrgAffiliationRelationEntity result = new OrgAffiliationRelationEntity();
        result.setAffiliationType(AffiliationType.MEMBERSHIP.name());
        result.setDepartment("membership:department");
        result.setEndDate(new EndDateEntity(2020, 2, 2));
        result.setId(123456L);
        result.setOrg(orgEntity);
        result.setProfile(new ProfileEntity("0000-0001-0002-0003"));
        result.setStartDate(new StartDateEntity(2000, 1, 1));
        result.setTitle("membership:title");
        result.setVisibility(org.orcid.jaxb.model.common_v2.Visibility.PRIVATE.name());   
        result.setClientSourceId(CLIENT_SOURCE_ID);
        result.setUrl("http://tempuri.org");
        return result;
    }
}
