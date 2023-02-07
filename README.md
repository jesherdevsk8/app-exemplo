# README
# Descrição
Esta aplicação não tem nenhuma funcionalidade.
Seu objetivo é servir dapenas de modelo.

# Atividade

Crie um Dockerfile baseado na ultima versão estável da distribuição Debian que contemple todas as depencencias do Gemfile desta aplicação e a faça rodar.

# JESHER MINELLI ALVES
Elaborei o Dockerfile e Empacotei a aplicação de duas formas

1º Algumas versões mais antigas do ruby pede a versão do openssl1.1.1, principalmente em distribuições base ubuntu 22.04, que está vindo com a versão openssl3.0.0, precisa até mesmo fazer um downgrade da lib libssl-dev.
Também precisei baixar a versão do ruby 2.7.2 e compilar. Essa é uma forma um pouco demorada quando se trata de pipeline de entrega continua, geralmente uso essa forma para configurar minha maquina de trabalhando, no caso da versão do ruby, gosto de utilizar o rvm ou o asdf.

2º Usei uma imagem com a versão especifica do ruby. Esse é o jeito mais usual para empacotar uma aplicação rails, além de ser mais fácil de manter e fazer atualizações. Também deixa com melhor desempenho ao buildar o container em uma pipeline de CI/CD.

Utilizei o docker-compose para criar um container postgres e conectar com a aplicação, pois só estou com o mysql instalado na minha máquina