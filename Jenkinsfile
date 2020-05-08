node {

    properties([
        buildDiscarder(
            logRotator(
                artifactDaysToKeepStr: '',
                artifactNumToKeepStr: '',
                daysToKeepStr: '3',
                numToKeepStr: '3'
            )
        ),
        disableConcurrentBuilds(),
        [$class: 'RebuildSettings', autoRebuild: false, rebuildDisabled: false], 
        pipelineTriggers([])
    ])

    git url: 'https://github.com/ORCID/ORCID-Source.git', branch: env.BRANCH_NAME
    def EHCACHE_LOCATION="${WORKSPACE}/tmp/ehcache_${env.BRANCH_NAME}_$BUILD_NUMBER"

    stage('SETUP VERSION') {
        try {
            sh "mkdir -p $EHCACHE_LOCATION"
            do_maven("versions:set -DnewVersion=${BRANCH_NAME}-${BUILD_NUMBER} -f orcid-test/pom.xml")
            do_maven("versions:set -DnewVersion=${BRANCH_NAME}-${BUILD_NUMBER}")
        } catch(Exception err) {
            orcid_notify("Failed to update artifact versions ${env.BRANCH_NAME}#$BUILD_NUMBER FAILED [${JOB_URL}]", 'ERROR')
            deleteDir()
            throw err
        }
    }

    stage('BUILD') {
        try {
            do_maven("-D maven.test.skip=true -D license.skip=true clean install")
        } catch(Exception err) {
            orcid_notify("parent compile failed ${env.BRANCH_NAME}#$BUILD_NUMBER FAILED [${JOB_URL}]", 'ERROR')
            deleteDir()
            throw err
        }
    }

    stage('TESTS') {
        try {
            parallel(
                model:   {do_maven("test -f orcid-test/pom.xml")},
                parent:  {do_maven("test")}
            )
        } catch(Exception err) {
            orcid_notify("running tests on model and test modules failed ${env.BRANCH_NAME}#$BUILD_NUMBER FAILED [${JOB_URL}]", 'ERROR')
            throw err
        } finally {
            report_and_clean()
        }
        orcid_notify("Pipeline ${env.BRANCH_NAME}#$BUILD_NUMBER workflow completed [${JOB_URL}]", 'SUCCESS')
    }
}

def report_and_clean(){
    sh "rm -rf /var/lib/jenkins/.m2/repository/org/orcid/**/${BRANCH_NAME}-${BUILD_NUMBER}"
    junit '**/target/surefire-reports/*.xml'
    deleteDir()
}

def orcid_notify(message, level){
    def color = "#d00000"
    if(level == 'SUCCESS'){
        color = "#36a64f"
    }
    try{
        slackSend color: "$color", failOnError: true, message: "$message", teamDomain: 'orcid'
    } catch(Exception err) {
        echo err.toString()
    }
}

def do_maven(mvn_task){
    def MAVEN = tool 'ORCID_MAVEN'
    def EHCACHE_LOCATION="${WORKSPACE}/tmp/ehcache_${env.BRANCH_NAME}_$BUILD_NUMBER"
    try{
        sh "export MAVEN_OPTS='-Xms2048m -Xmx2048m -XX:+HeapDumpOnOutOfMemoryError'"
        sh "$MAVEN/bin/mvn -Djava.io.tmpdir=$EHCACHE_LOCATION $mvn_task"
    } catch(Exception err) {
        throw err
    }
}
