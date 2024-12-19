# :shield: New Store

Este projeto foi um desafio para construir um app do zero, onde o objetivo era desenvolver um app de uma loja virtual ou marketplace, contendo uma lista de produtos na tela principal com pesquisa ativa, uma tela de detalhes dos produtos e uma tela com a lista de produtos favoritos caso existam produtos favoritados.
  
## :computer: Tecnologias, APIs, Packages utilizados:
  
  * Flutter / Dart
  * VSCode IDE
  * Flutter Modular
  * Package Dio
  * Package Google Fonts
  * Package Auto Size Text
  * Package Intl
  * Transparent Image
  * Package Shimmer
  * Package Shared Preferences
  * Package Moktail
  * Package Flutter SVG
  * Mobx
  * Flutter Mobx
  
## :file_folder: Organização de pastas e arquivos do projeto:

![image](https://github.com/ivanluizjr/new_store/assets/41458938/6df6d6a6-bb41-458a-b8b7-c944e4b8b9c9)
 
## :keyboard: Estágios de desenvolvimento do projeto:

  - Seguindo os conceitos de uma arquitetura limpa, fiz a organização das pastas do nosso projeto e configurações de pacotes e widgets 
  que utilizariamos durante o desenvoltimento, como também toda a configuração inicial necessária para um app.

  - A arquitetura escolhida foi o Clean Architecture, como boas práticas comecei pelas camadas internas, ou seja, a camada de usecases, 
  implementando após a camada de repositories e por ultimo a camada de datasource que é nossa camada de comunicação externa com banco de 
  dados e Apis, com isso modelando a regra de negócio do projeto.
  
  - O desenvolvimento foi baseado em um mockup de loja online ou marketplace.
  
  - Conforme solicitado no desafio, a gerência de estado das telas foi feita com Mobx.

  - Também junto no design system, que está concentrado na pasta Core, criei vários serviços e widgets necessários para melhorar o 
  desenvolvimento, desde meu próprio média query por exemplo, como também meu próprio either.

  - Teste fiz os teste das camadas principais que envolve nossa regra de negócio, testando nosso usecase, nosso repository implementação 
  e nosso datasource implementação, também os testes de widgets das telas do usuário.

  - Resumindo o app, ele é composto de uma tela principal com lista de produtos, uma tela de detalhes dos produtos e uma tela com os 
  produtos que são favoritos pelo usuário. Na tela principal temos um filtro da lista de produtos em tempo real, não fazendo diferença 
  entre letras maiúsculas ou minúsculas para pesquisa, ao navegar para tela de detalhe por exemplo e voltar a pesquisa não é apagada, a 
  lista de produtos só recarrega novamente quando o usuário apaga a pesquisa atual. A tela de favoritos se navegada sem produtos, apresenta um tratamento dizendo ao usuário
  que não existem produtos na lista naquele momento e ele pode voltar para tela principal. Mesmo tratamento quando o usuário digitar algum produto que não exista na lista,
  existe um tratamento também mostrando uma mensagem para o usuário, ele pode voltar e recarregar a lista e tentar nova pesquisa. Caso também o device fique sem internet,
  o usuário é logado em uma tela dizendo que não existe conexão e existe um botão para voltar ele pra home, caso ainda fique sem internet ele vai ficar na mesma tela,
  só carregando a home quando ele clicar e a internet em seu device tiver voltado.
  
  - Para rodar o projeto você precisa clonar o mesmo e executar em uma IDE de sua preferência utilizando um emulador ou gerar um APK e rodar em seu aparelho Android.

  - **IMPORTANTE**, o projeto foi desenvolvido na SDK 3.5.3 do Dart, podendo talvez não rodar em SDKs inferiores.
 
##

 # :iphone: Layout do App
  
  
  https://github.com/user-attachments/assets/0ca1e7a6-7fe3-4fad-959f-062f49acb9ce


 #
  
  ![FLutter-1](https://user-images.githubusercontent.com/41458938/161364495-d0dbe155-75f3-4a03-a58f-307d9212b8aa.png)



