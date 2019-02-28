declare var $: any
declare var orcidGA: any;
declare var orcidVar: any

//Import all the angular components

import { NgForOf, NgIf } 
    from '@angular/common'; 

import { AfterViewInit, Component, EventEmitter, Input, OnChanges, OnDestroy, OnInit, Output, NgZone } 
    from '@angular/core';

import { Observable, Subject, Subscription } 
    from 'rxjs';
import { takeUntil } 
    from 'rxjs/operators';

import { DiscoService } 
    from '../../shared/disco.service.ts'; 

import { OauthService } 
    from '../../shared/oauth.service.ts'; 

import { WidgetService } 
    from '../../shared/widget.service.ts'; 


@Component({
    selector: 'link-account-ng2',
    template:  scriptTmpl("link-account-ng2-template")
})
export class LinkAccountComponent implements AfterViewInit, OnDestroy, OnInit {
    private ngUnsubscribe: Subject<void> = new Subject<void>();

    //@Input() entityId: any;

    authorizationForm: any;
    entityId: any;
    feed: any;
    gaString: string;
    loadedFeed: boolean;
    idpName: string;
    requestInfoForm: any;
    showDeactivatedError: any;
    showReactivationSent: any;
    initReactivationRequest: any;
   
    constructor(
        private zone:NgZone,
        private discoService: DiscoService,
        private oauthService: OauthService,
        private widgetService: WidgetService
    ) {
        window['angularComponentReference'] = {
                zone: this.zone,
                showDeactivationError: () => this.showDeactivationError(),
                component: this,
            };
        this.authorizationForm = {};
        this.entityId = orcidVar.providerId;
        this.gaString = "";
        this.loadedFeed = false;
        this.idpName = "";
        this.requestInfoForm = {};
        this.showDeactivatedError = false;
        this.showReactivationSent = false;
        this.initReactivationRequest = { "email":null, "error":null, "success":false };
    }

    loadDiscoFeed = function() {
        this.discoService.getDiscoFeed()
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                this.feed = data;
                this.idpName = this.discoService.getIdpName(this.entityId, this.feed, this.widgetService.getLocale());
                this.loadedFeed = true;
            },
            error => {
                console.log('Error getting disco feed');
                this.feed = [];
                this.idpName = this.discoService.getIdpName(this.entityId, this.feed, this.widgetService.getLocale());
                this.loadedFeed = true;
            } 
        );
    };

    setEntityId(entityId): void {
        this.entityId = entityId;
    };

    loadRequestInfoForm = function() {
        this.oauthService.loadRequestInfoForm()
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                if(data){                     
                    this.requestInfoForm = data;              
                    this.gaString = orcidGA.buildClientString(this.requestInfoForm.memberName, this.requestInfoForm.clientName);
                }
            },
            error => {
                console.log('Error loading request info form');
            } 
        );
    };

    showDeactivationError(): void {
        this.showDeactivatedError = true;
        this.showReactivationSent = false;        
        if(this.authorizationForm.userName.value != null && this.authorizationForm.userName.value.includes('@')) {
            this.initReactivationRequest.email = this.authorizationForm.userName.value;            
        } else {
            this.initReactivationRequest.email = '';
        }
    };
    
    sendReactivationEmail(): void {
        this.oauthService.sendReactivationEmail(this.initReactivationRequest.email)
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                this.initReactivationRequest = data;
                if(this.initReactivationRequest.error == null || this.initReactivationRequest.error == '') {
                    this.showDeactivatedError = false;
                    this.showReactivationSent = true;                    
                } else {
                    this.showDeactivatedError = true;
                    this.showReactivationSent = false;                    
                }
            },
            error => {
                console.log("error sending reactivation email");
            } 
        );
    };
    
    //Default init functions provided by Angular Core
    ngAfterViewInit() {
        //Fire functions AFTER the view inited. Useful when DOM is required or access children directives
    };

    ngOnDestroy() {
        this.ngUnsubscribe.next();
        this.ngUnsubscribe.complete();
    };

    ngOnInit() {
        this.loadRequestInfoForm();
        this.authorizationForm = {
            userName:  {value: ""}
        } 
        this.setEntityId(this.entityId);

        if(this.entityId === "facebook" || this.entityId === "google"){
            this.idpName = this.entityId.charAt(0).toUpperCase() + this.entityId.slice(1);
            this.loadedFeed = true;
        } else {
            this.loadDiscoFeed();
        }       
    }; 
}