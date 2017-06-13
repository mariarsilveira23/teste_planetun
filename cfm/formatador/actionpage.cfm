<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<cfprocessingdirective pageencoding = "utf-8">

<style>
body
{
	background-color:  #f5f5ef;
}
</style>

<cfif structKeyExists(form, "formatter_submit")> 

	<cfset string = form.TxtFormat/>

	<cfif #right(string, 1)# neq ".">
		<cfset string = string & "."/>
	</cfif>

	<cfset stringWithUpperCase = "">

	<cfset stringFixerBreaker = reMatch('\w.+?[.?]+', string)>

	<cfloop array="#stringFixerBreaker#" index="i">
		<cfset stringWithUpperCase = stringWithUpperCase & #replaceNoCase(i,left(i, 1 ),uCase(left(i, 1 )))#>
	</cfloop> 

	<cfset stringColor = reMatch('([^\n]{1,101})[\s]*', stringWithUpperCase)>
	<cfset stringColored =""/>
	<cfloop from="1" to="#arrayLen(stringColor)#" index="i">
			<cfif (i MOD 2 EQ 0)>
				<cfset color ='"red"'/>
			<cfelse>
				<cfset color ='"green"'/>
			</cfif>
			
		<cfset stringColored = stringColored & "<font color="& color &">" & "~" & i & " - " & stringColor[i] & "</font>" /> 
	</cfloop> 

	<cfset stringWithParagraph = "<p>" & stringColored>
	<cfset stringSpaced = #rereplace(stringWithParagraph,"\.",". ","ALL")#>
	<cfset stringSpaced = #rereplace(stringSpaced,"\,",", ","ALL")#>
	<cfset stringSpaced = #rereplace(stringSpaced,"\:",": ","ALL")#>
	<cfset stringSpaced = #rereplace(stringSpaced,"\~","<p>","ALL")#>

	<cfset formatParagraph = #stringSpaced.Split('<p>')#/>
	<cfloop from="1" to="#arrayLen(formatParagraph)#" index="i">
		<cfset formatParagraph[i] = " <p align=" & '"justify"' & ">" & formatParagraph[i] />
	</cfloop>

	<cfset txtFinal =""/>

	<cfloop from="1" to="#arrayLen(formatParagraph)#" index="i">
		<cfset txtFinal = txtFinal & formatParagraph[i]/>
	</cfloop>
</cfif>

<html>
<head>
	  <meta http-eqliv="Content-Type" content="text/html; charset=utf-8">
	  <title>Teste Planetun</title> 
      <img src="img/planetun(1).png"></head>
<body>
	<h4> <b> <p style="margin-left: 30px; margin-top:20px;"> Texto Formatado</p> </b> </h4>
	<fieldset style="margin-left:30px; max-width: 700px;">
		<cfoutput>#txtFinal#</cfoutput>
	</fieldset>
	 <input class="btn btn-primary pull-right" style="margin-right: 30px;" type="button" value="Voltar" onClick="history.go(-1)"> 
</body>
</html>