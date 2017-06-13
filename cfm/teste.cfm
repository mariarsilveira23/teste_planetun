<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!--<cfinclude template="chart.cfm"> -->

<cfprocessingdirective pageencoding = "utf-8">

<style>
	body {
	    background-color:  #f5f5ef;
	}
	.no-js #loader { display: none;  }
	.js #loader { display: block; position: absolute; left: 100px; top: 0; }
	.se-pre-con {
		position: fixed;
		left: 0px;
		top: 0px;
		width: 100%;
		height: 100%;
		z-index: 9999;
		padding-top: 0px;
		background: url(img/balls.gif) center no-repeat  #f5f5ef;
	}
</style>

<div class="se-pre-con load">
	<img src="img/planetun(1).png" > 
	<center><h3><b> Aguarde enquanto estamos trabalhando na lista de pedidos </b></h3></center>
</div>
<cfflush>

<cfobject component = "cfm.components.emails" name = "cfm.components.emails" >

<cfinvoke component="cfm.components.emails" method="CheckInbox"></cfinvoke>
<cfinvoke component="cfm.components.emails" method="loadProcessedEmails" returnVariable="emailsArray"></cfinvoke>
<cfinvoke component="cfm.components.emails" method="getDataProcessedEmails" returnVariable="arrEmails">
    <cfinvokeargument name="emailsArray" value="#emailsArray#" />
</cfinvoke>

<script>

function viewMore(arrEmails, id)
{
	for(var i=0;i<=arrEmails.length-1;i++)
   	{
   		if(arrEmails[i].id == id)
   		{
   			$('.modalViewMoreHeader').html('<h3> <b>Pedido #' + arrEmails[i].id +' </h3> </b>');

   			var carro = arrEmails[i].vehicle[0].split('Veículo:')[1].split('Placa')[0];
   			var placa = arrEmails[i].vehicle[0].split('Placa:')[1].split('Qtde')[0];
   			var portas = arrEmails[i].vehicle[0].split('Portas:')[1].split('Ano')[0];
   			var ano = arrEmails[i].vehicle[0].split('Ano:')[1].split('Chassi')[0];
   			var chassi = arrEmails[i].vehicle[0].split('Chassi:')[1].split('Direção')[0];
   			var direcao = arrEmails[i].vehicle[0].split('Hidráulica:')[1].split('Ar')[0];
   			var ar = arrEmails[i].vehicle[0].split('Condicionado:')[1].split('Freio ')[0];
   			var freio = arrEmails[i].vehicle[0].split('ABS:')[1];
   			var arrProd  = arrEmails[i].products;

   			var html = "<table style='width: 600px;' class='table-striped table-bordered'> <thead> <th> ID </th> <th> Qtd. </th> <th> Cód. </th> <th> Decrição </th> <th> Preço </th> </thead>";

   			for(var i = 0; i <= arrProd.length - 1; i++)
   			{
   				html = html + "<tr>  <td>" + arrProd[i].id.trim() + "</td>" +
			   		   "<td>" + arrProd[i].qtd.trim() + "</td>" +
			   		   "<td>" + arrProd[i].cod.trim() + "</td>" +
			   		   "<td>" + arrProd[i].product.trim() + "</td>" +
			   		   "<td>" + arrProd[i].price.trim() + "</td> </tr>";
   			}
  			html = html + '</tbody> </table>';

   			$('.modalViewMoreBody').html(
   				'<h4> <b>Dados do Veículo </b></h4> ' +
   			     '<table>'+
   				 	'<tr> ' +
	   				 	'<td>' + 
		   				 	'<b> Veículo: </b>'+ carro +
		   				 '</td>' + 
		   				 '<td>' +
		   				 	'<b> <span> &nbsp; </span> Placa: </b>' + placa + 
	   				 	'</td>' + 
   				 	'</tr>' +    				 	
   				 	'<tr> ' +
	   				 	'<td>' + 
		   				 	'<b> Ano: </b>' + ano + 
		   				 '</td>' + 
		   				 '<td>' +
		   				 	'<b> <span> &nbsp; </span> Chassi: </b>' + chassi + 
	   				 	'</td>' + 
   				 	'</tr>' +    
   				 '</table>' +
   				 '<h4> <i> Opcionais </i></h4>' +
   				 '<table>'+
   				 	'<tr> ' +
	   				 	'<td>' + 
		   				 	'<b>Qtd. Portas: </b>'+ portas +
		   				 '</td>' + 
		   				 '<td>' +
		   				 	'<b><span> &nbsp; </span> Direção Hidráulica: </b>'+ direcao +
                         '</td>' + 
   				 	'</tr>' +      				 	
   				 	'<tr> ' +
	   				 	'<td>' + 
		   				 	'<b>Ar Condicionado: </b>'+ ar +
		   				 '</td>' + 
		   				 '<td>' +
		   				 	'<b><span> &nbsp; </span> Freio ABS: </b>'+ freio +
                     	 '</td>' + 
   				 	'</tr>' +    
   				 '</table>' +
   				'<br>' +
   				'<h4> <b>Itens do Pedido </b> </h4>'+ 
   					html);

   			$('.modalViewMore').modal('show');
		}

   	}

}


$(document).ready(function() { 

	$('.load').fadeOut("slow");

	$('.btnMore').on('click', function() {
		var id = $(this).data('id');
		<cfoutput> var #toScript(arrEmails, "arrEmails")#; </cfoutput>
	   	viewMore(arrEmails, id); 
	});	

	$('.btnRefresh').on('click', function() {
		location.reload();
	});

});
</script>

<html> 
	<head> 
	  <meta http-eqliv="Content-Type" content="text/html; charset=utf-8">
	  <title>Teste Planetun</title> 
      <img src="img/planetun(1).png">
      <ul class="nav nav-pills pull-right" style="margin-top:20px;margin-right:70%;">
		  <li role="presentation" class="active"><a href="#">Pedidos</a></li>
		  <li role="presentation"><a href="chart.cfm">Status</a></li>
	  </ul>
	</head> 

	<body>  

		<h3> <b> Pedidos </b> </h3>
		<div id="tbPedidos">
			<button class="pull-right btn btn-warning btnRefresh" style="margin-right:5px"><span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> &nbsp; Atualizar Pedidos</button>
	     	<table class="table table-hover">
	         	<thead>
	         		<th>#</th>
	         		<th>Dt. Pedido </th>
	         		<th>Cliente </th>
	         		<th>Dt. Entrega </th>
	         		<th></th>
 				</thead>
 				<tbody>
		        <cfloop from="1" to="#arrayLen(arrEmails)#" index="i">
			        <tr>
				       	<td><cfoutput>#arrEmails[i].ID#</cfoutput></td>
				       	<td><cfoutput>#arrEmails[i].dtOrder.Split("'")[2].Split("'")[1]#</cfoutput></td>
				       	<td><cfoutput>#arrEmails[i].Client#</cfoutput></td>
				       	<td><cfoutput>#arrEmails[i].dtDelivery[1].Split("P")[1]#</cfoutput></td>
				       	<td><button data-id="<cfoutput>#arrEmails[i].ID#</cfoutput>" type="button" class="btn btn-primary btnMore"><span class="glyphicon glyphicon-th-list"> </span> &nbsp; Ver Mais</button></td>				       	
				    </tr>
	    	    </cfloop>
 				</tbody>
			</table>
	    </div>

		<div class="modal fade modalViewMore" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div style="width: 650px;" class="modal-content">
		      <div class="modal-header modalViewMoreHeader">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title"></h4>
		      </div>
		      <div class="modal-body modalViewMoreBody">
		      </div>
		      <div class="modal-footer">
		      </div>
		    </div>
		  </div>
		</div>
	</body> 
</html>