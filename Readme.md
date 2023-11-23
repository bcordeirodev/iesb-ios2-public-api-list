## API Publics List - IOS2
Descrição
O API Publics List é um aplicativo iOS desenvolvido em Swift 5.9, utilizando a arquitetura MVVM (Model-View-ViewModel) com UIKit como framework de interface. O objetivo principal do aplicativo é consumir uma série de APIs disponíveis, listar os dados resultantes e permitir que os usuários filtrem a lista, além de visualizar detalhes das informações provenientes das APIs.

## Requisitos
Swift 5.9
Xcode 15
iOS 13+
Configuração do Ambiente
Certifique-se de ter o Xcode 15 instalado no seu ambiente de desenvolvimento. Clone este repositório e abra o projeto API Publics List.xcodeproj no Xcode.

## Arquitetura MVVM
O projeto segue a arquitetura MVVM, garantindo uma separação clara de responsabilidades:

- Model: Contém as classes que representam os dados provenientes das APIs.
- View: Responsável pela interface do usuário, incluindo a exibição da lista de itens e os detalhes das informações.
- ViewModel: Gerencia a lógica de apresentação e interação entre a View e o Model, além de realizar a chamada às APIs.
Consumo de APIs e Listagem

A tela inicial exibe uma lista dos itens obtidos através das APIs disponíveis. A aplicação realiza a chamada a essas APIs e exibe os dados na interface do usuário.

# Filtragem e Visualização Detalhada
Os usuários têm a capacidade de filtrar a lista de itens de acordo com critérios específicos. Além disso, ao tocar em um item da lista, eles podem visualizar informações detalhadas sobre o mesmo.

# Testes Unitários com XCLab
O projeto inclui testes unitários utilizando o framework XCLab para garantir a integridade e o correto funcionamento das classes e métodos principais responsáveis pelo consumo das APIs e manipulação dos dados.

# Autor
Bruno Cordeiro da Silva

Marticula: 2373171022