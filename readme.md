Este tutorial foi desenvolvido e testado em linux debian 12 para funcionar em windows pode precisar de algumas alteraçoes nos comandos

1: criar grupo de recursos base de dados e storage. No final do script vai devolver as keys do cosmos e da storage

    cd script
    bash dbestorage.sh

2: criar a aplicação web 

    cd script  
    bash webapp.sh

Para o caso de perder as keys apresentadas no terminal

    echo "cosmos key"
    az cosmosdb keys list -n simoes -g tp | grep primaryM
    echo "storage key"
    az storage account keys list -g tp -n simoesstorage | grep value

3:   atualizar cosmos key em: 
 3.1:  <!-- linha-13 -->

    vm/cloud-init.yaml 

3.2: 

    webapp/.env 

3.3: no site da azure no recurso webapp tonytectos settings, (x)environment variables, add, adicionar as duas variaveis com os mesmos nomes que NÃO ESQUECER CLICAR APLY NOS 2 BOTOES 

    cat webapp/.env 

4:   atualizar storage key na linha-7 AccountKey=<alterar>;

    function/upload.js 


5: automaticamente adiciona os artigos na bd se nao funcionar conectar com a vm por ssh (ssh <ip> -l tony) (password: !Tonytectos!) e correr (cd app), (python3 script.py) 

    cd vm 
    bash vm.sh

6:  Cria as thumbnails e adiciona as fotos e thumbnails ao blob storage

    cd function
    node upload.js


7:  executa o deploy diretamente do repositorio github, utilizando um token de acesso criado na conta github 

    bash script/deploywebapp.sh




