import { NgForOf, NgIf } 
    from '@angular/common';

import { AfterViewInit, Component, OnDestroy, OnInit } 
    from '@angular/core';

import { Observable, Subject, Subscription } 
    from 'rxjs';
import { takeUntil } 
    from 'rxjs/operators';

import { ConsortiaService }
    from '../../shared/consortia.service.ts';

import { ModalService } 
    from '../../shared/modal.service.ts'; 

@Component({
    selector: 'self-service-remove-sub-member-ng2',
    template:  scriptTmpl("self-service-remove-sub-member-ng2-template")
})
export class SelfServiceRemoveSubMemberComponent {
    
    private subscription: Subscription;
    private subMember: any;

    constructor(
        private consortiaService: ConsortiaService,
        private modalService: ModalService
    ) { }
    
    removeSubMember(subMember: any): void {
        this.consortiaService.removeSubMember(subMember)
            .subscribe(
                data => {
                    this.consortiaService.notifyOther({action:'close', moduleId: 'selfServiceRemoveSubMember'});
                    this.closeModal();
                },
                error => {
                    //console.log('removeSubMember error', error);
                } 
        );
    }

    closeModal(): void {
        this.modalService.notifyOther({action:'close', moduleId: 'modalSelfServiceRemoveSubMember'});
    };
    
    ngOnInit() {
        this.subscription = this.modalService.notifyObservable$.subscribe(
            (res) => { this.subMember = res.subMember; }
        );
    };

}
