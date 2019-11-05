# Description

This project contains the Solr cores configuration used by the ORCID registry.

# Solr Development Environment Setup

## Download Solr

1. Download Solr 8.0.0 from http://archive.apache.org/dist/lucene/solr/8.0.0/
2. Uncompress it into the home folder /opt/

        unzip /Users/username/Downloads/solr-8.0.0.zip /opt

3. Create the folder /opt/solr/solr_data

        mkdir -p /opt/solr/solr_data

4. Create the folder /opt/solr/solr_conf/data

        mkdir -p /opt/solr/solr_conf/data

## Download the code

1. Download a copy of the ORCID-Source repository: git clone git@github.com:ORCID/ORCID-Source.git to your /tmp folder
2. Move the content of folder /tmp/ORCID-Source/solr-config/cores to /opt/solr/solr_conf/data

        mv /tmp/ORCID-Source/solr-config/cores/* /opt/solr/solr_conf/data/

You should end up with

        /opt/solr/solr_conf/data/fundingSubype  
        /opt/solr/solr_conf/data/org  
        /opt/solr/solr_conf/data/profile  
        /opt/solr/solr_conf/data/solr.xml

3. cd into /opt/solr-8.0.0/bin
4. Start solr server: 

        ./solr start -p <port> -s /opt/solr/solr_conf/data  

   (Where the port should not collide with any of the ports already in use, if you dont specify the -p param, the default port will be 8983)
5. Confirm solr is up and cores have been created by going to http://localhost:<SOLR_PORT>/solr/#/

## Configure the project to use the new solr instance

### Message listener configuration

Message listener configuration will allow developers to feed the local solr instance with the public records comming from the public API

If you have changed the SOLR port from the default 8983, modify the following variables in message-listener.properties: 

```
org.orcid.persistence.solr.url=http://localhost:<SOLR_PORT>/solr
org.orcid.persistence.solr.read.only.url=http://localhost:<SOLR_PORT>/solr
```  
Also check that the following properties are set in message-listener.properties:

```
org.orcid.persistence.messaging.solr_indexing.enabled=true
org.orcid.persistence.messaging.solr_org_indexing.enabled=true
org.orcid.persistence.messaging.solr_funding_sub_type_indexing.enabled=true
``` 

### Web and API's configuration

This will allow the web page and API's to use Solr to perform queries.

If you have changed the SOLR port from the default 8983, modify the following variables in staging-persistence.properties:

```
org.orcid.persistence.solr.url=http://localhost:<SOLR_PORT>/solr
org.orcid.persistence.solr.read.only.url=http://localhost:<SOLR_PORT>/solr
```

## Feed Solr

Now we need to feed solr with local data and confirm it is working as expected:

1. Reindex all existing records, by executing the following query:

```sql
update profile set indexing_status='REINDEX';
update org_disambiguated set indexing_status='REINDEX';
```

2. Start the message listener server
3. Start the web, pub and api server
4. Start the scheduler server
5. Go to https://localhost:8443/orcid-web/togglz/edit?f=DISABLE_LEGACY_SOLR and set to enabled
6. Wait for all records to be indexed by the message listener: to confirm this, login into the psql db and execute the following queries: 

```sql
\c message_listener
select orcid, api_2_0_solr_status from record_status;
```
   That query should return all your reindexed records with a 0 in the `api_2_0_solr_status` column
6. Go to the localhost webapp and search for a public name in you records, that will make a call to the public API that will call the Solr server, the screen should show you the records that match your query.


