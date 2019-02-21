<@protected classes=['manage'] nav="settings">
	<div class="row">
		<div class="col-md-3 col-sm-12 col-xs-12 padding-fix">
			<div class="lhs">
			    <#include "/includes/ng2_templates/id-banner-ng2-template.ftl"/>
	            <id-banner-ng2> </id-banner-ng2>
			</div>
		</div>
		<div class="col-md-9">			
			<#include "/includes/ng2_templates/delegators-ng2-template.ftl">
	        <delegators-ng2></delegators-ng2> 
		</div>
	</div>
</@protected>
