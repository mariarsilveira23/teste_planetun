# teste_planetun

<b>1- </b>     Quanto tempo (em horas) seria necessário para  desenvolver um método para receber os emails e separar as informações contidas no corpo da mensagem?
        <p> <i>Aproximadamente 8 horas (1 dia), considerando que sejam utilizadas expressões regulares (regex) e minha pouca experiência com elas.
        </p> </i>
<b>2-</b>     Qual CFTAG (função do CF) seria utilizada para acessar a caixa de emails (conta no GOOGLE)?
      <p> <i> cfimap --> https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-i/cfimap.html
       </p> </i>
<b>3-</b>     Explique como você controlaria os e-mails que já foram processados e como separaria as informações de cada bloco de texto.
      <p> <i> No teste, a caixa de e-mails do Google foi utilizada para separar os e-mails de pedidos ainda não processados e os já processados.
       Os e-mails que estão no inbox indicam que ainda não foram processados pelo sistema. 
       O sistema identifica esses e-mails, move-os para a caixa de E-mails processados e lê os pedidos existentes.
      Já em um abiente 'real', esse controle deve ser feito via Banco de Dados. <br>
      Para separar as informações essenciais do e-mail, foram utilizadas funções do ColdFusion para manipular string, principalmente: <br>
      <p>  - REMatch("regex", variavel); </p>
      <p>  - variavel.Split("string"); </p>
      Juntamente com cfloops, structs e arrays.
      </p> </i>

<b>OBS.:</b> Para que o programa rode corretamente, o seguinte Mapping deve ser adicionado: <br>
	
  - Logical Path	 	/cfm/components 	
  - Directory Path  C:/ColdFusion2016/cfusion/wwwroot/cfm/gmail_pedidos/components/ 
