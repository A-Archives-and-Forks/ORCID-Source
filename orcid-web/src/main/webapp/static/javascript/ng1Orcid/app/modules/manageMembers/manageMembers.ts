import * as angular from "angular";

import { Directive, NgModule } from "@angular/core";

import { downgradeComponent } from "@angular/upgrade/static";

//User generated
import { ManageMembersComponent } from "./manageMembers.component.ts";

import { CommonNg2Module } from "./../common/common.ts";

import { ManageMemberAddFormComponent } from "./manageMembersAddForm.component.ts"

import { ManageMembersConsortiumComponent } from "./manageMembersConsortium.component.ts"

import { ManageMembersFindComponent } from "./manageMembersFind.component.ts"

import { ManageMemberAddFormSuccessComponent } from "./manageMembersAddFormSuccess.component.ts"

import { ManageMembersFindMemberComponent } from "./manageMembersFindMember.component.ts"

import { ManageMembersFindMemberConfirmComponent } from "./manageMembersFindMemberConfirm.component.ts"

import { ManageMembersFindClientComponent } from "./manageMembersFindClient.component.ts"

// This is the Angular 1 part of the module
export const ManageMembersModule = angular.module("ManageMembersModule", []);


// This is the Angular 2 part of the module
@NgModule({
  imports: [CommonNg2Module],
  declarations: [ManageMembersComponent, ManageMemberAddFormComponent, ManageMembersConsortiumComponent, ManageMembersFindComponent, ManageMemberAddFormSuccessComponent, ManageMembersFindMemberComponent, ManageMembersFindMemberConfirmComponent, ManageMembersFindClientComponent],
  entryComponents: [ManageMembersComponent, ManageMemberAddFormComponent, ManageMembersConsortiumComponent, ManageMembersFindComponent, ManageMemberAddFormSuccessComponent, ManageMembersFindMemberComponent, ManageMembersFindMemberConfirmComponent, ManageMembersFindClientComponent],
  providers: []
})
export class ManageMembersNg2Module {}

// components migrated to angular 2 should be downgraded here
//Must convert as much as possible of our code to directives
ManageMembersModule.directive("manageMembersNg2", <any>downgradeComponent({
  component: ManageMembersComponent
})).directive("manageMemberAddFormNg2", <any>downgradeComponent({
  component: ManageMemberAddFormComponent
})).directive("manageMembersConsortiumNg2", <any>downgradeComponent({
  component: ManageMembersConsortiumComponent
})).directive("manageMembersFindNg2", <any>downgradeComponent({
  component: ManageMembersFindComponent
})).directive("manageMemberAddFormSuccessNg2", <any>downgradeComponent({
  component: ManageMemberAddFormSuccessComponent
})).directive("manageMembersFindMemberNg2", <any>downgradeComponent({
  component: ManageMembersFindMemberComponent
})).directive("manageMembersFindMemberConfirmNg2", <any>downgradeComponent({
  component: ManageMembersFindMemberConfirmComponent
})).directive("manageMembersFindClientNg2", <any>downgradeComponent({
  component: ManageMembersFindClientComponent
}));







