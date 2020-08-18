<script type="text/ng-template" id="self-service-existing-sub-member-ng2-template">        
    <div class="lightbox-container">
    	    <h3><@orcid.msg 'manage_consortium.add_submember_existing_org_heading'/></h3>
        <p><@orcid.msg 'manage_consortium.add_submember_existing_org_text1'/></p>
        <p class="bold">{{newSubMemberExistingOrg?.publicDisplayName}}<br>
        <a href="{{newSubMemberExistingOrg?.websiteUrl}}" rel="noopener noreferrer" target="newSubMemberExistingOrg.member.websiteUrl">{{newSubMemberExistingOrg?.websiteUrl}}</a>
        </p>
        
        <p><@orcid.msg 'manage_consortium.add_submember_existing_org_text2'/></p>
        <p><@orcid.msg 'manage_consortium.add_submember_existing_org_text3'/> <button class="btn btn-white-no-border" (click)="closeModalReload()"><@orcid.msg 'freemarker.btncancel'/></button> <@orcid.msg 'manage_consortium.add_submember_existing_org_text4'/> <a href="<@spring.message "manage_consortium.support"/>"><@spring.message "manage_consortium.support"/></a></p>
        <form (submit)="addSubMember()">
            <button class="btn btn-danger"><@orcid.msg 'freemarker.btncontinue'/></button>
            <button (click)="closeModal()" class="btn btn-white-no-border cancel-option"><@orcid.msg 'freemarker.btncancel'/></button>
        </form>
        <div *ngIf="errors?.length === 0">
            <br>
        </div>
    </div>
</script>