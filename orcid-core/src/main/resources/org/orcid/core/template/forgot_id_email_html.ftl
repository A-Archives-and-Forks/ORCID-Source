<#import "email_macros.ftl" as emailMacros />
<#escape x as x?html>
<!DOCTYPE html>
<html>
	<head>
	<title>${subject}</title>
	</head>
	<body>
		<div style="padding: 20px; padding-top: 0px;">
			<img src="https://orcid.org/sites/all/themes/orcid/img/orcid-logo.png" alt="ORCID.org"/>
		    <hr />
		    <p style="font-family: arial, helvetica, sans-serif; font-size: 15px; color: #494A4C;">
		    	<@emailMacros.msg "email.common.dear" /><@emailMacros.space />${submittedEmail}<@emailMacros.msg "email.common.dear.comma" />
		    </p>
		    <p style="font-family: arial, helvetica, sans-serif; font-size: 15px; color: #494A4C;">
		    	<@emailMacros.msg "email.forgotten_id.orcid_id" /><br />
		    	<a href="${baseUri}/${orcid}?lang=${locale}">${baseUri}/${orcid}</a>
		    </p>
		    <p style="font-family: arial, helvetica, sans-serif; font-size: 15px; color: #494A4C;">
                <@emailMacros.msg "email.common.if_you_have_any" /><@emailMacros.space /><a href='<@emailMacros.msg "email.common.need_help.description.2.href" />' target="orcid.contact_us"><@emailMacros.msg "email.common.if_you_have_any.contact_us" /></a><@emailMacros.msg "email.common.if_you_have_any2" />
		    </p>
 		    <p style="font-family: arial, helvetica, sans-serif; font-size: 15px; color: #494A4C;">		  
				<@emailMacros.msg "email.common.warm_regards" /><br />
				<a href="${baseUri}/home?lang=${locale}">${baseUri}/<a/>
		    </p> 		     		    
			<p style="font-family: arial,  helvetica, sans-serif;font-size: 15px;color: #494A4C;">
				<@emailMacros.msg "email.common.you_have_received_this_email" />
			</p>
			<p style="font-family: arial,  helvetica, sans-serif;font-size: 15px;color: #494A4C;">
			   <#include "email_footer_html.ftl"/>
			</p>
		 </div>
	 </body>
 </html>
 </#escape>
