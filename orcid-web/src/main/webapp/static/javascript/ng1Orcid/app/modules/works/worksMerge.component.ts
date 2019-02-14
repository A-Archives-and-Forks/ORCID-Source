declare var $: any;

//Import all the angular components
import { NgForOf, NgIf } 
    from '@angular/common'; 

import { AfterViewInit, Component, OnDestroy, OnInit } 
    from '@angular/core';

import { Observable, Subject, Subscription } 
    from 'rxjs';

import { takeUntil } 
    from 'rxjs/operators';

import { WorksService } 
    from '../../shared/works.service.ts';

import { ModalService } 
    from '../../shared/modal.service.ts'; 

@Component({
    selector: 'works-merge-ng2',
    template:  scriptTmpl("works-merge-ng2-template")
})
export class WorksMergeComponent implements AfterViewInit, OnDestroy, OnInit {
    private ngUnsubscribe: Subject<void> = new Subject<void>();
    private subscription: Subscription;

    mergeCount: any;
    mergeSubmit: boolean;
    showWorksMergeError: boolean;
    worksToMerge: Array<any>;
    externalIdsPresent: boolean;
    groupingSuggestion: any;

    constructor(
        private worksService: WorksService,
        private modalService: ModalService
    ) {
        this.mergeSubmit = false;
        this.groupingSuggestion = false;
        this.showWorksMergeError = false;
    }

    cancelEdit(): void {
        this.mergeSubmit = false;
        this.modalService.notifyOther({action:'close', moduleId: 'modalWorksMerge'});
    };

    mergeConfirm(): void {
        if(this.worksToMerge.length > 20){
            this.worksService.notifyOther({worksToMerge:this.worksToMerge});       
            this.worksService.notifyOther({mergeCount:this.mergeCount});
            this.modalService.notifyOther({action:'close', moduleId: 'modalWorksMerge'});   
            this.modalService.notifyOther({action:'open', moduleId: 'modalWorksMergeWarning'});   
        } else {
            this.merge();
        }
    };

    merge(): void {
        var putCodesAsString = '';      
        for (var i in this.worksToMerge) {
            var workToMerge = this.worksToMerge[i];
            putCodesAsString += workToMerge.putCode.value;
            if(Number(i) < (this.worksToMerge.length-1)){
                putCodesAsString += ',';
            }
        }
        this.worksService.mergeWorks(putCodesAsString)
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                this.worksService.notifyOther({action:'merge', successful:true});
                this.modalService.notifyOther({action:'close', moduleId: 'modalWorksMerge'});
            },
            error => {
                this.showWorksMergeError = true;
                console.log('error calling mergeWorks', error);
            } 
        );
    };

    rejectSuggestion(): void {
        this.worksService.markSuggestionRejected(this.groupingSuggestion)
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        ).subscribe(
            data => {
                this.modalService.notifyOther({action:'close', moduleId: 'modalWorksMerge'});
                this.worksService.notifyOther({action:'cancel', successful:true});
            },
            error => {
                console.log('error marking suggestion as rejected', error);
            } 
        );
    };

    //Default init functions provided by Angular Core
    ngAfterViewInit() {
        //Fire functions AFTER the view inited. Useful when DOM is required or access children directives
        this.subscription = this.worksService.notifyObservable$.pipe(    
            takeUntil(this.ngUnsubscribe)
        ).subscribe(
            (res) => {
                if( res.mergeCount ) {
                    this.mergeCount = res.mergeCount;
                }
                if( res.worksToMerge ) {
                    this.worksToMerge = res.worksToMerge;
                }
                if( res.externalIdsPresent != undefined ) {
                    this.externalIdsPresent = res.externalIdsPresent;
                }
                if( res.groupingSuggestion ) {
                    this.groupingSuggestion = res.groupingSuggestion.suggestions[0];
                }
            }
        )
    };

    ngOnDestroy() {
        this.ngUnsubscribe.next();
        this.ngUnsubscribe.complete();
    };

    ngOnInit() {
    }; 
}
