<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script language="javascript" type="text/javascript" src="js/flot/jquery.js"></script>
<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.js"></script>
<script language="javascript" type="text/javascript" src="js/flot/jquery.flot.pie.js"></script>

<style>
	#placeholder {
		width: 300px;
		height: 250px;
		position: relative;
	}
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
	<center><h2><b> <font face ="Arial"> Aguarde enquanto estamos analisando os dados </font> </b></h2></center>
</div>
<cfflush>
<cfinvoke component="cfm.components.emails" method="getOrderStatus" returnVariable="status"></cfinvoke>


<script type="text/javascript">

	$(document).ready(function() { 
		$('.load').fadeOut("slow");
		configChart();
	});

	function configChart()
	{
		<cfoutput> var #toScript(status, "status")#; </cfoutput>

		var data = [];

		data[0] = 
		{
			label: "Pedidos Processados (" +  status.processed + ")",
			data: status.processed
		};

		data[1] = 
		{
			label: "Pedidos Rejeitados (" +  status.rejected + ")",
			data: status.rejected
		};

		var placeholder = $("#placeholder");

		$.plot(placeholder, data, {
					series: {
						pie: { 
							show: true
						},
					    grid: {
							hoverable: true,
							clickable:true
						}
					}
				});

	}

</script>

	<!DOCTYPE html>
	<html>
	<head>
	  <meta http-eqliv="Content-Type" content="text/html; charset=utf-8">
	  <title>Teste Planetun</title> 
      <img src="img/planetun(1).png">
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

      <ul class="nav nav-pills pull-right" style="margin-top:20px;margin-right:70%;">
		  <li role="presentation"><a href="teste.cfm">Pedidos</a></li>
		  <li role="presentation" class="active"><a href="#">Status</a></li>
	  </ul>
	</head>
	<body style=" background-color:  #f5f5ef">
		<h3> <b> <font face ="arial"> Status geral </font> </b> </h3>
		<center> <div id="placeholder"></div> </center>
	</body>
	</html>
