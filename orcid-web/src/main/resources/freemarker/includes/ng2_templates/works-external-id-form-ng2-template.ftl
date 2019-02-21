<#--

    =============================================================================

    ORCID (R) Open Source
    http://orcid.org

    Copyright (c) 2012-2014 ORCID, Inc.
    Licensed under an MIT-Style License (MIT)
    http://orcid.org/open-source-license

    This copyright and license information (including a link to the full license)
    shall be included in its entirety in all copies or substantial portion of
    the software.

    =============================================================================

-->

<script type="text/ng-template" id="works-external-id-form-ng2-template">
    <div class="add-work colorbox-content externalIdWorkForm" *ngIf="externalIdType">
            <div class="lightbox-container-ie7"> 
                <div class="row">           
                    <div class="col-md-9 col-sm-8 col-xs-9">    
                        <h1 class="lightbox-title pull-left">
                            <div>
                                <@orcid.msg 'manual_work_form_contents.add_work'/>
                            </div>
                        </h1>
                    </div>          
                </div>
                <div class="row">           
                    <i class="glyphicon glyphicon-refresh spin x4 green" id="spinner"  *ngIf="loading" style="margin-left: 15px; margin-top: 31px;"></i> 
                    <div class="col-md-9 col-sm-8 col-xs-9" *ngIf="!loading">    
                        <strong><@orcid.msg 'externalwork.addworkfrom' /> {{externalIdType}}</strong>
                        <div> <@orcid.msg 'externalwork.typeorpaste'/> {{externalIdType}} <@orcid.msg 'externalwork.typeorpaste2'/></div>

                        <input tabindex="1" #search (keydown)="onKeydown($event, 'work')" id="work-title" name="familyNames" type="text" class="form-control" [(ngModel)]="externalId[externalIdType].value" placeholder="{{externalId[externalIdType].placeHolder}}"/>
                        <div class="orcid-error" *ngIf="metadataNotFound">
                        
                            <@orcid.msg 'externalwork.error'/> {{externalIdType}}.
                        </div>
                        <div class="buttons-container">
                            <button tabindex="2" class="btn btn-primary" (click)="addWork()" [disabled]="addingWork" [ngClass]="{disabled:addingWork}">
                               <@orcid.msg 'externalwork.retrieve'/>
                                <!--  <@orcid.msg 'freemarker.btnsave'/>  -->
                            </button>
                            <a tabindex="3" class="cancel-option" (click)="cancelEdit()" (keydown)="onKeydown($event, 'cancel')"><@orcid.msg 'freemarker.btncancel' /></a>
                        </div>
                    </div>          
                </div>
            </div>
    </div> 
</script>