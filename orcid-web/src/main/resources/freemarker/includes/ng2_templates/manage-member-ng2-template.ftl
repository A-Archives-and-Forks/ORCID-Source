<#include "/includes/ng2_templates/manage-member-add-form-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-consortium-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-find-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-find-member-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-add-form-success-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-find-member-confirm-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-find-client-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-activate-client-ng2-template.ftl">
<#include "/includes/ng2_templates/manage-member-deactivate-client-ng2-template.ftl">


<script type="text/ng-template" id="manage-member-ng2-template">
	<!-- Add new client group -->
		<a name="add-client"></a>
		<div class="workspace-accordion-item">			
			<p >
				<a (click)="toggleCollapse('addMember')" *ngIf="collapseMenu.addMember"><span class="glyphicon glyphicon-chevron-down blue"></span><@orcid.msg 'manage_groups.admin_groups_title'/></a>
				<a (click)="toggleCollapse('addMember')" *ngIf="!collapseMenu.addMember"><span class="glyphicon glyphicon-chevron-right blue"></span><@orcid.msg 'manage_groups.admin_groups_title'/></a>				
			</p>
			<div *ngIf="collapseMenu.addMember" class="collapsible bottom-margin-small admin-modal" id="admin_groups_modal">				
	    		<div class="view-items-link">							
					<a (click)="showModal('addMember')">
						<span  class="glyphicon glyphicon-plus-sign blue"></span>
						<@orcid.msg 'manage_groups.add_group_link'/>
					</a>
				</div>				
			</div>			
		</div>
		
		
		<!-- TODO Find -->
		<a name="find"></a>
			<div class="workspace-accordion-item">			
			<p>
				<a (click)="toggleCollapse('findMember')" *ngIf="collapseMenu.findMember"><span class="glyphicon glyphicon-chevron-down blue"></span><@orcid.msg 'manage_members.find_member'/></a>
				<a (click)="toggleCollapse('findMember')" *ngIf="!collapseMenu.findMember"><span class="glyphicon glyphicon-chevron-right blue"></span><@orcid.msg 'manage_members.find_member'/></a>				
			</p>
			<manage-members-find-ng2  *ngIf="collapseMenu.findMember"> </manage-members-find-ng2>		
		</div>

		<!-- Find consortium-->
        <a name="find-consortium"></a>
		<div class="workspace-accordion-item">		
			<p>
				<a (click)="toggleCollapse('findConsortium')" *ngIf="collapseMenu.findConsortium"><span class="glyphicon glyphicon-chevron-down blue"></span><@orcid.msg 'manage_members.manage_consortia'/></a>
				<a (click)="toggleCollapse('findConsortium')" *ngIf="!collapseMenu.findConsortium"><span class="glyphicon glyphicon-chevron-right blue"></span><@orcid.msg 'manage_members.manage_consortia'/></a>				
			</p>
			<div *ngIf="collapseMenu.findConsortium" class="collapsible bottom-margin-small admin-modal" id="admin_groups_modal">
					<manage-members-consortium-ng2> </manage-members-consortium-ng2>
			</div>
		</div>
		
		<!-- deactivate client -->
		<a name="deactivate-client"></a>
        <div class="workspace-accordion-item" id="deactivate-client">
            <p>
                <a *ngIf="showDeactivateClient" (click)="showDeactivateClient = false"><span class="glyphicon glyphicon-chevron-down blue"></span><@orcid.msg 'admin.deactivate_client' /></a>
                <a *ngIf="!showDeactivateClient" (click)="showDeactivateClient = true"><span class="glyphicon glyphicon-chevron-right blue"></span><@orcid.msg 'admin.deactivate_client' /></a>
            </p>
            <div class="collapsible bottom-margin-small admin-modal" *ngIf="showDeactivateClient">
                <manage-members-deactivate-client-ng2> </manage-members-deactivate-client-ng2>
            </div>
        </div>
        
        <!-- activate client  -->
        <div class="workspace-accordion-item" id="activate-client">
            <p>
                <a *ngIf="showActivateClient" (click)="showActivateClient = false"><span class="glyphicon glyphicon-chevron-down blue"></span><@orcid.msg 'admin.activate_client' /></a>
                <a *ngIf="!showActivateClient" (click)="showActivateClient = true"><span class="glyphicon glyphicon-chevron-right blue"></span><@orcid.msg 'admin.activate_client' /></a>
            </p>
            <div class="collapsible bottom-margin-small admin-modal" *ngIf="showActivateClient">
                <manage-members-activate-client-ng2> </manage-members-activate-client-ng2>
            </div>
        </div>


</script>
<modalngcomponent elementHeight="500" elementId="modalAddMember" elementWidth="400">
	<manage-member-add-form-ng2></manage-member-add-form-ng2>
</modalngcomponent><!-- Ng2 component -->

<modalngcomponent elementHeight="645" elementId="modalAddMemberSuccess" elementWidth="500">
	<manage-member-add-form-success-ng2></manage-member-add-form-success-ng2>
</modalngcomponent><!-- Ng2 component -->

<modalngcomponent elementHeight="200" elementId="modalFindMemberConfirm" elementWidth="350">
	<manage-members-find-member-confirm-ng2></manage-members-find-member-confirm-ng2>
</modalngcomponent><!-- Ng2 component -->