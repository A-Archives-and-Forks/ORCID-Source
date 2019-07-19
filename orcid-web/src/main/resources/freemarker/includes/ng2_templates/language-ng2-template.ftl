<script type="text/ng-template" id="language-ng2-template"> 
    <form id="language-form" action="#" role="navigation"  aria-label="language menu">
        <select
            *ngIf="languages"
            name="language-codes" id="language-codes"
            [(ngModel)]="language" 
            (ngModelChange)="selectedLanguage()"
        >
            <option 
                *ngFor="let languageOpt of languages"
                [value]="languageOpt.value"
                [selected]="languageOpt.value == language.value"
            >
                {{languageOpt.label}}   
            </option>             
            
        </select>
    </form>                     
</script>