<!-- Este tutorial foi desenvolvido e testado em linux debian 12 para funcionar em windows pode precisar de algumas alteraçoes nos comandos -->
<!-- No final do script vai devolver as keys do cosmos e da storage -->
1:  cd script
    bash dbestorage.sh

2:  cd script  
    bash webapp.sh

<!-- Para o caso de perder as keys apresentadas no terminal -->
echo "cosmos key"
az cosmosdb keys list -n simoes -g tp | grep primaryM
echo "storage key"
az storage account keys list -g tp -n simoesstorage | grep value

3:   atualizar cosmos key em: 

    3.1: vm/cloud-init.yaml 
    <!-- linha-13 -->

    3.2: webapp/.env 

    3.3: no site da azure no recurso webapp tonytectos settings, (x)environment variables, add, adicionar as duas variaveis com os mesmos nomes que webapp/.env NÃO ESQUECER CLICAR APLY NOS 2 BOTOES 

4:   atualizar storage key em function/upload.js linha-7 AccountKey=<alterar>;

5:  cd vm 
    bash vm.sh
<!-- automaticamente adiciona os artigos na bd se nao funcionar conectar com a vm por ssh (ssh <ip> -l tony) (password: !Tonytectos!) e correr (cd app), (python3 script.py) -->

6:  cd function
    node upload.js
<!-- cria as thumbnails e adiciona as fotos e thumbnails ao blob storage -->

7:  bash script/deploywebapp.sh
<!-- executa o deploy diretamente do repositorio github, utilizando um token de acesso criado na conta github --> 



