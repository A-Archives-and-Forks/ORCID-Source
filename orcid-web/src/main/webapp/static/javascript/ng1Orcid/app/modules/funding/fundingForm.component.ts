declare var $: any;
declare var typeahead: any;

//Import all the angular components
import { NgForOf, NgIf } 
    from '@angular/common'; 

import { AfterViewInit, Component, OnDestroy, OnInit } 
    from '@angular/core';

import { Observable, Subject, Subscription } 
    from 'rxjs';
import { takeUntil } 
    from 'rxjs/operators';

import { CommonService } 
    from '../../shared/common.service.ts';

import { FundingService } 
    from '../../shared/funding.service.ts';

import { ModalService } 
    from '../../shared/modal.service.ts'; 

import { FeaturesService } 
    from '../../shared/features.service.ts';

@Component({
    selector: 'funding-form-ng2',
    template:  scriptTmpl("funding-form-ng2-template")
})
export class FundingFormComponent implements AfterViewInit, OnDestroy, OnInit {
    private ngUnsubscribe: Subject<void> = new Subject<void>();
    private subscription: Subscription;
    private viewSubscription: Subscription;

    addingFunding: boolean;
    disambiguatedFunding: any;
    editFunding: any;
    editTranslatedTitle: any;
    lastIndexedTerm: any;
    togglzDialogPrivacyOption: boolean;
    sortedCountryNames: any;
    countryNamesToCountryCodes: any;

    constructor(
        private commonService: CommonService,
        private fundingService: FundingService,
        private modalService: ModalService,
        private featuresService: FeaturesService
    ) {
        this.addingFunding = false;
        this.disambiguatedFunding = {};
        this.editFunding = this.getEmptyFunding();
        this.editTranslatedTitle = false;
        this.lastIndexedTerm = null;   
        this.initCountries();
    }
    
    initCountries(): void {
        this.commonService.getCountryNamesMappedToCountryCodes().pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                this.countryNamesToCountryCodes = data;
                this.sortedCountryNames = [];
                for (var key in this.countryNamesToCountryCodes) {
                    this.sortedCountryNames.push(key);
                }
                this.sortedCountryNames.sort();
            },
            error => {
                console.log('error fetching country names to country codes map', error);
            } 
        );
    };

    addFundingExternalIdentifier(): void {
        console.log
        this.editFunding.externalIdentifiers.push(
            {
                externalIdentifierType: {
                    value: ""
                }, 
                externalIdentifierId: {
                    value: ""
                }, 
                url: {
                    value: ""
                }, 
                relationship: {
                    value: "self"
                } 
            }
        );
    };

    bindTypeaheadForOrgs(): void {
        let numOfResults = 100;
        (<any>$("#fundingName")).typeahead({
            name: 'fundingName',
            limit: numOfResults,
            remote: {
                replace: function () {
                    var q = getBaseUri()+'/fundings/disambiguated/name/';
                    if ($('#fundingName').val()) {
                        q += encodeURIComponent($('#fundingName').val());
                    }
                    q += '?limit=' + numOfResults + '&funders-only=true';
                    return q;
                }
            },
            template: function (datum) {
                var forDisplay =
                    '<span style=\'white-space: nowrap; font-weight: bold;\'>' + datum.value+ '</span>'
                    +'<span style=\'font-size: 80%;\'>'
                    + ' <br />';
                if(datum.city){
                    forDisplay += datum.city;
                }
                if(datum.region){
                    forDisplay += ", " + datum.region;
                }
                if (datum.orgType != null && datum.orgType.trim() != ''){
                    forDisplay += ", " + datum.orgType;
                }
                forDisplay += '</span><hr />';

                return forDisplay;
            }
        });
        $("#fundingName").bind(
            "typeahead:selected", 
            (
                function(obj, datum) {
                    this.selectFunding(datum);
                }
            ).bind(this)
        );
    };

    bindTypeaheadForSubTypes(): void {
        var numOfResults = 20;
        (<any>$("#organizationDefinedType")).typeahead({
            name: 'organizationDefinedType',
            limit: numOfResults,
            remote: {
                replace: function () {
                    var q = getBaseUri()+'/fundings/orgDefinedSubType/';
                    if ($('#organizationDefinedType').val()) {
                        q += encodeURIComponent($('#organizationDefinedType').val());
                    }
                    q += '?limit=' + numOfResults;
                    return q;
                }
            },
            template: function (datum) {
                var forDisplay =
                    '<span style=\'white-space: nowrap; font-weight: bold;\'>' + datum.value + '</span><hr />';
                return forDisplay;
            }
        });
        $("#organizationDefinedType").bind(
            "typeahead:selected", 
            (
                function(obj, datum){
                    this.selectOrgDefinedFundingSubType(datum);
                }
            ).bind(this)
        );
    };


    closeModal(): void {
        this.unbindTypeaheadForOrgs();
        this.unbindTypeaheadForSubTypes();
        this.modalService.notifyOther(
            {
                action:'close', 
                moduleId: 'modalFundingForm'
            }
        );
    };

    createNew(work): void {
        var cloneF = JSON.parse(JSON.stringify(work));
        cloneF.source = null;
        cloneF.putCode = null;
        for (var idx in cloneF.externalIdentifiers){
            cloneF.externalIdentifiers[idx].putCode = null;
        }
        return cloneF;
    }

    deleteFundingExternalIdentifier(obj): void {
        var index = this.editFunding.externalIdentifiers.indexOf(obj);
        this.editFunding.externalIdentifiers.splice(index,1);
    };

    getDisambiguatedFunding = function(id) {
        this.fundingService.getDisambiguatedFunding(id)
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                if (data != null) {
                    this.disambiguatedFunding = data;
                    this.editFunding.disambiguatedFundingSourceId = data.sourceId;
                    this.editFunding.disambiguationSource = data.sourceType;
                }
            },
            error => {
                //console.log("getDisambiguatedFunding", id, error);
            } 
        );
    };

    getEmptyFunding(): any {
        return {
            amount: {
                errors: [],
                value: null
            },
            city: {
                errors: [],
                value: null
            },
            country: {
                errors: [],
                value: null
            },
            currencyCode: {
                errors: []
            },
            description: {
                errors: [],
                value: null
            },
            endDate: {
                day: "",
                month: "",
                year: "",
                errors: [],
            },
            errors: [],
            fundingName: {
                errors: [],
                value: null
            },
            fundingTitle: {
                title: {
                    errors: [],
                    value: null
                },
                translatedTitle: {
                    content: null,
                    errors: []
                }
            },
            fundingType: {
                errors: [],
                value: null
            },
            organizationDefinedFundingSubType: {
                subtype: {
                    errors: [],
                    value: null
                }
            },
            putCode: {
                value: null
            },
            region: {
                errors: [],
                value: null
            },
            startDate: {
                day: "",
                month: "",
                year: "",
                errors: [],
            },
            url: {
                errors: [],
                value: null
            },
            externalIdentifiers: [
                {
                    externalIdentifierType: {
                        value: ""
                    }, 
                    externalIdentifierId: {
                        value: ""
                    }, 
                    url: {
                        value: ""
                    }, 
                    relationship: {
                        value: "self"
                    } 
                } 
            ]
        };
    }

    isValidClass(cur): any {
        let valid = true;

        if (cur === undefined) {
            return '';
        }
        if ( 
            ( cur.required && (cur.value == null || cur.value.trim() == '') ) 
            || 
            ( cur.errors !== undefined && cur.errors.length > 0 ) 
        ) {
            valid = false;
        }

        return valid ? '' : 'text-error';
    };

    isValidStartDate(start): any {
        if (start === undefined) {
            return '';
        }
        
        if (start.errors !== undefined && start.errors.length > 0) {
            return 'text-error';
        }
        
        return '';
    };

    putFunding(): void {
        console.log("put funding:");
        console.log(this.editFunding);
        if (this.addingFunding){    
            return; // don't process if adding funding
        } 
        this.addingFunding = true;
        this.editFunding.errors.length = 0;
        this.fundingService.putFunding( this.editFunding )
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                this.editFunding = data;
                this.addingFunding = false;
                if (data.errors.length > 0){
                    this.editFunding = data;
                    this.commonService.copyErrorsLeft(this.editFunding, data);
                    if(this.editFunding.externalIdentifiers.length == 0) {
                        this.addFundingExternalIdentifier();
                    }  
                } else {
                    this.modalService.notifyOther({action:'close', moduleId: 'modalFundingForm'});
                    //this.removeDisambiguatedFunding();
                    this.fundingService.notifyOther({action:'add', successful:true});
                }
            },
            error => {
                //console.log('setFundingFormError', error);
            } 
        );
    };

    removeDisambiguatedFunding(): void {
        this.bindTypeaheadForOrgs();
        if (this.disambiguatedFunding != undefined) {
            delete this.disambiguatedFunding;
        }
        if (this.editFunding != undefined && this.editFunding.disambiguatedFundingSourceId != undefined) {
            delete this.editFunding.disambiguatedFundingSourceId;
        }
    };

    selectFunding(datum): void {
        if (datum != undefined && datum != null) {
            this.editFunding.fundingName.value = datum.value;
            if(datum.value){
                this.editFunding.fundingName.errors = [];
            }
            this.editFunding.city.value = datum.city;
            if(datum.city){
                this.editFunding.city.errors = [];
            }

            this.editFunding.region.value = datum.region;

            if(datum.country != undefined && datum.country != null) {
                this.editFunding.country.value = datum.country;
                this.editFunding.country.errors = [];
            }

            if (datum.disambiguatedAffiliationIdentifier != undefined && datum.disambiguatedAffiliationIdentifier != null) {
                this.getDisambiguatedFunding(datum.disambiguatedAffiliationIdentifier);
                this.unbindTypeaheadForOrgs();
            }
        }
    };

    selectOrgDefinedFundingSubType(subtype): void {
        if (subtype != undefined && subtype != null) {
            this.editFunding.organizationDefinedFundingSubType.subtype.value = subtype.value;
            this.editFunding.organizationDefinedFundingSubType.alreadyIndexed = true;
            this.lastIndexedTerm = subtype.value;
        }
    };

    serverValidate(relativePath): void {
        if( relativePath == 'fundings/funding/datesValidate.json' ){
            if( this.editFunding.startDate.month == "" 
                || this.editFunding.startDate.day == ""
                || this.editFunding.startDate.year == ""
                || this.editFunding.endDate.month == "" 
                || this.editFunding.endDate.day == ""
                || this.editFunding.endDate.year == ""
                || this.editFunding.startDate.month == null 
                || this.editFunding.startDate.day == null
                || this.editFunding.startDate.year == null
                || this.editFunding.endDate.month == null 
                || this.editFunding.endDate.day == null
                || this.editFunding.endDate.year == null  ){
                return;
            }
        }
        this.fundingService.serverValidate(this.editFunding, relativePath)
        .pipe(    
            takeUntil(this.ngUnsubscribe)
        )
        .subscribe(
            data => {
                if (data != null) {
                    this.commonService.copyErrorsLeft(this.editFunding, data);
                }
            },
            error => {
            } 
        );
    }

    setSubTypeAsNotIndexed(): void {
        if(this.lastIndexedTerm != $.trim($('#organizationDefinedType').val())) {
            this.editFunding.organizationDefinedFundingSubType.alreadyIndexed = false;
        }
    };

    typeChanged(): void {
        var selectedType = this.editFunding.fundingType.value;
        switch (selectedType){
        case 'award':
            $("#funding-ext-ids-title").text(om.get("funding.add.external_id.title.award"));
            $("#funding-ext-ids-value-label").text(om.get("funding.add.external_id.value.label.award"));
            $("#funding-ext-ids-value-input").attr("placeholder", om.get("funding.add.external_id.value.placeholder.award"));
            $("#funding-ext-ids-url-label").text(om.get("funding.add.external_id.url.label.award"));
            $("#funding-ext-ids-url-input").attr("placeholder", om.get("funding.add.external_id.url.placeholder.award"));
            break;
        case 'contract':
            $("#funding-ext-ids-title").text(om.get("funding.add.external_id.title.contract"));
            $("#funding-ext-ids-value-label").text(om.get("funding.add.external_id.value.label.contract"));
            $("#funding-ext-ids-value-input").attr("placeholder", om.get("funding.add.external_id.value.placeholder.contract"));
            $("#funding-ext-ids-url-label").text(om.get("funding.add.external_id.url.label.contract"));
            $("#funding-ext-ids-url-input").attr("placeholder", om.get("funding.add.external_id.url.placeholder.contract"));
            break;
        case 'grant':
            $("#funding-ext-ids-title").text(om.get("funding.add.external_id.title.grant"));
            $("#funding-ext-ids-value-label").text(om.get("funding.add.external_id.value.label.grant"));
            $("#funding-ext-ids-value-input").attr("placeholder", om.get("funding.add.external_id.value.placeholder.grant"));
            $("#funding-ext-ids-url-label").text(om.get("funding.add.external_id.url.label.grant"));
            $("#funding-ext-ids-url-input").attr("placeholder", om.get("funding.add.external_id.url.placeholder.grant"));
            break;
        case 'salary-award':
            $("#funding-ext-ids-value-label").text(om.get("funding.add.external_id.value.label.award"));
            $("#funding-ext-ids-value-input").attr("placeholder", om.get("funding.add.external_id.value.placeholder.award"));
            $("#funding-ext-ids-url-label").text(om.get("funding.add.external_id.url.label.award"));
            $("#funding-ext-ids-url-input").attr("placeholder", om.get("funding.add.external_id.url.placeholder.award"));
            $("#funding-ext-ids-title").text(om.get("funding.add.external_id.title.award"));
            break;
        default:
            $("#funding-ext-ids-title").text(om.get("funding.add.external_id.title.grant"));
            $("#funding-ext-ids-value-label").text(om.get("funding.add.external_id.value.label.grant"));
            $("#funding-ext-ids-value-input").attr("placeholder", om.get("funding.add.external_id.value.placeholder.grant"));
            $("#funding-ext-ids-url-label").text(om.get("funding.add.external_id.url.label.grant"));
            $("#funding-ext-ids-url-input").attr("placeholder", om.get("funding.add.external_id.url.placeholder.grant"));
            break;
        }
    };

    toggleTranslatedTitle(): void{
        this.editTranslatedTitle = !this.editTranslatedTitle;
    };

    unbindTypeaheadForOrgs(): void {
        $('#fundingName').typeahead('destroy');
    };

    unbindTypeaheadForSubTypes(): void {
        $('#organizationDefinedType').typeahead('destroy');
    };

    //Default init functions provided by Angular Core
    ngAfterViewInit() {
        //Fire functions AFTER the view inited. Useful when DOM is required or access children directives
        this.subscription = this.fundingService.notifyObservable$.subscribe(
            (res) => {
                this.bindTypeaheadForOrgs();
                this.bindTypeaheadForSubTypes();
                if( res.funding != undefined ) {
                    this.editFunding = res.funding;
                    if(this.editFunding.orgDisambiguatedId != null){
                        this.getDisambiguatedFunding(this.editFunding.orgDisambiguatedId.value);
                    }
                } else {
                    this.fundingService.getFundingEmpty()
                    .pipe(    
                        takeUntil(this.ngUnsubscribe)
                    )
                    .subscribe(
                        data => {
                            this.editFunding = data
                            
                        },
                        error => {
                            console.log('Error getting blankFunding', error);
                        } 
                    );
                }

                if (this.editFunding.putCode == null) {
                    this.editFunding.putCode = {
                        'value': null
                    };
                }

                if (this.editFunding.fundingTitle == null) {
                    this.editFunding.fundingTitle = {
                        'translatedTitle': {
                            'content': null,
                            'languageCode': null
                        }
                    };
                }

                if (this.editFunding.organizationDefinedFundingSubType == null) {
                    this.editFunding.organizationDefinedFundingSubType = {
                        'subtype': {
                            'value': null
                        }
                    };
                }

                if (this.editFunding.fundingTitle.translatedTitle == null) {
                    this.editFunding.fundingTitle.translatedTitle = {

                        'content': null,
                        'languageCode': null
                    };
                }

                if (this.editFunding.startDate == null) {
                    this.editFunding.startDate = {
                        'month': "",
                        'year': ""
                    };
                }

                if (this.editFunding.endDate == null) {
                    this.editFunding.endDate = {
                        'month': "",
                        'year': ""
                    };
                }

                if(this.editFunding.externalIdentifiers.length == 0) {
                    this.addFundingExternalIdentifier();
                } else {
                    for (var i in this.editFunding.externalIdentifiers){
                        if(!this.editFunding.externalIdentifiers[i].url){
                            this.editFunding.externalIdentifiers[i].url = {
                                'value': "",
                            }; 
                        }
                    }
                }
                console.log(this.editFunding);
            }
        );
        
        this.viewSubscription = this.modalService.notifyObservable$.subscribe(
            (res) => {
                if(res.moduleId == "modalFundingForm") {
                    if(res.action == "open" && res.edit == false) {
                        this.editFunding = this.getEmptyFunding();
                    }
                }
            }
        );
    };

    ngOnDestroy() {
        this.unbindTypeaheadForOrgs();
        this.unbindTypeaheadForSubTypes();
  
        this.ngUnsubscribe.next();
        this.ngUnsubscribe.complete();
    };

    ngOnInit() {
        this.togglzDialogPrivacyOption = this.featuresService.isFeatureEnabled('DIALOG_PRIVACY_OPTION')
    }; 
}

