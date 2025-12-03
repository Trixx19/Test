Projeto Super Brasil Telessaúde

Este é o repositório principal da plataforma digital de saúde da Super Brasil Telessaúde. O projeto é focado na disseminação de conteúdo de saúde através de uma plataforma de Blog e um CMS (Content Management System) personalizado.

O sistema é desenvolvido com tecnologias Full Stack modernas (React, Node.js e PostgreSQL), seguindo as melhores práticas de versionamento, segurança e responsividade.

📂 Estrutura de Pastas

O projeto segue uma arquitetura cliente-servidor e está dividido nas seguintes pastas:

/
├── Backend/      (API em Node.js, Express, Prisma)
├── Frontend/     (Aplicação em React)
└── README.md     (Este ficheiro)


📦 Módulos

1. Backend

O backend é uma API RESTful construída com Node.js, Express e Prisma. É responsável por toda a lógica de negócio, gestão de utilizadores (RF01), autenticação, e comunicação com o banco de dados PostgreSQL.

Para detalhes completos sobre a API, endpoints, e como configurar e rodar o backend localmente, veja a documentação específica dentro da pasta:

➡️ Documentação Completa do Backend

2. Frontend

O frontend é uma aplicação web responsiva construída em React. É a interface pública onde os leitores podem aceder aos artigos (RF07) e pesquisar (RF08). Também inclui o painel administrativo (CMS) para gestão de conteúdo (RF02, RF10).

Para detalhes sobre como configurar e rodar o frontend, veja a documentação específica dentro da pasta:

➡️ Documentação do Frontend (A ser preenchida pela equipa de Frontend)

🚀 Como Rodar o Projeto Completo

Para rodar o projeto inteiro, você precisará de dois terminais abertos (um para o Backend e um para o Frontend).

1. Clonar o Repositório

git clone [URL_DO_SEU_REPOSITORIO]
cd [NOME_DA_PASTA_RAIZ]


2. Configurar e Rodar o Backend

Navegue até à pasta do backend e siga as instruções detalhadas no README.md dele.

O resumo é:

cd Backend
npm install
cp .env.exemplo .env


Edite o ficheiro .env com as suas credenciais do PostgreSQL.

Corra as migrações para criar as tabelas no banco:

npx prisma migrate dev


Inicie o servidor:

npm run dev


O servidor backend estará a rodar (ex: http://localhost:3000).

3. Configurar e Rodar o Frontend

Abra um novo terminal.

Navegue até à pasta do frontend.

Siga as instruções do README.md do frontend. O resumo (provavelmente) será:

cd Frontend
npm install
# (Pode haver um passo de .env do frontend aqui)
npm run dev


A aplicação frontend estará a rodar (ex: http://localhost:5173).