import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, Subject } from 'rxjs';


    
@Injectable({
    providedIn: 'root',
})
export class PeerReviewService {
    private headers: HttpHeaders;
    private notify = new Subject<any>();

    public details: any;
    public groups: any;
    public groupsLabel: any;
    public loading: boolean;
    public offset: any;
    public orgDisambiguatedDetails: any;
    public peerReview: any;
    public peerReviewCount: any;
    public showLoadMore: boolean;
    public type: string;
    
    notifyObservable$ = this.notify.asObservable();
	
    constructor( 
        private http: HttpClient,

    ){
        this.peerReview = null;
        this.headers = new HttpHeaders(
            {
                'Access-Control-Allow-Origin':'*',
                'Content-Type': 'application/json'
            }
        );
        
        this.details = new Array();
        this.groups = new Array();
        this.groupsLabel = null;
        this.loading = true;
        this.type = '';
        this.offset = 0;
        this.showLoadMore = false;

    }

    consistentVis(group): boolean {
        var visibility = group.peerReviewDuplicateGroups[0].peerReviews[0].visibility.visibility;
        for(var i = 0; i < group.peerReviewDuplicateGroups.length; i++) {
            for(var x = 0; x < group.peerReviewDuplicateGroups[i].peerReviews.length; x++) {
                if (group.peerReviewDuplicateGroups[i].peerReviews[x].visibility.visibility != visibility) {
                    return false;
                }
            }
        }
        return true;
    }

    deletePeerReviews(putCodes): Observable<any> {
        return this.http.delete( 
            getBaseUri() + '/peer-reviews/' + putCodes.splice(0,150).join(),             
            { headers: this.headers }
        ) 
    }

    getPeerReviewGroups(sortAsc): Observable<any> {
        this.loading = true;
        return this.http.get(
            getBaseUri() + '/peer-reviews/peer-reviews.json?sortAsc=' + sortAsc
        );
    }

    getPeerReviewById( putCode ): Observable<any> {
        return this.http.get(
            getBaseUri() + '/peer-reviews/peer-review.json?putCode=' + putCode
        );
    }

    getPeerReviewImportWizardList(): Observable<any> {
        return this.http.get(
            getBaseUri() + '/workspace/retrieve-peer-review-import-wizards.json'
        )
    }

    getPublicPeerReviewById( putCode ): Observable<any> {
        return this.http.get(
            getBaseUri() + '/' + orcidVar.orcidId + '/peer-review.json?putCode=' + putCode
        );
    }

    getPublicPeerReviewGroups(sortAsc): Observable<any> {
        this.loading = true;
        return this.http.get(
            getBaseUri() + '/' + orcidVar.orcidId + '/peer-reviews.json?offset=' + '&sortAsc=' + sortAsc
        );
    }

    handleGroupData(data): void {
        this.groups = new Array();
        this.groups = this.groups.concat(data);
        this.peerReviewCount = this.getPeerReviewCount();
        
    }

    notifyOther(data: any): void {
        if (data) {
            this.notify.next(data);
        }
    }

    getPeerReviewCount(): number {
        var count = 0;
        for (var idx in this.groups) {
            count += this.groups[idx].peerReviewDuplicateGroups.length;
        }
        return count;
    }

    resetGroups(): void {
        this.offset = 0;
        this.groups = new Array();
    }

    updateToMaxDisplay(putCode): Observable<any> {
        return this.http.get(
            getBaseUri() + '/peer-reviews/updateToMaxDisplay.json?putCode=' + putCode
        )
    }

    updateVisibility(putCodes, priv): Observable<any> {
        let url = getBaseUri() + '/peer-reviews/' + putCodes.splice(0,150).join() + '/visibility/'+priv;

        return this.http.get(
            url
        )
    }

}