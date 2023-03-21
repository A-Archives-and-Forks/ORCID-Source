package org.orcid.scheduler.loader.source.cli;

import org.orcid.scheduler.loader.manager.IssnLoadManager;
import org.orcid.scheduler.loader.manager.OrgLoadManager;
import org.orcid.scheduler.loader.source.OrgLoadSource;
import org.orcid.scheduler.loader.source.issn.IssnLoadSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LoadDataForIssnSource {
    
    private static final Logger LOG = LoggerFactory.getLogger(LoadDataForIssnSource.class);
    private  IssnLoadManager issnLoadManager;
    

    private IssnLoadSource issnDataSource;
    
    /**
     * Setup our spring resources
     * 
     */
    @SuppressWarnings({ "resource" })
    private void init() {
        ApplicationContext context = new ClassPathXmlApplicationContext("orcid-scheduler-context.xml");
        issnLoadManager = (IssnLoadManager) context.getBean("issnLoadManager");
        issnDataSource = (IssnLoadSource) context.getBean("issnDataSource");
    }
    
    
    public void loadIssn() {
        issnLoadManager.loadIssn();
        return;
    }
    
    
    public static void main(String[] args) {
        LoadDataForIssnSource loadDataForIssnSource = new LoadDataForIssnSource();
        loadDataForIssnSource.loadIssn();
    }

}
