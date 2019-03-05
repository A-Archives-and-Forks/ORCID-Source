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
<div class="id-banner" [ngClass]="{'delegation-mode': userInfo.IN_DELEGATION_MODE=='true'}">
	<div class="full-name pull-right" *ngIf="requestInfoForm?.userName != null">
		{{requestInfoForm?.userName}}		
	</div>
	<div *ngIf="userInfo.LOCKED=='false'" class="oid">
		<!-- SWITCH USER -->
        <switch-user-ng2 [requestInfoForm]="requestInfoForm"></switch-user-ng2>
	</div>
	<div class="clearfix pull-right">
		<span class="notYouUrl"><a href="" onclick="logOffReload('show_login'); return false;">(<@orcid.msg'confirm-oauth-access.notYou'/>)</a>
            <h3 (click)="toggleNotYouDescription()">
                <a class="glyphicon glyphicon-question-sign oauth-question-sign"></a>               
            </h3>
        </span>
        <div *ngIf="showNotYouDescription"><@orcid.msg'confirm-oauth-access.notYou.longDesc'/></div>
	</div>
</div>