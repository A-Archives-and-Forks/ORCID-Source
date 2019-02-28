import * as angular 
    from 'angular';

import { Directive, NgModule } 
    from '@angular/core';

import { downgradeComponent, UpgradeModule } 
    from '@angular/upgrade/static';

import { AdminActionsComponent } 
    from './adminActions.component.ts';

import { CommonNg2Module }
    from './../common/common.ts';
    
// This is the Angular 1 part of the module
export const AdminActionsModule = angular.module(
    'AdminActionsModule', 
    []
);

// This is the Angular 2 part of the module
@NgModule(
    {
        imports: [
            CommonNg2Module
        ],
        declarations: [ 
            AdminActionsComponent
        ],
        entryComponents: [ 
            AdminActionsComponent 
        ],
        providers: [
            
        ]
    }
)
export class AdminActionsNg2Module {}

// components migrated to angular 2 should be downgraded here
//Must convert as much as possible of our code to directives
AdminActionsModule.directive(
    'adminActionsNg2', 
    <any>downgradeComponent(
        {
            component: AdminActionsComponent,
        }
    )
);
