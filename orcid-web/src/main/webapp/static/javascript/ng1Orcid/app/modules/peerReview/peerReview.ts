import * as angular 
    from 'angular';

import { Directive, NgModule } 
    from '@angular/core';

import { downgradeComponent, UpgradeModule } 
    from '@angular/upgrade/static';

//User generated components
import { PeerReviewComponent } 
    from './peerReview.component.ts';

import { CommonNg2Module }
    from './../common/common.ts';

// This is the Angular 1 part of the module
export const PeerReviewModule = angular.module(
    'PeerReviewModule', 
    []
);

// This is the Angular 2 part of the module
@NgModule(
    {
        declarations: [ 
            PeerReviewComponent
        ],
        entryComponents: [ 
            PeerReviewComponent 
        ],
        imports: [
            CommonNg2Module
        ],
        providers: [
            
        ]
    }
)
export class PeerReviewNg2Module {}

// components migrated to angular 2 should be downgraded here
//Must convert as much as possible of our code to directives
PeerReviewModule.directive(
    'peerReviewNg2', 
    <any>downgradeComponent(
        {
            component: PeerReviewComponent,
        }
    )
);
