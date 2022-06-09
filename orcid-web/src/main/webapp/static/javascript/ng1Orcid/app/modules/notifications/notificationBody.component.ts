//Import all the angular components

import { NgIf } 
    from '@angular/common'; 

import { AfterViewInit, Component, ElementRef, Input, OnInit} 
    from '@angular/core';

import { Observable, Subject, Subscription } 
    from 'rxjs';

import { takeUntil ,  catchError, map, tap } 
    from 'rxjs/operators';

import { CommonService } 
    from '../../shared/common.service';

import { NotificationsService } 
    from '../../shared/notifications.service';
    
import { FeaturesService }
    from '../../shared/features.service';    

@Component({
    selector: 'notification-body-ng2',
    template:  scriptTmpl("notification-body-ng2-template"),
})
export class NotificationBodyComponent implements OnInit {
    private ngUnsubscribe: Subject<void> = new Subject<void>();
    private subscription: Subscription;
    
    @Input() notification: any;

    educationsCount: number;
    employmentsCount: number;
    encodedUrl: string;
    fundingsCount: number;
    peerReviewsCount: number;
    worksCount: number;
    elementsModifiedCount: number;
    educationsList: string;
    employmentsList: string;
    fundingsList: string;
    peerReviewsList: string;
    worksList: string;
    addedList: string[];
    updatedList: string[];
    deletedList: string[];
    unknownList: string[];
    MAX_ELEMENTS_TO_SHOW: number;
    showClientDescription: boolean;
    
    constructor(
        private commonService: CommonService,
        private notificationsService: NotificationsService,
        private elementRef: ElementRef,
        private featuresService: FeaturesService,
    ) {
        this.notification = elementRef.nativeElement.getAttribute('notification');
        this.MAX_ELEMENTS_TO_SHOW = 20;
        this.educationsCount = 0;
        this.employmentsCount = 0;
        this.fundingsCount = 0;
        this.peerReviewsCount = 0;
        this.worksCount = 0;
        this.elementsModifiedCount = 0;
        this.educationsList = "";
        this.employmentsList = "";
        this.fundingsList = "";
        this.peerReviewsList = "";
        this.worksList = "";
        this.addedList = [];
        this.updatedList = [];
        this.deletedList = [];
        this.unknownList = [];
        this.showClientDescription = false;
    }

    archive(putCode): void {
        this.notificationsService.notifyOther({action:'archive', putCode:putCode});
    };
    
    toggleClientDescription(): void {
        this.showClientDescription = !this.showClientDescription;
    };

    ngOnInit() {        
        if(this.notification.items) {
            var affiliationTypes = ["DISTINCTION","EDUCATION","EMPLOYMENT","INVITED_POSITION","MEMBERSHIP","QUALIFICATION","SERVICE"];        
            for (let activity of this.notification.items.items) {
                console.log("Activity type: " + activity.actionType)
                if(this.elementsModifiedCount < this.MAX_ELEMENTS_TO_SHOW) {
                    if(activity.actionType == "CREATE") {
                        this.addedList.push(activity);
                    } else if(activity.actionType == "UPDATE") {
                        this.updatedList.push(activity);
                    } else if(activity.actionType == "DELETE") {
                        this.deletedList.push(activity);
                    } else {
                        this.unknownList.push(activity);
                    }
                }
                
                this.elementsModifiedCount++;
                
                if(activity.itemType == "WORK"){
                    this.worksCount++;
                    this.worksList =  this.worksList + "<strong>" + activity.itemName + "</strong>";
                    if(activity.externalIdentifier){
                        this.worksList = this.worksList + " (" + activity.externalIdentifier.type + ": " + activity.externalIdentifier.value + ")";
                    }
                    this.worksList += "<br/>";                                        
                }
                if(activity.itemType == "EMPLOYMENT"){
                    this.employmentsCount++;
                    this.employmentsList =  this.employmentsList + "<strong>" + activity.itemName + "</strong><br/>";
                }
                if(activity.itemType == "EDUCATION"){
                    this.educationsCount++;
                    this.educationsList =  this.educationsList + "<strong>" + activity.itemName + "</strong><br/>";
                }
                if(activity.itemType == "FUNDING"){
                    this.fundingsCount++;
                    this.fundingsList = this.fundingsList + "<strong>" + activity.itemName + "</strong>";
                    if(activity.externalIdentifier){
                        this.fundingsList = this.fundingsList + " (" + activity.externalIdentifier.type + ": " + activity.externalIdentifier.value + ")";
                    }
                    this.fundingsList += "<br/>";
                }
                if(activity.itemType == "PEER_REVIEW"){
                    this.peerReviewsCount++;
                    this.peerReviewsList = this.peerReviewsList + "<strong>" + activity.itemName + "</strong>";
                    if(activity.externalIdentifier){
                        this.peerReviewsList = this.peerReviewsList + " (" + activity.externalIdentifier.type + ": " + activity.externalIdentifier.value + ")";
                    }
                    this.peerReviewsList += "<br/>";
                }
            }
        }
        if (this.notification.authorizationUrl){
            this.encodedUrl = encodeURIComponent(this.notification.authorizationUrl.uri);
        }       
    }; 
    
    getBaseUri() : String {
        return getBaseUri();
    };
}