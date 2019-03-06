<div id="modalDeprecateAccountConfirm" class="modal">
    <div class="popover-ng2-bck" (click)="cancelEditModal('modalDeprecateAccountConfirm')"></div>
    <div
        class="popover-ng2-content"
        id="colorbox" 
        role="dialog" 
        style="transition: width 2s, height 2s;"
        tabindex="-1" 
        [ngStyle]="{
        'height': this.elementHeight + 'px',
        'left': 'calc(50% - ' + this.elementWidth/2 + 'px)',
        'top': 'calc(50% - ' + this.elementHeight/2 + 'px)',
        'width': this.elementWidth + 'px'
        }"
    >
        <div id="cboxWrapper" 
            [ngStyle]="{
            'height': this.elementHeight + 'px',
            'width': this.elementWidth + 'px'
            }"
        >
            <div>
                <div id="cboxTopLeft" style="float: left;"></div>
                <div id="cboxTopCenter" style="float: left;"
                    [ngStyle]="{
                    'width': this.elementWidth + 'px'
                    }"
                ></div>
                <div id="cboxTopRight" style="float: left;"></div>
            </div>
            <div style="clear: left;">
                <div id="cboxMiddleLeft" style="float: left;"
                    [ngStyle]="{
                    'height': this.elementHeight + 'px'
                    }"
                ></div>
                <div id="cboxContent" style="float: left;"
                    [ngStyle]="{
                        'height': this.elementHeight + 'px',
                        'width': this.elementWidth + 'px'
                    }"
                >
                    <div id="cboxLoadedContent" style=" overflow: auto;"
                        [ngStyle]="{
                        'height': this.elementHeight + 'px',
                        'width': this.elementWidth + 'px'
                        }"
                    >
                        <div class="lightbox-container">
                            <!--Begin modal content-->      
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12 bottomBuffer">       
                                    <h2><@orcid.msg 'deprecate_orcid_modal.heading' /></h2>     
                                    <span class="orcid-error italic"><@orcid.msg 'deprecate_orcid_modal.warning_1' />
                                        <br />
                                        <strong class="italic"><@orcid.msg 'deprecate_orcid_modal.warning_2' /></strong>
                                    </span>
                                    <strong><@orcid.msg 'deprecate_orcid_modal.remove_this' /></strong>
                                    <br />
                                    <a href="{{getBaseUri()}}/{{deprecateProfilePojo.deprecatingOrcid}}" target="deprecatingOrcid">{{getBaseUri()}}/<span [innerHtml]="deprecateProfilePojo.deprecatingOrcid"></span></a>
                                    <br />
                                    <span><@orcid.msg 'deprecate_orcid_modal.name_label' /></span><span [innerHtml]="deprecateProfilePojo.deprecatingAccountName"></span>
                                    <br />
                                    <span><@orcid.msg 'deprecate_orcid_modal.emails_label' /></span>
                                    <ul class="inline comma">
                                        <li *ngFor="let email of deprecateProfilePojo.deprecatingEmails" [innerHtml]="email"></li>
                                    </ul>
                                    <br /><br />
                                    <strong><@orcid.msg 'deprecate_orcid_modal.keep_this' /></strong>
                                    <br />
                                    <a href="{{getBaseUri()}}/{{deprecateProfilePojo.primaryOrcid}}" target="primaryOrcid">{{getBaseUri()}}/<span [innerHtml]="deprecateProfilePojo.primaryOrcid"></span></a>
                                    <br />
                                    <span><@orcid.msg 'deprecate_orcid_modal.name_label' /></span><span [innerHtml]="deprecateProfilePojo.primaryAccountName"></span>
                                    <br />
                                    <span><@orcid.msg 'deprecate_orcid_modal.emails_label' /></span>
                                    <ul class="inline comma">
                                        <li *ngFor="let email of deprecateProfilePojo.primaryEmails" [innerHtml]="email" ></li>
                                    </ul>
                                    <br /><br />
                                </div>          
                            </div>
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="pull-left">
                                        <button id="bottom-submit" class="btn btn-primary" (click)="deprecateProfileConfirm()"><@orcid.msg 'deprecate_orcid_modal.confirm'/></button>
                                        <button class="btn btn-white-no-border cancel-right" (click)="cancelDeprecateModal('modalDeprecateAccountConfirm')"><@orcid.msg 'freemarker.btncancel' /></button>
                                    </div>
                                </div>
                            </div>
                            <!--End modal content-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>             