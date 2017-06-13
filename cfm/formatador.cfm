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
<script>

$(document).ready(function() { 

	$('.lorem').on('click', function() {
		$('#txtArea').val(
			'se você costuma criar muitos textos utilizando por diversas vezes o recurso copiar e colar de sites variados da internet,com certeza sabe a dificuldade que é ter de lidar com as diferentes formatações das páginas web que vem junto com o texto copiado.imagine você copiar 5 parágrafos,cada um de um site diferente,e agora ter que padronizar a formatação em cada um deles:padronizar a fonte,tamanho,remover os hiperlinks,remover sublinhados,itálicos e negritos,espaçamento,tabulação,etc'
			);
		console.log("oi");
	});

});
</script>
<html>
<head>
	  <meta http-eqliv="Content-Type" content="text/html; charset=utf-8">
	  <title>Teste Planetun</title> 
      <img src="img/planetun(1).png"></head>
<body>
<cfform action="actionpage.cfm" name="formatter" method="post"> 
	<h4> <b> <p style="margin-left: 30px; margin-top:20px;">  Insira o texto a ser formatado </p> </b> </h4> 
	<cftextarea required="Yes" id="txtArea" name="txtFormat" style="margin-left: 20px; width: 800px; height: 300px;" message="Favor inserir algum texto"/>
	<input class="btn btn-primary" type="submit" name="formatter_submit" style="margin-left: 565px; margin-top:5px;" value="Formatar"> 
	<input class="btn btn-primary lorem pull-left" style="width:150px;margin-top:5px; margin-left:20px;" value="Texto automático"> 
</cfform>
</body>
</html>