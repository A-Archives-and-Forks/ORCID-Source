<script type="text/ng-template" id="request-password-reset-ng2-template">
    <#if springMacroRequestContext.requestUri?contains("/reset-password") >
        <div id="RequestPasswordResetCtr" class="row">
            <div class="col-md-9 col-md-offset-3 col-sm-12 col-xs-12">
                <h2>${springMacroRequestContext.getMessage("reset_password.h2ForgottenPassword")}</h2>
                <span *ngIf="tokenExpired" class="orcid-error">${springMacroRequestContext.getMessage("orcid.frontend.reset.password.resetAgain")}</span>
                <p>
                     ${springMacroRequestContext.getMessage("reset_password.enterEmail_1")}<br />
                     ${springMacroRequestContext.getMessage("reset_password.enterEmail_2")}
                     <a href="https://orcid.org/help/contact-us">${springMacroRequestContext.getMessage("resend_claim.labelorg")}</a>
                </p>           
                <div id="password-reset" name="emailAddressForm">
                    <span class="orcid-error" *ngIf="requestResetPassword.errors && requestResetPassword.errors.length > 0 && !showDeactivatedError &&  !showReactivationSent">
                       <div *ngFor='let error of requestResetPassword.errors' [innerHTML]="error"></div>
                    </span>
                    <div class="alert alert-success" *ngIf="requestResetPassword?.successMessage != null && (!resetPasswordEmailFeatureEnabled)">
                        <strong><span [innerHTML]="requestResetPassword.successMessage"></span>
                        </strong>
                    </div>
                    <div class="alert alert-success" *ngIf="requestResetPassword?.successMessage != null && resetPasswordEmailFeatureEnabled">
                        <strong>${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_1")} {{successEmailSentTo}}
                        ${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_2")}</strong><br>
                        ${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_3")}
                        <a href='${springMacroRequestContext.getMessage("common.contact_us.uri")}' target="common.contact_us.uri">${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_4")}</a>${springMacroRequestContext.getMessage("common.period")}
                    </div>
                    <div class="control-group col-md-6 reset">
                        <label for="email" class="control-label">${springMacroRequestContext.getMessage("manage_bio_settings.h3email")} </label>                       
                        <div class="controls"> 
                            <input id="email" name="email" type="text" class="form-control" [(ngModel)]="requestResetPassword.email" />
                        </div>
                        <span class="orcid-error" *ngIf="showDeactivatedError && !showReactivationSent">
                            ${springMacroRequestContext.getMessage("orcid.frontend.verify.deactivated_email.1")}<a role="button" tabindex="0"  (keyup.Enter)="sendReactivationResetPasswordPage()" (keyup.Space)="sendReactivationResetPasswordPage()" (click)="sendReactivationResetPasswordPage()" >${springMacroRequestContext.getMessage("orcid.frontend.verify.deactivated_email.2")}</a>${springMacroRequestContext.getMessage("orcid.frontend.verify.deactivated_email.3")}
                        </span>
                        <span class="orcid-error" *ngIf="showReactivationSent">
                            <@orcid.msg 'orcid.frontend.verify.reactivation_sent.1'/> <a href="https://orcid.org/help/contact-us">${springMacroRequestContext.getMessage("orcid.frontend.verify.reactivation_sent.2")}</a>${springMacroRequestContext.getMessage("orcid.frontend.verify.reactivation_sent.3")}
                        </span>
                        <!--General error-->
                        <div style="margin-bottom: 15px;" *ngIf="showSendResetLinkError">
                            <span class="orcid-error">${springMacroRequestContext.getMessage("Email.resetPasswordForm.error")}</span>
                        </div>  
                        <button class="btn btn-primary topBuffer" (click)="postPasswordResetRequest(requestResetPassword)">${springMacroRequestContext.getMessage("reset_password.sendResetLink")}</button>
                    </div>
                </div>
            </div>       
        </div>
    <#else>
        <div id="RequestPasswordResetCtr" class="reset-password">
        <a name="resetPassword"></a>
        <a role="button" tabindex="0"  (keyup.Enter)="toggleResetPassword()" (keyup.Space)="toggleResetPassword()" (click)="toggleResetPassword()" id="reset-password-toggle-text" [innerHTML]="resetPasswordToggleText"></a>
        <div *ngIf="showResetPassword">
            <p>
                 <small>
                 ${springMacroRequestContext.getMessage("reset_password.enterEmail_1")}<br />
                 ${springMacroRequestContext.getMessage("reset_password.enterEmail_2")}
                 <a href="https://orcid.org/help/contact-us">${springMacroRequestContext.getMessage("resend_claim.labelorg")}</a>
                 </small>
            </p>
            <div id="password-reset" name="emailAddressForm">
                <span class="orcid-error" *ngIf="requestResetPassword.errors && requestResetPassword.errors.length > 0 && !showDeactivatedError &&  !showReactivationSent">
                   <div *ngFor='let error of requestResetPassword.errors' [innerHTML]="error"></div>
                </span>
                <div class="alert alert-success" *ngIf="requestResetPassword?.successMessage != null && (!resetPasswordEmailFeatureEnabled)">
                    <strong><span [innerHTML]="requestResetPassword.successMessage"></span>
                    </strong>
                </div>
                <div class="alert alert-success" *ngIf="requestResetPassword?.successMessage != null && resetPasswordEmailFeatureEnabled">
                    <strong>${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_1")} {{successEmailSentTo}}
                    ${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_2")}</strong><br>
                    ${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_3")}
                    <a href='${springMacroRequestContext.getMessage("common.contact_us.uri")}' target="common.contact_us.uri">${springMacroRequestContext.getMessage("orcid.frontend.reset.password.email_success_4")}</a>${springMacroRequestContext.getMessage("common.period")}
                </div>
                <div class="control-group">
                    <label for="email" class="control-label">${springMacroRequestContext.getMessage("manage_bio_settings.h3email")} </label>                       
                    <div class="controls"> 
                        <input id="email" name="email" type="text" class="form-control" [(ngModel)]="requestResetPassword.email" />
                    </div>
                    <span class="orcid-error" *ngIf="showDeactivatedError && !showReactivationSent">
                        ${springMacroRequestContext.getMessage("orcid.frontend.verify.deactivated_email.1")}<a role="button" tabindex="0" (keyup.Enter)="sendReactivation(requestResetPassword.email)" (keyup.Space)="sendReactivation(requestResetPassword.email)" (click)="sendReactivation(requestResetPassword.email)">${springMacroRequestContext.getMessage("orcid.frontend.verify.deactivated_email.2")}</a>${springMacroRequestContext.getMessage("orcid.frontend.verify.deactivated_email.3")}
                    </span> 
                    <span class="orcid-error" *ngIf="showReactivationSent">
                        <@orcid.msg 'orcid.frontend.verify.reactivation_sent.1'/> <a href="https://orcid.org/help/contact-us">${springMacroRequestContext.getMessage("orcid.frontend.verify.reactivation_sent.2")}</a>${springMacroRequestContext.getMessage("orcid.frontend.verify.reactivation_sent.3")}
                    </span>
                    <!--General error-->
                    <div style="margin-bottom: 15px;" *ngIf="showSendResetLinkError">
                        <span class="orcid-error">${springMacroRequestContext.getMessage("Email.resetPasswordForm.error")}</span>
                    </div>  
                    <button class="btn btn-primary" (click)="postPasswordResetRequest(requestResetPassword)">${springMacroRequestContext.getMessage("reset_password.sendResetLink")}</button>
                </div>
            </div>
        </div>
    </div>
</#if>                    
</script>