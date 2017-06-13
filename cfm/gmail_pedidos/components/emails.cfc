<cfcomponent displayname="Emails" hint="This will manipulate e-mails">

 <cffunction name="loadProcessedEmails" hint="loads all processed e-mails" returntype="array">
 	 <cfimap server = "imap.gmail.com" Timeout=6000 username = "maria.silveira.teste.planetun@gmail.com" action="open" Secure="yes" password = "planetun" connection = "test.cf.gmail"> 
	<cfset emailsArray = ArrayNew(1)>
    <cfimap action="getall" folder ="Pedidos Processados" connection="test.cf.gmail" name="querygetall"> 
    <cfloop query = "querygetall"> 
      <cfset emailsStruct = StructNew()>
      <cfset emailsStruct["from"] = #from# />
	  <cfset emailsStruct["body"] = #body# />
	  <cfset emailsStruct["uid"] = #uid# />
	  <cfset emailsStruct["sentDate"] = #sentDate# />
	  <cfset arrayAppend(emailsArray, emailsStruct)/>
	</cfloop> 
	<cfimap  action="close" connection = "test.cf.gmail"> 
   <cfreturn emailsArray>
 </cffunction>

 <cffunction name="getDataProcessedEmails" hint="Extract valuable data from processed e-mails" returntype="array">
 	<cfargument name="emailsArray" required="true" type="array">
 	<cfimap server = "imap.gmail.com" Timeout=6000 username = "maria.silveira.teste.planetun@gmail.com" action="open" Secure="yes" password = "planetun" connection = "test.cf.gmail"> 

	<cfset arrEmails = ArrayNew(1)>

     <cfloop from="1" to="#arrayLen(emailsArray)#" index="i">

		<cfset arrItens = ArrayNew(1)>
   		<cfset order = StructNew()>

       	<cfset email = emailsArray[i].body.Split("ATENÇÃO:")>
       	<cfset email_prod = email[2].Split('PEÇAS')>
       	<cfset email_dt = email[2]>

		<cfset arrClient = REMatch("([^/ÇAS]([Ano|Veículo|Placa|Qtde Portas|Ar Condicionado|Chassi|Direção Hidráulica|Freio ABS]+:.*))", #email[1]#) />

		<cfset arrProducts = REMatch("[^R\$][A-Za-z]+.*?(?=R\$)", #email_prod[3]#)/>
		<cfset arrID = REMatch("\s+\d{6}\s+", #email_prod[3]#)/>
		<cfset arrQtd = REMatch("\s+\d{1,5}\s+", #email_prod[3]#)/>
		<cfset arrPreco = REMatch("(R\$\s+\d+\W+\d+)", #email_prod[3]#)/>
		<cfset arrCod = REMatch("\s+\d{8}\s+", #email_prod[3]#)/>

		<cfloop from="1" to="#arrayLen(arrProducts)#" index="k">
   			<cfset item = StructNew()>
   			<cfset item["product"] = arrProducts[k]/>
   			<cfset item["id"] = arrID[k]/>
   			<cfset item["qtd"] = arrQtd[k]/>
   			<cfset item["price"] = arrPreco[k]/>
   			<cfif ArrayIsDefined(arrCod, k)>
   				<cfset item["cod"] = arrCod[k]/>
   			<cfelse>
   				<cfset item["cod"] = "-" />
   			</cfif>
   			<cfset arrayAppend(arrItens, item)>
		</cfloop>

		<cfset arrDtDelivery = REMatch("([^:]+\d+\W+[$\d\s]+\s+[/$P]+)", #email_dt#) />

    	<cfset order["Client"] = emailsArray[i].from/>
		<cfset order["Vehicle"] = arrClient />
		<cfset order["Products"] = arrItens />
		<cfset order["dtDelivery"] = arrDtDelivery />
		<cfset order["dtOrder"] = emailsArray[i].sentDate />
		<cfset order["ID"] = emailsArray[i].uid/>
		<cfset arrayAppend(arrEmails, order)>
	</cfloop> 

	<cfimap  action="close" connection = "test.cf.gmail"> 
   <cfreturn arrEmails>
 </cffunction>

 <cffunction name="CheckInbox" hint="Check if inbox folder has e-mails">
  	<cfimap server = "imap.gmail.com" Timeout=6000  username = "maria.silveira.teste.planetun@gmail.com" action="open" Secure="yes" password = "planetun" connection = "test.cf.gmail"> 
 	<cfimap action="getall" connection="test.cf.gmail" name="querygetall"> 
    <cfloop query = "querygetall"> 
        <cfif  Trim(#subject#) IS "Pedido">
    		<cfimap action="MoveMail" newfolder="Pedidos Processados" uid=#uid# stoponerror="true" connection="test.cf.gmail">	   	
	    <cfelse> 
			<cfimap action="MoveMail" newfolder="Pedidos Rejeitados" uid=#uid# stoponerror="true" connection="test.cf.gmail">	    	
		</cfif>
	</cfloop> 
	<cfimap  action="close" connection = "test.cf.gmail"> 
 </cffunction>

  <cffunction name="getOrderStatus" hint="Get processed or nor processede-mails" returntype="struct">
   <cfimap server = "imap.gmail.com" Timeout=6000 username = "maria.silveira.teste.planetun@gmail.com" action="open" Secure="yes" password = "planetun" connection = "test.cf.gmail"> 
   <cfset status = StructNew()>
   <cfimap action="ListAllFolders" connection="test.cf.gmail" name="queryListAll"> 
     <cfloop query = "queryListAll"> 
     	<cfif #NAME# is "Pedidos Processados">
			<cfset status["processed"] = #TOTALMESSAGES#/>
		</cfif>
     	<cfif #NAME# is "Pedidos Rejeitados">
			<cfset status["rejected"] = #TOTALMESSAGES#/>
     	</cfif>
     </cfloop>
  	<cfimap  action="close" connection = "test.cf.gmail"> 
  	<cfreturn status>
 </cffunction>

</cfcomponent>