import * as angular 
    from 'angular';

import { CommonModule } 
    from '@angular/common'; 

import { NgModule } 
    from '@angular/core';

import { downgradeComponent, UpgradeModule } 
    from '@angular/upgrade/static';

//In the end only emailVerificationSentMesssageNg2 should remain
import { EmailVerificationSentMesssageComponent } 
    from './emailVerificationSentMessage.component.ts';

// This is the Angular 1 part of the module
export const EmailVerificationSentMesssageModule = angular.module(
    'EmailVerificationSentMesssageModule', 
    []
);

// This is the Angular 2 part of the module
@NgModule(
    {
        declarations: [ 
            EmailVerificationSentMesssageComponent 
        ],
        entryComponents: [ 
            EmailVerificationSentMesssageComponent 
        ],
        imports: [
            CommonModule
        ]
    }
)
export class EmailVerificationSentMesssageNg2Module {}

// components migrated to angular 2 should be downgraded here
//Must convert as much as possible of our code to directives

EmailVerificationSentMesssageModule.directive(
    'emailVerificationSentMesssageNg2', 
    <any>downgradeComponent(
        {
            component: EmailVerificationSentMesssageComponent
        }
    )
);
