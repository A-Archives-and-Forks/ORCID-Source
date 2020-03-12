<script type="text/ng-template" id="affiliation-ng2-template">
    <div [hidden]="publicView == 'true' && recordLocked">
        <!-- EMPLOYMENT -->
        <div id="workspace-employment" class="workspace-accordion-item workspace-accordion-active" [hidden]="publicView == 'true' && employments.length < 1" role="group" aria-labelledby="affiliationType.employment" aria-describedby="tooltip-helpPopoverEmployment">
            <div class="workspace-accordion-header clearfix" role="presentation">
                <div class="row" role="banner">
                    <div class="col-md-6 col-sm-6 col-xs-12 affiliation-heading" role="presentation">
                        <a (click)="workspaceSrvc.toggleEmployment()" class="toggle-text">
                            <i role="presentation" class="glyphicon-chevron-down glyphicon x075" [ngClass]="{'glyphicon-chevron-right':workspaceSrvc.displayEmployment==false}"></i>
                            <h2 id="affiliationType.employment" ><@orcid.msg 'org.orcid.jaxb.model.message.AffiliationType.employment'/> (<span>{{employments.length}}</span>)</h2>
                        </a>
                        <div role="presentation" *ngIf="!isPublicPage" class="popover-help-container">
                            <i class="glyphicon glyphicon-question-sign" role="presentation"></i>
                            <div id="employment-help" class="popover bottom" role="presentation">
                                <div class="arrow" role="presentation"></div>
                                <div class="popover-content" role="tooltip" id="tooltip-helpPopoverEmployment">
                                    <p><strong><@orcid.msg 'manage_affiliations_settings.helpPopoverEmployment_1'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverEmployment_2'/><br>
                                    <a href="<@orcid.msg 'common.kb_uri_default'/>360006897694" target="manage_affiliations_settings.helpPopoverEmployment"><@orcid.msg 'common.learn_more'/></a></p>
                                </div>
                            </div>
                        </div>                   
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 action-button-bar" *ngIf="workspaceSrvc.displayEmployment" role="presentation">
                        <#escape x as x?html>                        
                        <div class="menu-container" role="presentation">                                     
                            <ul class="toggle-menu" role="menu" >
                                <li>
                                    <span id="manual_orcid_record_contents.sort" class="glyphicon glyphicon-sort" role="presentation"></span>                          
                                    <@orcid.msg 'manual_orcid_record_contents.sort'/>
                                    <ul class="menu-options sort">
                                        <li [ngClass]="{'checked':sortDisplayKeyEmployments=='startDate'}" role="menu-item">                                         
                                            <a (click)="sort('employment', 'startDate', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_start_date'/>
                                                <span *ngIf="sortDisplayKeyEmployments=='startDate' && sortAscEmployments==false" [ngClass]="{'glyphicon glyphicon-sort-by-order-alt':sortDisplayKeyEmployments=='startDate'}"></span>
                                                <span *ngIf="sortDisplayKeyEmployments=='startDate' && sortAscEmployments==true" [ngClass]="{'glyphicon glyphicon-sort-by-order':sortDisplayKeyEmployments=='startDate'}"></span>
                                            </a>                                                                                    
                                        </li>
                                        <li [ngClass]="{'checked':sortDisplayKeyEmployments=='endDate'}"  role="menu-item">
                                            <a (click)="sort('employment', 'endDate', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_end_date'/>
                                                <span *ngIf="sortDisplayKeyEmployments=='endDate' && sortAscEmployments==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyEmployments=='endDate'}" ></span>
                                                <span *ngIf="sortDisplayKeyEmployments=='endDate' && sortAscEmployments==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyEmployments=='endDate'}" ></span>
                                            </a>                                            
                                        </li>
                                        <li [ngClass]="{'checked':sortDisplayKeyEmployments=='title'}"  role="menu-item">                                            
                                            <a (click)="sort('employment', 'title', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_title'/>
                                                <span *ngIf="sortDisplayKeyEmployments=='title' && sortAscEmployments==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyEmployments=='title'}" ></span>
                                                <span *ngIf="sortDisplayKeyEmployments=='title' && sortAscEmployments==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyEmployments=='title'}" ></span>
                                            </a>                                            
                                        </li>                                            
                                    </ul>                                        
                                </li>
                            </ul>                                   
                        </div>
                        </#escape>
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu" role="presentation">
                            <li class="hidden-xs" role="presentation">                  
                                <div class="menu-container" id="add-employment-container" role="presentation">
                                    <ul class="toggle-menu" role="menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}" (click)="addAffiliationModal('employment')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_employment' />    
                                        </li>
                                    </ul>
                                </div>         
                            </li>                            
                            <li role="presentation" class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">                     
                                <a role="menu-item" class="action-option manage-button two-options" (click)="addAffiliationModal('employment')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_employment' />  
                                </a>                
                            </li>
                        </ul>                                  
                    </div>
                </div>
            </div>                        
            <div *ngIf="workspaceSrvc.displayEmployment" class="workspace-accordion-content">
                <div id="employments-empty" *ngIf="!employments?.length">
                    <strong>                               
                        <@orcid.msg 'workspace_affiliations_body_list.Noemploymentaddedyet' />
                        <a (click)="addAffiliationModal('employment')"><@orcid.msg 'workspace_affiliations_body_list.addemploymentnow' /></a>
                    </strong>
                </div>
                <ul id="employments-list" *ngIf="employments?.length > 0" class="workspace-affiliations bottom-margin-medium" id="body-employment-list">
                    <li class="bottom-margin-small workspace-border-box card" *ngFor="let group of (employments | orderByAffiliations: sortKeyEmployments:sortAscEmployments)" [attr.employment-put-code]="group?.defaultAffiliation?.putCode.value">
                        <#include "affiliation-details-ng2.ftl"/>                      
                    </li>
                </ul>
            </div>                                                  
        </div>        
        <!-- EDUCATION AND QUALIFICATION -->
        <div id="workspace-education" class="workspace-accordion-item workspace-accordion-active" [hidden]="publicView == 'true' && educationsAndQualifications.length < 1" role="group" aria-labelledby="affiliationType.education_qualification" aria-describedby="tooltip-helpPopoverEducationAndQualification">
            <div class="workspace-accordion-header clearfix" role="presentation">
                <div class="row" role="banner">                    
                    <div class="col-md-6 col-sm-6 col-xs-12 affiliation-heading" role="presentation">
                        <a name='workspace-educations-qualifications'></a>
                        <a (click)="workspaceSrvc.toggleEducation();workspaceSrvc.toggleEducationAndQualification();" class="toggle-text">
                            <i class="glyphicon-chevron-down glyphicon x075" [ngClass]="{ 'glyphicon-chevron-right': displayEducationAndQualification()==false }"></i>                               
                            <h2 id="affiliationType.education_qualification"><@orcid.msg 'org.orcid.jaxb.model.message.AffiliationType.education_qualification'/> (<span>{{educationsAndQualifications.length}}</span>)</h2>
                        </a>    
                        <div *ngIf="!isPublicPage" class="popover-help-container" role="presentation">
                            <i class="glyphicon glyphicon-question-sign" role="presentation"></i>
                            <div id="education-qualification-help" class="popover bottom" role="presentation">
                                <div class="arrow" role="presentation"></div>
                                <div class="popover-content" id="tooltip-helpPopoverEducationAndQualification">
                                    <p><strong><@orcid.msg 'manage_affiliations_settings.helpPopoverEducationAndQualification_1'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverEducationAndQualification_2'/><br>
                                    <strong><@orcid.msg 'manage_affiliations_settings.helpPopoverEducationAndQualification_3'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverEducationAndQualification_4'/><br>
                                    <a href="<@orcid.msg 'common.kb_uri_default'/>360006973933" target="manage_affiliations_settings.helpPopoverEducationAndQualification"><@orcid.msg 'common.learn_more'/></a></p>
                                </div>
                            </div>
                        </div>  
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 action-button-bar" *ngIf="displayEducationAndQualification()" role="presentation">
                        <#escape x as x?html>
                            <div class="menu-container" role="presentation">   
                                <ul class="toggle-menu" role="menu">
                                    <li>
                                        <span class="glyphicon glyphicon-sort"></span>                          
                                        <@orcid.msg 'manual_orcid_record_contents.sort'/>
                                        <ul class="menu-options sort">
                                            <li [ngClass]="{'checked':sortDisplayKeyEducations=='startDate'}">                                         
                                                <a (click)="sort('education', 'startDate', true);" class="action-option manage-button">
                                                    <@orcid.msg 'manual_orcid_record_contents.sort_start_date'/>
                                                    <span *ngIf="sortDisplayKeyEducations=='startDate' && sortAscEducations==false" [ngClass]="{'glyphicon glyphicon-sort-by-order-alt':sortDisplayKeyEducations=='startDate'}"></span>
                                                    <span *ngIf="sortDisplayKeyEducations=='startDate' && sortAscEducations==true" [ngClass]="{'glyphicon glyphicon-sort-by-order':sortDisplayKeyEducations=='startDate'}"></span>
                                                </a>                                                                                    
                                            </li>
                                            <li [ngClass]="{'checked':sortDisplayKeyEducations=='endDate'}">
                                                <a (click)="sort('education', 'endDate', true);" class="action-option manage-button">
                                                    <@orcid.msg 'manual_orcid_record_contents.sort_end_date'/>
                                                    <span *ngIf="sortDisplayKeyEducations=='endDate' && sortAscEducations==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyEducations=='endDate'}" ></span>
                                                    <span *ngIf="sortDisplayKeyEducations=='endDate' && sortAscEducations==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyEducations=='endDate'}" ></span>
                                                </a>                                            
                                            </li>
                                            <li [ngClass]="{'checked':sortDisplayKeyEducations=='title'}">                                            
                                                <a (click)="sort('education', 'title', true);" class="action-option manage-button">
                                                    <@orcid.msg 'manual_orcid_record_contents.sort_title'/>
                                                    <span *ngIf="sortDisplayKeyEducations=='title' && sortAscEducations==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyEducations=='title'}" ></span>
                                                    <span *ngIf="sortDisplayKeyEducations=='title' && sortAscEducations==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyEducations=='title'}" ></span>
                                                </a>                                            
                                            </li>                                            
                                        </ul> 
                                    </li>
                                </ul>                                   
                            </div>
                        </#escape>               
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu" role="menu">      
                            <li class="hidden-xs">                  
                                <div class="menu-container" id="add-education-container">
                                    <ul class="toggle-menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}"  (click)="addAffiliationModal('education')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_education'/>    
                                        </li>
                                    </ul>
                                </div>         
                            </li>
                            <li class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">          
                                <a class="action-option manage-button two-options" (click)="addAffiliationModal('education')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_education' />  
                                </a>
                            </li>
                        </ul>
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu" role="menu">      
                            <li class="hidden-xs">                  
                                <div class="menu-container" id="add-qualification-container">
                                    <ul class="toggle-menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}" (click)="addAffiliationModal('qualification')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_qualification'/>    
                                        </li>
                                    </ul>
                                </div>         
                            </li>
                            <li class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">          
                                <a class="action-option manage-button two-options" (click)="addAffiliationModal('qualification')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_qualification' />  
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>            
            <div *ngIf="workspaceSrvc.displayEducation || workspaceSrvc.displayEducationAndQualification" class="workspace-accordion-content"> 
                <div id="educations-distinctions-empty" *ngIf="!educationsAndQualifications?.length && workspaceSrvc?.displayEducationAndQualification">
                    <strong>                              
                        <@orcid.msg 'workspace_affiliations_body_list.Noeducationnorqualificationaddedyet' />
                        <a (click)="addAffiliationModal('education')"><@orcid.msg 'workspace_affiliations_body_list.addeducationnow' /></a>
                        <@orcid.msg 'common.or_a' />
                        <a (click)="addAffiliationModal('qualification')"><@orcid.msg 'workspace_affiliations_body_list.addqualificationnow' /></a>
                    </strong>
                </div>
                <ul id="educations-distinctions-list" *ngIf="educationsAndQualifications?.length" class="workspace-affiliations bottom-margin-medium" id="body-education-list">
                    <li class="bottom-margin-small workspace-border-box card ng-scope" *ngFor="let group of (educationsAndQualifications | orderByAffiliations: sortKeyEducations:sortAscEducations)" [attr.education-distinction-put-code]="group?.defaultAffiliation?.putCode.value">
                        <#include "affiliation-details-ng2.ftl"/> 
                    </li>
                </ul>
            </div>
        </div>
        <!-- INVITED POSITION AND DISTINCTION -->
        <div id="workspace-distinction-invited-position" class="workspace-accordion-item workspace-accordion-active" [hidden]="publicView == 'true' && distinctionsAndInvitedPositions.length < 1" role="group" aria-labelledby="affiliationType.distinction_invited_position" aria-describedby="tooltip-helpPopoverDistinctionAndInvitedPosition">
            <div class="workspace-accordion-header clearfix">
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12 affiliation-heading">
                        <a name='workspace-distinction-invited-position'></a>
                        <a role="presentation" (click)="workspaceSrvc.toggleDistinctionAndInvitedPosition($event)" class="toggle-text">
                            <i class="glyphicon-chevron-down glyphicon x075" [ngClass]="{'glyphicon-chevron-right':workspaceSrvc.displayDistinctionAndInvitedPosition==false}"></i>
                            <h2 id="affiliationType.distinction_invited_position"><@orcid.msg 'org.orcid.jaxb.model.message.AffiliationType.distinction_invited_position'/> (<span>{{distinctionsAndInvitedPositions.length}}</span>)</h2>
                        </a>
                        <div role="presentation" *ngIf="!isPublicPage" class="popover-help-container">
                            <i role="presentation"class="glyphicon glyphicon-question-sign"></i>
                            <div role="presentation"id="distinction-invited-position-help" class="popover bottom">
                                <div class="arrow" role="presentation"></div>
                                <div id="tooltip-helpPopoverDistinctionAndInvitedPosition" class="popover-content">
                                    <p><strong><@orcid.msg 'manage_affiliations_settings.helpPopoverDistinctionAndInvitedPosition_1'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverDistinctionAndInvitedPosition_2'/><br>
                                    <strong><@orcid.msg 'manage_affiliations_settings.helpPopoverDistinctionAndInvitedPosition_3'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverDistinctionAndInvitedPosition_4'/><br>
                                    <a href="<@orcid.msg 'common.kb_uri_default'/>360008897654" target="manage_affiliations_settings.helpPopoverDistinctionAndInvitedPosition"><@orcid.msg 'common.learn_more'/></a></p>
                                </div>
                            </div>
                        </div>                   
                    </div>
                    <div  role="presentation" class="col-md-6 col-sm-6 col-xs-12 action-button-bar" *ngIf="workspaceSrvc.displayDistinctionAndInvitedPosition">
                        <#escape x as x?html>                            
                        <div role="presentation" class="menu-container">                                     
                            <ul  role="presentation"class="toggle-menu">
                                <li>
                                    <span class="glyphicon glyphicon-sort"></span>                          
                                    <@orcid.msg 'manual_orcid_record_contents.sort'/>
                                    <ul class="menu-options sort" role="menu">
                                        <li [ngClass]="{'checked':sortDisplayKeyDistinctions=='startDate'}">                                         
                                            <a (click)="sort('distinction_invited_position', 'startDate', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_start_date'/>
                                                <span *ngIf="sortDisplayKeyDistinctions=='startDate' && sortAscDistinctions==false" [ngClass]="{'glyphicon glyphicon-sort-by-order-alt':sortDisplayKeyDistinctions=='startDate'}"></span>
                                                <span *ngIf="sortDisplayKeyDistinctions=='startDate' && sortAscDistinctions==true" [ngClass]="{'glyphicon glyphicon-sort-by-order':sortDisplayKeyDistinctions=='startDate'}"></span>
                                            </a>                                                                                    
                                        </li>
                                        <li [ngClass]="{'checked':sortDisplayKeyDistinctions=='endDate'}">
                                            <a (click)="sort('distinction_invited_position', 'endDate', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_end_date'/>
                                                <span *ngIf="sortDisplayKeyDistinctions=='endDate' && sortAscDistinctions==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyDistinctions=='endDate'}" ></span>
                                                <span *ngIf="sortDisplayKeyDistinctions=='endDate' && sortAscDistinctions==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyDistinctions=='endDate'}" ></span>
                                            </a>                                            
                                        </li>
                                        <li [ngClass]="{'checked':sortDisplayKeyDistinctions=='title'}">                                            
                                            <a (click)="sort('distinction_invited_position', 'title', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_title'/>
                                                <span *ngIf="sortDisplayKeyDistinctions=='title' && sortAscDistinctions==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyDistinctions=='title'}" ></span>
                                                <span *ngIf="sortDisplayKeyDistinctions=='title' && sortAscDistinctions==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyDistinctions=='title'}" ></span>
                                            </a>                                            
                                        </li>                                            
                                    </ul>                                           
                                </li>
                            </ul>                                   
                        </div>
                        </#escape>                                           
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu" role="menu">
                            <li class="hidden-xs">                  
                                <div class="menu-container" id="add-distinction-container">
                                    <ul class="toggle-menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}" (click)="addAffiliationModal('distinction')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_distinction' />
                                        </li>
                                    </ul>
                                </div>
                            </li>                                    
                            <li class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">                     
                                <a class="action-option manage-button two-options" (click)="addAffiliationModal('distinction')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_distinction' />  
                                </a>                
                            </li>
                        </ul>
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu" role="menu">
                            <li class="hidden-xs">                  
                                <div class="menu-container" id="add-invited-position-container">
                                    <ul class="toggle-menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}"  (click)="addAffiliationModal('invited-position')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_invited_position' />
                                        </li>
                                    </ul>
                                </div>         
                            </li>                                   
                            <li class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">                     
                                <a class="action-option manage-button two-options" (click)="addAffiliationModal('invited-position')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_invited_position' />  
                                </a>                
                            </li>
                        </ul>                                       
                    </div>
                </div>
            </div>                        
            <div *ngIf="workspaceSrvc.displayDistinctionAndInvitedPosition" class="workspace-accordion-content">
                <div id="distinction-invited-position-empty" *ngIf="!distinctionsAndInvitedPositions?.length">
                    <strong>                              
                        <@orcid.msg 'workspace_affiliations_body_list.Nodistinctionorinvitedpositionaddedyet' />
                        <a (click)="addAffiliationModal('invited-position')"><@orcid.msg 'workspace_affiliations_body_list.addinvitedpositionnow' /></a>
                        <@orcid.msg 'common.or_a' />
                        <a (click)="addAffiliationModal('distinction')"><@orcid.msg 'workspace_affiliations_body_list.adddistinctionnow' /></a>
                    </strong>
                </div>
                <ul id="distinction-invited-position-list" *ngIf="distinctionsAndInvitedPositions?.length > 0" class="workspace-affiliations bottom-margin-medium" id="body-distinction-list">
                    <li class="bottom-margin-small workspace-border-box card" *ngFor="let group of (distinctionsAndInvitedPositions | orderByAffiliations: sortKeyDistinctions:sortAscDistinctions)" [attr.distinction-invited-position-put-code]="group?.defaultAffiliation?.putCode.value">
                        <#include "affiliation-details-ng2.ftl"/>          
                    </li>
                </ul>
            </div>                                                  
        </div>       
        <!-- MEMBERSHIP AND SERVICE -->
        <div id="workspace-membership-service" class="workspace-accordion-item workspace-accordion-active" [hidden]="publicView == 'true' && membershipsAndServices.length < 1"  role="group" aria-labelledby="affiliationType.membership_service" aria-describedby="tooltip-tooltip-helpPopoverMembershipAndService">
            <div class="workspace-accordion-header clearfix">
                <div class="row">
                    <div class="col-md-6 col-sm-6 col-xs-12 affiliation-heading">
                        <a name='workspace-membership-service'></a>
                        <a (click)="workspaceSrvc.toggleMembershipAndService()" class="toggle-text">
                            <i class="glyphicon-chevron-down glyphicon x075" [ngClass]="{'glyphicon-chevron-right':workspaceSrvc.displayMembershipAndService==false}"></i>
                            <h2 id="affiliationType.membership_service" ><@orcid.msg 'org.orcid.jaxb.model.message.AffiliationType.membership_service'/> (<span>{{membershipsAndServices.length}}</span>) </h2>
                        </a>
                        <div *ngIf="!isPublicPage" class="popover-help-container">
                            <i class="glyphicon glyphicon-question-sign"></i>
                            <div id="membership-service-help" class="popover bottom">
                                <div class="arrow"></div>
                                <div class="popover-content" id="tooltip-helpPopoverMembershipAndService">
                                    <p><strong><@orcid.msg 'manage_affiliations_settings.helpPopoverMembershipAndService_1'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverMembershipAndService_2'/><br>
                                    <strong><@orcid.msg 'manage_affiliations_settings.helpPopoverMembershipAndService_3'/></strong> <@orcid.msg 'manage_affiliations_settings.helpPopoverMembershipAndService_4'/><br>
                                    <a href="<@orcid.msg 'common.kb_uri_default'/>360008897694" target="manage_affiliations_settings.helpPopoverMembershipAndService"><@orcid.msg 'common.learn_more'/></a></p>
                                </div>
                            </div>
                        </div>                    
                    </div>
                    <div class="col-md-6 col-sm-6 col-xs-12 action-button-bar" *ngIf="workspaceSrvc.displayMembershipAndService">
                        <#escape x as x?html>                            
                        <div class="menu-container">                                     
                            <ul class="toggle-menu">
                                <li>
                                    <span class="glyphicon glyphicon-sort"></span>                          
                                    <@orcid.msg 'manual_orcid_record_contents.sort'/>
                                    <ul class="menu-options sort">
                                        <li [ngClass]="{'checked':sortDisplayKeyMemberships=='startDate'}">                                         
                                            <a (click)="sort('membership_service', 'startDate', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_start_date'/>
                                                <span *ngIf="sortDisplayKeyMemberships=='startDate' && sortAscMemberships==false" [ngClass]="{'glyphicon glyphicon-sort-by-order-alt':sortDisplayKeyMemberships=='startDate'}"></span>
                                                <span *ngIf="sortDisplayKeyMemberships=='startDate' && sortAscMemberships==true" [ngClass]="{'glyphicon glyphicon-sort-by-order':sortDisplayKeyMemberships=='startDate'}"></span>
                                            </a>                                                                                    
                                        </li>
                                        <li [ngClass]="{'checked':sortDisplayKeyMemberships=='endDate'}">
                                            <a (click)="sort('membership_service', 'endDate', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_end_date'/>
                                                <span *ngIf="sortDisplayKeyMemberships=='endDate' && sortAscMemberships==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyMemberships=='endDate'}" ></span>
                                                <span *ngIf="sortDisplayKeyMemberships=='endDate' && sortAscMemberships==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyMemberships=='endDate'}" ></span>
                                            </a>                                            
                                        </li>
                                        <li [ngClass]="{'checked':sortDisplayKeyMemberships=='title'}">                                            
                                            <a (click)="sort('membership_service', 'title', true);" class="action-option manage-button">
                                                <@orcid.msg 'manual_orcid_record_contents.sort_title'/>
                                                <span *ngIf="sortDisplayKeyMemberships=='title' && sortAscMemberships==false" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet-alt':sortDisplayKeyMemberships=='title'}" ></span>
                                                <span *ngIf="sortDisplayKeyMemberships=='title' && sortAscMemberships==true" [ngClass]="{'glyphicon glyphicon-sort-by-alphabet':sortDisplayKeyMemberships=='title'}" ></span>
                                            </a>                                            
                                        </li>                                            
                                    </ul>                                          
                                </li>
                            </ul>                                   
                        </div>
                        </#escape>                                           
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu">
                            <li class="hidden-xs">                  
                                <div class="menu-container" id="add-membership-container">
                                    <ul class="toggle-menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}"  (click)="addAffiliationModal('membership')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_membership' />
                                        </li>
                                    </ul>
                                </div>
                            </li>                                    
                            <li class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">                     
                                <a class="action-option manage-button two-options" (click)="addAffiliationModal('membership')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_membership' />  
                                </a>                
                            </li>
                        </ul>
                        <ul *ngIf="!isPublicPage" class="workspace-bar-menu">
                            <li class="hidden-xs">                  
                                <div class="menu-container" id="add-service-container">
                                    <ul class="toggle-menu">
                                        <li [ngClass]="{'green-bg' : showBibtexImportWizard == true}" (click)="addAffiliationModal('service')">       
                                            <span class="glyphicon glyphicon-plus"></span>
                                            <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_service' />
                                        </li>
                                    </ul>
                                </div>         
                            </li>                                   
                            <li class="affiliations-mobile hidden-md hidden-sm visible-xs-inline">                     
                                <a class="action-option manage-button two-options" (click)="addAffiliationModal('service')">
                                    <span class="glyphicon glyphicon-plus"></span>
                                    <@orcid.msgCapFirst 'manual_affiliation_form_contents.add_service' />  
                                </a>                
                            </li>
                        </ul>                                      
                    </div>
                </div>
            </div>                        
            <div *ngIf="workspaceSrvc.displayMembershipAndService" class="workspace-accordion-content">
                <div id="membership-service-empty" *ngIf="!membershipsAndServices?.length">
                    <strong>                              
                        <@orcid.msg 'workspace_affiliations_body_list.Nomembershiporserviceaddedyet' />
                        <a (click)="addAffiliationModal('membership')"><@orcid.msg 'workspace_affiliations_body_list.addmembershipnow' /></a>
                        <@orcid.msg 'common.or' />
                        <a (click)="addAffiliationModal('service')"><@orcid.msg 'workspace_affiliations_body_list.addservicenow' /></a>
                    </strong>
                </div>
                <ul id="membership-service-list" *ngIf="membershipsAndServices?.length > 0" class="workspace-affiliations bottom-margin-medium" id="body-membership-list">
                    <li class="bottom-margin-small workspace-border-box card" *ngFor="let group of (membershipsAndServices | orderByAffiliations: sortKeyMemberships:sortAscMemberships)" [attr.membership-service-put-code]="group?.defaultAffiliation?.putCode.value">
                        <#include "affiliation-details-ng2.ftl"/>            
                    </li>
                </ul>
            </div>                                                  
        </div>
    </div>
</script>