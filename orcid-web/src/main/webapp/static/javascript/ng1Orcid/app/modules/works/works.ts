import * as angular 
    from 'angular';

import { Directive, NgModule } 
    from '@angular/core';

import { downgradeComponent, UpgradeModule } 
    from '@angular/upgrade/static';

//User generated components
import { CommonNg2Module }
    from './../common/common';

import { WorksComponent } 
    from './works.component';

import { WorksMergeComponent } 
    from './worksMerge.component';

import {MatProgressBarModule}
    from '@angular/material/progress-bar';

//User generated filters
import { FilterImportWizardsPipe }
    from '../../pipes/filterImportWizardsNg2'; 

// This is the Angular 1 part of the module
export const WorksModule = angular.module(
    'WorksModule', 
    []
);

import {MatPaginatorModule} from '@angular/material/paginator'
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';



// This is the Angular 2 part of the module

@NgModule(
    {
        declarations: [
            WorksComponent,
            WorksMergeComponent,
        ],
        entryComponents: [ 
            WorksComponent,
            WorksMergeComponent,
        ],
        imports: [
            CommonNg2Module,
            MatPaginatorModule,
            BrowserAnimationsModule
        ],
        
    }
)
export class WorksNg2Module {}

// components migrated to angular 2 should be downgraded here
//Must convert as much as possible of our code to directives

WorksModule.directive(
    'worksNg2', 
    <any>downgradeComponent(
        {
            component: WorksComponent
        }
    )
    ).directive(
    'worksMergeNg2',
    <any>downgradeComponent(
        {
            component: WorksMergeComponent,
        }
    )
);
