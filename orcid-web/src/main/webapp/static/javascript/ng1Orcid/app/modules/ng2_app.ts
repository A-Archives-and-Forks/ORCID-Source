declare var OrcidCookie: any;

//Angular imports
import 'reflect-metadata';

import { CommonModule } 
    from '@angular/common'; 

import { HttpClientModule } 
    from '@angular/common/http';

import { Component, NgModule } 
    from '@angular/core';

import { FormsModule, ReactiveFormsModule } 
    from '@angular/forms';

import { HttpModule, JsonpModule, Request, XSRFStrategy } 
    from '@angular/http';

import { BrowserModule } 
    from "@angular/platform-browser";

import { platformBrowserDynamic } 
    from '@angular/platform-browser-dynamic';

import { RouterModule, UrlHandlingStrategy } 
    from '@angular/router';

import { UpgradeModule } 
    from '@angular/upgrade/static';

import {NgbModule} from '@ng-bootstrap/ng-bootstrap'

//User generated modules imports

import { AccountSettingsNg2Module } 
    from './accountSettings/accountSettings.ts';

import { AdminActionsNg2Module } 
    from './adminActions/adminActions.ts';    

import { AffiliationNg2Module } 
    from './affiliation/affiliation.ts';

import { AffiliationDeleteNg2Module } 
    from './affiliation/affiliationDelete.ts';

import { AffiliationFormNg2Module } 
    from './affiliation/affiliationForm.ts';

import { AlertBannerNg2Module } 
    from './alertBanner/alertBanner.ts';

import { AllConsortiumContactsNg2Module } 
    from './allConsortiumContacts/allConsortiumContacts.ts';

import { BiographyNg2Module } 
    from './biography/biography.ts';

import { ClaimNg2Module }
    from './claim/claim.ts';

import { ClientEditNg2Module } 
    from './clientEdit/clientEdit.ts'; 

import { DelegatorsNg2Module } 
    from './delegators/delegators.ts';  

import { EmailsNg2Module } 
    from './emails/emails.ts';

import { EmailsFormNg2Module } 
    from './emailsForm/emailsForm.ts';

import { EmailUnverifiedWarningNg2Module } 
    from './emailUnverifiedWarning/emailUnverifiedWarning.ts';

import { EmailVerificationSentMesssageNg2Module } 
    from './emailVerificationSentMessage/emailVerificationSentMessage.ts';

import { ExtIdPopoverNg2Module } 
    from './extIdPopover/extIdPopover.ts';

import { FundingDeleteNg2Module } 
    from './funding/fundingDelete.ts';

import { FundingNg2Module } 
    from './funding/funding.ts';

import { FundingFormNg2Module } 
    from './funding/fundingForm.ts';

import { HeaderNg2Module } 
    from './header/header.ts';

import { HomeNg2Module } 
    from './home/home.ts';

import { LanguageNg2Module }
    from './language/language.ts';

import { LinkAccountNg2Module } 
    from './linkAccount/linkAccount.ts';

import { MembersListNg2Module } 
    from './membersList/membersList.ts';

import { ModalNg2Module }
    from './modalNg2/modal-ng.ts';

import { MyOrcidAlertsNg2Module } 
    from './myOrcidAlerts/myOrcidAlerts.ts';

import { NotificationsNg2Module }
    from './notifications/notifications.ts';

import { NotificationAlertsNg2Module }
    from './notificationAlerts/notificationAlerts.ts';

import { PeerReviewNg2Module } 
    from './peerReview/peerReview.ts';

import { PeerReviewDeleteNg2Module } 
    from './peerReview/peerReviewDelete.ts';

import { PersonNg2Module } 
    from './person/person.ts';

import { PrintRecordNg2Module } 
    from './printRecord/printRecord.ts';

import { PublicRecordNg2Module } 
    from './publicRecord/publicRecord.ts';

import { OauthAuthorizationNg2Module } 
    from './oauthAuthorization/oauthAuthorization.ts';

import { OrgIdentifierPopoverNg2Module } 
    from './orgIdentifierPopover/orgIdentifierPopover.ts';

import { ReactivationNg2Module } 
    from './reactivation/reactivation.ts';

import { RegisterDuplicatesNg2Module } 
    from './registerDuplicates/registerDuplicates.ts';

import { RequestPasswordResetNg2Module } 
    from './requestPasswordReset/requestPasswordReset.ts';

import { ResearchResourceNg2Module } 
    from './researchResource/researchResource.ts';

import { ResearchResourceDeleteNg2Module } 
    from './researchResource/researchResourceDelete.ts';

import { ResendClaimNg2Module }
    from './resendClaim/resendClaim.ts';    

import { ResetPasswordNg2Module }
    from './resetPassword/resetPassword.ts';

import { SearchNg2Module } 
    from './search/search.ts';

import { SelfServiceNg2Module } 
    from './selfService/selfService.ts';

import { SelfServiceAddContactNg2Module } 
    from './selfServiceAddContact/selfServiceAddContact.ts';

import { SelfServiceExistingSubMemberNg2Module } 
    from './selfServiceExistingSubMember/selfServiceExistingSubMember.ts';

import { SelfServiceRemoveContactNg2Module } 
    from './selfServiceRemoveContact/selfServiceRemoveContact.ts';

import { SelfServiceRemoveSubMemberNg2Module } 
    from './selfServiceRemoveSubMember/selfServiceRemoveSubMember.ts';

import { Social2FANg2Module }
    from './social2FA/social2FA.ts';

import { TwoFaSetupNg2Module }
    from './2FASetup/twoFASetup.ts';

import { UnsubscribeNg2Module }
    from './unsubscribe/unsubscribe.ts';  

import { WidgetNg2Module } 
    from './widget/widget.ts';

import { WorksBulkDeleteNg2Module } 
    from './works/worksBulkDelete.ts';

import { WorksDeleteNg2Module } 
    from './works/worksDelete.ts';

import { WorksFormNg2Module } 
    from './works/worksForm.ts';

import { WorksNg2Module } 
    from './works/works.ts';
    
import { WorksMergeSuggestionsNg2Module } 
    from './works/worksMergeSuggestions.ts';

import { ManageMembersNg2Module } 
    from './manageMembers/manageMembers.ts';
    
import { RecordCorrectionsNg2Module }
    from './recordCorrections/recordCorrections.ts'
    
import { DeveloperToolsNg2Module } 
    from './developerTools/developerTools.ts';    

import { idBannerNg2Module }  
    from './idBanner/idBanner.ts'

import { qrcodeNg2Module } 
    from './qrcode/qrcode.ts'

import { lastModifiedNg2Module } 
    from './lastModified/lastModified.ts';

import { bioNg2Module }
    from './bio/bio.ts';

import { printIdBannerNg2Module } 
    from './printIdBanner/printIdBanner.ts';
    
///////////////////
import {Injectable} 
    from '@angular/core';

import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor } 
    from '@angular/common/http';

import { Observable } 
    from 'rxjs';

import { HTTP_INTERCEPTORS, HttpHeaders } from '@angular/common/http';


@Injectable()
export class TokenInterceptor implements HttpInterceptor {
   constructor() {}
   
   intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
       if(request.method == 'GET') {
           return next.handle(request)
       } else {
           // Add CSRF headers for non GET requests
           const newHeaders: {[name: string]: string | string[]; } = {};
           for (const key of request.headers.keys()) {
               newHeaders[key] = request.headers.getAll(key);
           }          
           newHeaders['x-xsrf-token'] = OrcidCookie.getCookie('XSRF-TOKEN');           
           let _request = request.clone({headers: new HttpHeaders(newHeaders)});

           return next.handle(_request);
       }            
   }
}

///////////////////////////////

@Component(
    {
        selector: 'root-cmp',
        template: '<div class="ng-view"></div>'
    }
) 
export class RootCmp {
}

@NgModule({
    bootstrap: [
        RootCmp
    ],
    declarations: [
        RootCmp
    ],
    imports: [
        /* Ng Modules */
        BrowserModule,
        CommonModule, 
        FormsModule,
        ReactiveFormsModule,
        HttpClientModule, //angular5
        HttpModule, //Angular2
        JsonpModule,
        NgbModule.forRoot(),
        UpgradeModule,
        /* User Generated Modules */
        AccountSettingsNg2Module,
        AdminActionsNg2Module,
        AffiliationNg2Module,//Aproved
        AffiliationDeleteNg2Module,//Aproved
        AffiliationFormNg2Module,//Aproved
        AlertBannerNg2Module,
        AllConsortiumContactsNg2Module,
        BiographyNg2Module, //Approved
        ClaimNg2Module,
        ClientEditNg2Module,
        DelegatorsNg2Module,
        EmailsFormNg2Module,//Aproved
        EmailsNg2Module,//Aproved
        EmailUnverifiedWarningNg2Module,//Aproved
        EmailVerificationSentMesssageNg2Module,//Aproved
        ExtIdPopoverNg2Module,
        HeaderNg2Module,
        HomeNg2Module,
        FundingDeleteNg2Module,
        FundingFormNg2Module,
        FundingNg2Module,
        LanguageNg2Module,
        LinkAccountNg2Module,
        MembersListNg2Module, //Approved
        ModalNg2Module, //Approved
        MyOrcidAlertsNg2Module,
        NotificationsNg2Module,
        NotificationAlertsNg2Module,
        PeerReviewNg2Module,
        PeerReviewDeleteNg2Module,
        PersonNg2Module,
        PrintRecordNg2Module,
        PublicRecordNg2Module,
        OauthAuthorizationNg2Module,
        OrgIdentifierPopoverNg2Module,
        ReactivationNg2Module,
        RegisterDuplicatesNg2Module,
        RequestPasswordResetNg2Module,
        ResearchResourceNg2Module,
        ResearchResourceDeleteNg2Module,
        ResendClaimNg2Module,
        ResetPasswordNg2Module,
        SearchNg2Module, //Approved
        SelfServiceNg2Module, //Approved
        SelfServiceAddContactNg2Module, //Approved
        SelfServiceExistingSubMemberNg2Module, //Approved
        SelfServiceRemoveContactNg2Module, //Approved
        SelfServiceRemoveSubMemberNg2Module, //Approved
        Social2FANg2Module,
        TwoFaSetupNg2Module,
        UnsubscribeNg2Module,
        WidgetNg2Module, //Approved
        WorksBulkDeleteNg2Module,
        WorksDeleteNg2Module,
        WorksFormNg2Module,
        WorksNg2Module,
        WorksMergeSuggestionsNg2Module,
        ManageMembersNg2Module,
        DeveloperToolsNg2Module,
        RecordCorrectionsNg2Module,
        AdminActionsNg2Module,
        RecordCorrectionsNg2Module,
        idBannerNg2Module,
        qrcodeNg2Module,
        lastModifiedNg2Module, 
        bioNg2Module,
        printIdBannerNg2Module
    ],
    providers: [
        { 
            provide: HTTP_INTERCEPTORS,
            useClass: TokenInterceptor,
            multi: true
        }
    ]

})

export class Ng2AppModule {
    constructor( public upgrade: UpgradeModule ){
        console.log('v0.9.23');
    }
}