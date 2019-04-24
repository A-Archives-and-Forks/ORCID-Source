<div class="work-list-container">
    <ul class="sources-edit-list">
        <!--Edit sources-->
        <li *ngIf="editSources[group?.activePutCode]" class="source-header" [ngClass]="{'source-active' : editSources[group?.activePutCode] == true}">
            <div class="sources-header">
                <div class="row">
                    <div class="col-md-7 col-sm-7 col-xs-6">
                        <@orcid.msg 'groups.common.sources' /> <span class="hide-sources" (click)="hideSources(group)"><@orcid.msg 'groups.common.close_sources' /></span>
                    </div>
                    
                    <div class="col-md-2 col-sm-2 hidden-xs">
                        <@orcid.msgCapFirst 'groups.common.preferred' />
                    </div>
                    
                    <div class="col-md-3 col-sm-3 col-xs-6 right padding-left-fix">
                        <div class="workspace-toolbar">
                            <ul class="workspace-private-toolbar"> 
                                <!--Show/hide details-->              
                                <li *ngIf="orgIdsFeatureEnabled" class="works-details">
                                    <a aria-label="<@orcid.msg 'aria.toggle-details'/>" (click)="showDetailsMouseClick(group,$event)" (mouseenter)="showTooltip(group?.activePutCode+'-showHideDetails')" (mouseleave)="hideTooltip(group?.activePutCode+'-showHideDetails')">
                                        <span [ngClass]="(moreInfo[group?.activePutCode] == true) ? 'glyphicons collapse_top' : 'glyphicons expand'">
                                        </span>
                                    </a>
                                    <div class="popover popover-tooltip top show-hide-details-popover" *ngIf="showElement[group?.activePutCode+'-showHideDetails']">
                                         <div class="arrow"></div>
                                        <div class="popover-content">   
                                            <span *ngIf="moreInfo[group?.activePutCode] == false || moreInfo[group?.activePutCode] == null"><@orcid.msg 'common.details.show_details'/></span>   
                                            <span *ngIf="moreInfo[group?.activePutCode]"><@orcid.msg 'common.details.hide_details'/></span>
                                        </div>
                                    </div>
                                </li>
                                <li *ngIf="!isPublicPage">
                                    <@orcid.privacyToggle2Ng2 angularModel="group.activeVisibility"
                                    elementId="group.activePutCode" 
                                        questionClick="toggleClickPrivacyHelp(group.activePutCode)"
                                        clickedClassCheck="{'popover-help-container-show':privacyHelp[group.activePutCode]==true}"
                                        publicClick="setGroupPrivacy(group, 'PUBLIC', $event)"
                                        limitedClick="setGroupPrivacy(group, 'LIMITED', $event)"
                                        privateClick="setGroupPrivacy(group, 'PRIVATE', $event)"/>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </li>
        <!--End edit sources-->
        <ng-container *ngFor="let affiliation of group.affiliations; let index = index; let first = first; let last = last;">                           
            <li *ngIf="group.activePutCode == affiliation.putCode.value || editSources[group.activePutCode] == true">
                <div class="row" *ngIf="group.activePutCode == affiliation.putCode?.value">
                    <div class="col-md-9 col-sm-9 col-xs-7">
                        <h3 class="workspace-title">
                            <span>{{affiliation?.affiliationName?.value}}</span>:
                            <span>{{affiliation?.city.value}}</span><span *ngIf="affiliation?.region?.value">, </span><span>{{affiliation?.region?.value}}</span><span *ngIf="affiliation?.countryForDisplay">, </span><span>{{affiliation?.countryForDisplay}}</span>                                               
                        </h3>                                                      
                        <div class="info-detail">
                            <div class="info-date">                     
                                <span class="affiliation-date" *ngIf="affiliation?.startDate">
                                    <span *ngIf="affiliation?.startDate.year">{{affiliation?.startDate.year}}</span><span *ngIf="affiliation?.startDate.month">-{{affiliation?.startDate.month}}</span><span *ngIf="affiliation?.startDate.day">-{{affiliation?.startDate.day}}</span>
                                    <span *ngIf="affiliation?.endDate && affiliation?.endDate.year">&nbsp;<@orcid.msg 'workspace_affiliations.dateSeparator'/>&nbsp;</span>
                                    <span *ngIf="(affiliation?.startDate && affiliation?.startDate.year) && !(affiliation?.endDate && affiliation?.endDate.year)">&nbsp;<@orcid.msg 'workspace_affiliations.dateSeparator'/>&nbsp;<@orcid.msg 'workspace_affiliations.present'/></span>
                                    <span *ngIf="affiliation?.endDate">
                                        <span *ngIf="affiliation?.endDate.year">{{affiliation?.endDate.year}}</span><span *ngIf="affiliation?.endDate.month">-{{affiliation?.endDate.month}}</span><span *ngIf="affiliation?.endDate.day">-{{affiliation?.endDate.day}}</span>
                                    </span>
                                </span>
                                <span class="affiliation-date" *ngIf="!affiliation?.startDate && affiliation?.endDate">
                                     <span *ngIf="affiliation?.endDate.year">{{affiliation?.endDate.year}}</span><span *ngIf="affiliation?.endDate.month">-{{affiliation?.endDate.month}}</span><span *ngIf="affiliation?.endDate.day">-{{affiliation?.endDate.day}}</span>
                                </span>
                                <span *ngIf="(affiliation?.startDate || affiliation?.endDate) && (affiliation?.roleTitle?.value || affiliation?.departmentName?.value)"> | </span> <span *ngIf="affiliation?.roleTitle?.value">{{affiliation?.roleTitle?.value}}</span>        
                                <span *ngIf="affiliation?.departmentName?.value">
                                <span *ngIf="affiliation?.roleTitle?.value && !printView">&nbsp;</span>(<span>{{affiliation?.departmentName.value}}</span>)
                                </span>
                            </div><!--info-date-->
                        </div><!--info-detail-->
                        <div class="info-detail" *ngIf="affiliation?.affiliationType?.value">
                            <span>{{affiliation?.affiliationType?.value | titlecase | dashToSpace}}</span>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-3 col-xs-5 workspace-toolbar">
                        <ul class="workspace-private-toolbar" *ngIf="!editSources[group.activePutCode]"> 
                            <!--Show details toggle-->
                            <li class="works-details" *ngIf="!editSources[group.activePutCode]">
                                <a aria-label="<@orcid.msg 'aria.toggle-details'/>" (click)="showDetailsMouseClick(group,$event)" (mouseenter)="showTooltip(group?.activePutCode+'-showHideDetails')" (mouseleave)="hideTooltip(group?.activePutCode+'-showHideDetails')">
                                    <span [ngClass]="(z == true) ? 'glyphicons collapse_top' : 'glyphicons expand'">
                                    </span>
                                </a>
                                <div class="popover popover-tooltip top show-hide-details-popover" *ngIf="showElement[group.activePutCode+'-showHideDetails']">
                                    <div class="arrow"></div>
                                    <div class="popover-content">
                                        <span *ngIf="moreInfo[group.activePutCode] == false || moreInfo[group.activePutCode] == null"><@orcid.msg 'common.details.show_details' /></span>   
                                        <span *ngIf="moreInfo[group.activePutCode]"><@orcid.msg 'common.details.hide_details' /></span>
                                    </div>
                                </div>
                            </li>
                            <!--Visibility selector-->
                            <li *ngIf="!isPublicPage">
                                <@orcid.privacyToggle2Ng2 angularModel="group.activeVisibility"
                                elementId="group.activePutCode" questionClick="toggleClickPrivacyHelp(group.activePutCode)" clickedClassCheck="{'popover-help-container-show':privacyHelp[affiliation.putCode.value]==true}" publicClick="setGroupPrivacy(group, 'PUBLIC', $event)" limitedClick="setGroupPrivacy(group, 'LIMITED', $event)" privateClick="setGroupPrivacy(group, 'PRIVATE', $event)" />
                            </li>
                        </ul>
                        <!--Inconsistent visibility warning-->  
                        <div *ngIf="!isPublicPage && !affiliationService.consistentVis(group) && !editSources[group.activePutCode]" class="vis-issue">
                            <div class="popover-help-container">
                                <span class="glyphicons circle_exclamation_mark" (mouseleave)="hideTooltip('vis-issue')" (mouseenter)="showTooltip('vis-issue')"></span>
                                <div class="popover vis-popover bottom" *ngIf="showElement['vis-issue']">
                                    <div class="arrow"></div>
                                    <div class="popover-content">
                                        <@orcid.msg 'groups.common.data_inconsistency' />                                            
                                    </div>
                                </div>
                            </div>                                    
                        </div>
                    </div>
                </div><!--row-->
                <!--Identifiers-->
                <div class="row" *ngIf="group.activePutCode == affiliation.putCode.value">
                    <div class="col-md-12 col-sm-12 bottomBuffer">
                        <ul class="id-details clearfix">
                            <li class="url-work clearfix">
                                <ul class="id-details clearfix">
                                    <li *ngFor='let extID of affiliation?.affiliationExternalIdentifiers;let i = index;trackBy:trackByIndex | orderBy:["-relationship.value", "type.value"]' class="url-popover">
                                        <span *ngIf="affiliation?.affiliationExternalIdentifiers[0]?.externalIdentifierId?.value?.length > 0">
                                            <ext-id-popover-ng2 [extID]="extID" [putCode]="affiliation.putCode.value+i" [activityType]="'affiliation'"></ext-id-popover-ng2>
                                        </span>
                                     </li>
                                </ul>                                   
                            </li>
                        </ul>
                    </div>
                </div><!--Identifiers-->
                <!--More info-->
                <div class="more-info" *ngIf="moreInfo[group?.activePutCode] && group.activePutCode == affiliation.putCode.value">
                    <div id="ajax-loader" *ngIf="affiliationService.details[affiliation.putCode.value] == undefined">
                        <span id="ajax-loader"><i id="ajax-loader" class="glyphicon glyphicon-refresh spin x4 green"></i></span>
                    </div> 
                    <div class="content" *ngIf="affiliationService.details[affiliation.putCode.value] != undefined">   
                        <span class="dotted-bar"></span>
                        <div class="row"> 
                            <!--Org id-->
                            <div class="org-ids" *ngIf="affiliation?.orgDisambiguatedId?.value">
                                <div class="col-md-12">   
                                    <strong><@orcid.msg 'workspace_affiliations.organization_id'/></strong><br>
                                    <org-identifier-popover-ng2 [value]="affiliation?.disambiguatedAffiliationSourceId?.value" [putCode]="affiliation?.putCode?.value" [type]="affiliation?.disambiguationSource?.value"></org-identifier-popover-ng2>
                                </div>
                            </div><!--org-ids-->
                            <!--URL-->
                            <div class="col-md-6" *ngIf="affiliationService.details[affiliation.putCode.value]?.url?.value">
                                <div class="bottomBuffer">
                                    <strong><@orcid.msg 'common.url'/></strong><br> 
                                    <a href="{{affiliationService.details[affiliation.putCode.value]?.url?.value}}" target="affiliation.url.value">{{affiliationService.details[affiliation.putCode.value]?.url?.value}}</a>
                                </div>
                            </div>          
                        </div><!--row--> 
                        <!--Created date-->                
                        <div class="row bottomBuffer">
                            <div class="col-md-6">
                                <div class="bottomBuffer">
                                    <strong><@orcid.msg 'groups.common.added'/></strong><br> 
                                    <span>{{affiliation?.createdDate | ajaxFormDateToISO8601}}</span>
                                </div>    
                            </div>
                            <div class="col-md-6">
                                <div class="bottomBuffer">
                                    <strong><@orcid.msg 'groups.common.last_modified'/></strong><br> 
                                    <span>{{affiliation?.lastModified | ajaxFormDateToISO8601}}</span>
                                </div>    
                            </div>      
                        </div><!--Created date--> 
                    </div> <!--content-->
                </div><!--More info-->
                <!--Source line-->
                <div class="row source-line" *ngIf="group.activePutCode == affiliation.putCode.value">
                    <!--Edit sources-->
                    <!--Source name-->
                    <div class="col-md-7 col-sm-7 col-xs-12" *ngIf="editSources[group.activePutCode]">
                        {{(affiliation.sourceName == null || affiliation.sourceName == '') ? affiliation.source : affiliation.sourceName }}
                             <#--  OBO  -->
                            <ng-container *ngIf="(affiliation.assertionOriginClientId && affiliation.assertionOriginClientId !== affiliation.sourceClientId) ||
                            (affiliation.source.assertionOriginOrcid && affiliation.source.assertionOriginOrcid !== affiliation.source.sourceOrcid)">
                            <i>${springMacroRequestContext.getMessage("public_profile.onBehalfOf")}</i> {{affiliation.assertionOriginName || affiliation.assertionOriginOrcid}}
                            </ng-container>
                    </div>
                    <!--Preferred source-->
                    <div class="col-md-3 col-sm-3 col-xs-10" *ngIf="editSources[group.activePutCode]">
                        <div *ngIf="editSources[group.activePutCode]">
                            <span class="glyphicon glyphicon-star" *ngIf="affiliation.putCode.value == group.defaultAffiliation.putCode.value"></span><span *ngIf="affiliation.putCode.value == group.defaultAffiliation.putCode.value"> <@orcid.msg 'groups.common.preferred_source' /></span>
                            <a (click)="makeDefault(group, affiliation, affiliation.putCode.value)" *ngIf="affiliation.putCode.value != group.defaultAffiliation.putCode.value && !isPublicPage">
                                <span class="glyphicon glyphicon-star-empty"></span> <@orcid.msg 'groups.common.make_preferred' />
                            </a>
                        </div>
                    </div>
                    <!--Edit/delete sources-->
                    <div class="col-md-2 col-sm-2 trash-source" *ngIf="editSources[group.activePutCode]">
                        <div>
                            <ul *ngIf="!isPublicPage" class="sources-actions">
                                <li> 
                                    <@orcid.editActivityIconNg2
                                        activity="affiliation"
                                        click="openEditAffiliation(affiliation, group)"
                                        toolTipSuffix="editToolTipSource"
                                        toolTipClass="popover popover-tooltip top edit-activeSource-popover"
                                     />
                                    
                                </li>
                                <li>
                                    <a 
                                        (click)="deleteAffiliation(affiliation)"  
                                        title="<@orcid.msg 'freemarker.btnDelete' /> {{affiliation?.affiliationName?.value}}" 
                                        (mouseenter)="showTooltip(affiliation.putCode.value+'-deleteActiveSource')" 
                                        (mouseleave)="hideTooltip(affiliation.putCode.value+'-deleteActiveSource')">
                                        <span class="glyphicon glyphicon-trash"></span>
                                    </a>

                                    <div class="popover popover-tooltip top delete-activeSource-popover" *ngIf="showElement[affiliation.putCode.value+'-deleteActiveSource']">
                                        <div class="arrow"></div>
                                        <div class="popover-content">
                                            <@orcid.msg 'groups.common.delete_this_source' />
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!--Edit sources-->
                </div>
                <div *ngIf="group.activePutCode != affiliation.putCode.value" class="row source-line">
                    <div class="col-md-7 col-sm-7 col-xs-12">
                        <a (click)="swapSources(group, affiliation.putCode.value)">                               
                            {{(affiliation.sourceName == null || affiliation.sourceName == '') ? affiliation.source : affiliation.sourceName }}
                             <#--  OBO  -->
                            <ng-container *ngIf="(affiliation.assertionOriginClientId && affiliation.assertionOriginClientId !== affiliation.sourceClientId) ||
                            (affiliation.source.assertionOriginOrcid && affiliation.source.assertionOriginOrcid !== affiliation.source.sourceOrcid)">
                            <i>${springMacroRequestContext.getMessage("public_profile.onBehalfOf")}</i> {{affiliation.assertionOriginName || affiliation.assertionOriginOrcid}}
                            </ng-container>
                        </a>
                    </div>                                       
                    <div class="col-md-3 col-sm-3 col-xs-10">
                        <span class="glyphicon glyphicon-star" *ngIf="affiliation.putCode.value == group.defaultAffiliation.putCode.value"></span><span *ngIf="affiliation.putCode.value == group.defaultAffiliation.putCode.value"> <@orcid.msg 'groups.common.preferred_source' /></span>                        
                        <a (click)="makeDefault(group, affiliation, affiliation.putCode.value); " *ngIf="affiliation.putCode.value != group.defaultAffiliation.putCode.value && !isPublicPage">
                            <span class="glyphicon glyphicon-star-empty"></span> <@orcid.msg 'groups.common.make_preferred' />
                        </a>
                    </div>
                    <!--Action buttons-->
                    <div class="col-md-2 col-sm-2 col-xs-2 trash-source">
                        <ul *ngIf="!isPublicPage" class="sources-actions">
                            <li> 
                                <@orcid.editActivityIconNg2
                                    activity="affiliation"
                                    click="openEditAffiliation(affiliation, group)"
                                    toolTipSuffix="editToolTipSourceActions"
                                    toolTipClass="popover popover-tooltip top edit-inactiveSource-popover"
                                 />
                            </li>
                            <li>
                                <a (click)="deleteAffiliation(affiliation)" (mouseenter)="showTooltip(affiliation.putCode.value+'-deleteInactiveSource')" (mouseleave)="hideTooltip(affiliation.putCode.value+'-deleteInactiveSource')">
                                    <span class="glyphicon glyphicon-trash" title="<@orcid.msg 'freemarker.btnDelete'/> {{affiliation?.affiliationName?.value}}"></span>
                                </a>

                                <div class="popover popover-tooltip top delete-inactiveSource-popover" *ngIf="showElement[affiliation.putCode.value+'-deleteInactiveSource'] == true">
                                    <div class="arrow"></div>
                                    <div class="popover-content">
                                       <@orcid.msg 'groups.common.delete_this_source' />
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row source-line" *ngIf="!editSources[group.activePutCode]">                        
                    <div class="col-md-7 col-sm-7 col-xs-12">
                        <b><@orcid.msg 'groups.common.source'/>:</b> {{(affiliation.sourceName == null || affiliation.sourceName == '') ? affiliation.source : affiliation.sourceName }}
                             <#--  OBO  -->
                            <ng-container *ngIf="(affiliation.assertionOriginClientId && affiliation.assertionOriginClientId !== affiliation.sourceClientId) ||
                            (affiliation.source.assertionOriginOrcid && affiliation.source.assertionOriginOrcid !== affiliation.source.sourceOrcid)">
                            <i>${springMacroRequestContext.getMessage("public_profile.onBehalfOf")}</i> {{affiliation.assertionOriginName || affiliation.assertionOriginOrcid}}
                            </ng-container>
                    </div>
                    
                    <div class="col-md-3 col-sm-3 col-xs-9">
                        <span class="glyphicon glyphicon-star"></span><span> <@orcid.msg 'groups.common.preferred_source' /></span> <span *ngIf="group?.affiliations?.length != 1"> (</span><a (click)="showSources(group, $event)" *ngIf="group?.affiliations?.length != 1" (mouseenter)="showTooltip(group.activePutCode+'-sources')" (mouseleave)="hideTooltip(group.activePutCode+'-sources')"><@orcid.msg 'groups.common.of'/> {{group.affiliations.length}}</a><span *ngIf="group?.affiliations?.length != 1">)</span>

                        <div class="popover popover-tooltip top sources-popover" *ngIf="showElement[group.activePutCode+'-sources']">
                            <div class="arrow"></div>
                            <div class="popover-content">
                                <@orcid.msg 'groups.common.sources.show_other_sources' />
                            </div>
                        </div>
                    </div>

                    <div class="col-md-2 col-sm-2 col-xs-3" *ngIf="group.activePutCode == affiliation.putCode.value">
                        <ul *ngIf="!isPublicPage" class="sources-options" >
                            <li>
                                <@orcid.editActivityIconNg2
                                    activity="affiliation"
                                    click="openEditAffiliation(affiliation, group)"
                                    toolTipSuffix="editToolTip"
                                    toolTipClass="popover popover-tooltip top edit-source-popover"
                                />
                            </li>

                            <li *ngIf="!(editSources[group.activePutCode] || group?.affiliations?.length == 1)">
                                <a (click)="showSources(group,$event)" (mouseenter)="showTooltip(group.activePutCode+'-deleteGroup')" (mouseleave)="hideTooltip(group.activePutCode+'-deleteGroup')">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </a>
                                <div class="popover popover-tooltip top delete-group-popover" *ngIf="showElement[group.activePutCode+'-deleteGroup']">
                                    <div class="arrow"></div>
                                    <div class="popover-content">
                                       <@orcid.msg 'groups.common.delete_this_source' />
                                    </div>
                                </div>
                            </li>

                            <li *ngIf="group?.affiliations?.length == 1">
                                <a (click)="deleteAffiliation(affiliation)" (mouseenter)="showTooltip(group.activePutCode+'-deleteSource')" (mouseleave)="hideTooltip(group.activePutCode+'-deleteSource')">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </a>
                                <div class="popover popover-tooltip top delete-source-popover" *ngIf="showElement[group.activePutCode+'-deleteSource']">
                                    <div class="arrow"></div>
                                    <div class="popover-content">
                                        <@orcid.msg 'groups.common.delete_this_source' />
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div> 
            </li>
        </ng-container>
    </ul>
</div>