<script type="text/ng-template" id="unsubscribe-ng2-template">
    <div>
        <form id="unsubscribe-form" autocomplete="off">
            <h2><@orcid.msg 'manage.email.email_frequency.unsubscribe.title' /></h2>
            <div class="control-group">
                <p *ngIf="unsubscribeData"><@orcid.msg 'manage.email.email_frequency.unsubscribe.1.1' /> {{unsubscribeData.emailAddress}} <@orcid.msg 'manage.email.email_frequency.unsubscribe.1.2' /></p>
                <p><@orcid.msg 'manage.email.email_frequency.unsubscribe.2' /> <a href="https://orcid.org/account" target="_blank"><@orcid.msg 'manage.email.email_frequency.unsubscribe.2.url.text' /></a> <@orcid.msg 'manage.email.email_frequency.unsubscribe.3' /> <a href="<@orcid.msg 'common.kb_uri_default'/>360006894514" target="_blank"><@orcid.msg 'manage.email.email_frequency.unsubscribe.3.url.text' /></a></p>
                <p><@orcid.msg 'manage.email.email_frequency.notifications.selectors.header' /></p>                                            
            </div>
            <div *ngIf="unsubscribeData" class="control-group">
                <label for="amend-frequency"><@orcid.msg 'manage.email.email_frequency.notifications.selectors.amend' /></label><br />
                <select id="amend-frequency" name="amend-frequency" [(ngModel)]="notificationSettingsForm['send_change_notifications']">   
                    <option *ngFor="let key of unsubscribeData.emailFrequencyOptions.emailFrequencyKeys" [value]="key">{{unsubscribeData.emailFrequencyOptions.emailFrequencies[key]}}</option>
                </select>
            </div>
            <div *ngIf="unsubscribeData" class="control-group">
                <label for="administrative-frequency"><@orcid.msg 'manage.email.email_frequency.notifications.selectors.administrative' /></label><br />
                <select id="administrative-frequency" name="administrative-frequency" [(ngModel)]="notificationSettingsForm['send_administrative_change_notifications']">   
                    <option *ngFor="let key of unsubscribeData.emailFrequencyOptions.emailFrequencyKeys" [value]="key">{{unsubscribeData.emailFrequencyOptions.emailFrequencies[key]}}</option>
                </select>
            </div>
            <div *ngIf="unsubscribeData" class="control-group">
                <label for="permission-frequency"><@orcid.msg 'manage.email.email_frequency.notifications.selectors.permission' /></label><br />                  
                <select id="permission-frequency" name="permission-frequency" [(ngModel)]="notificationSettingsForm['send_member_update_requests']">   
                   <option *ngFor="let key of unsubscribeData.emailFrequencyOptions.emailFrequencyKeys" [value]="key">{{unsubscribeData.emailFrequencyOptions.emailFrequencies[key]}}</option>
                </select>
            </div>
            <h2><@orcid.msg 'manage.email.email_frequency.news.header' /></h2>
            <div class="control-group">
                <input id="send-orcid-news" type="checkbox" name="sendOrcidNews" [(ngModel)]="sendQuarterlyTips"/>&nbsp;
                <label for="send-orcid-news"><@orcid.msg 'manage.email.email_frequency.notifications.news.checkbox.label' /></label>
            </div>                
            <div class="controls">
                <button class="btn btn-primary" (click)="submitChanges()"><@orcid.msg 'freemarker.btnsavechanges' /></button>      
            </div>
        </form>
    </div>
</script>