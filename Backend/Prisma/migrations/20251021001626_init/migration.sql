-- CreateEnum
CREATE TYPE "TipoUsuario" AS ENUM ('Usuario', 'ADMINISTRADOR');

-- CreateEnum
CREATE TYPE "StatusArtigo" AS ENUM ('RASCUNHO', 'PENDENTE_APROVACAO', 'PUBLICADO');

-- CreateTable
CREATE TABLE "Usuario" (
    "id_usuario" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha_hash" TEXT NOT NULL,
    "tipo_usuario" "TipoUsuario" NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "Medico" (
    "id_medico" SERIAL NOT NULL,
    "usuario_id" INTEGER NOT NULL,
    "especialidade" TEXT NOT NULL,
    "telefone" TEXT NOT NULL,
    "crm" TEXT NOT NULL,

    CONSTRAINT "Medico_pkey" PRIMARY KEY ("id_medico")
);

-- CreateTable
CREATE TABLE "AcaoAdministrativa" (
    "id_acao_admin" SERIAL NOT NULL,
    "descricao" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "usuario_id" INTEGER NOT NULL,

    CONSTRAINT "AcaoAdministrativa_pkey" PRIMARY KEY ("id_acao_admin")
);

-- CreateTable
CREATE TABLE "Artigo" (
    "id_artigo" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "conteudo" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "autor_id" INTEGER NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL,
    "status" "StatusArtigo" NOT NULL,

    CONSTRAINT "Artigo_pkey" PRIMARY KEY ("id_artigo")
);

-- CreateTable
CREATE TABLE "Categoria" (
    "id_categoria" SERIAL NOT NULL,
    "nome_categoria" TEXT NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Categoria_pkey" PRIMARY KEY ("id_categoria")
);

-- CreateTable
CREATE TABLE "CategoriasOnArtigos" (
    "artigo_id" INTEGER NOT NULL,
    "categoria_id" INTEGER NOT NULL,

    CONSTRAINT "CategoriasOnArtigos_pkey" PRIMARY KEY ("artigo_id","categoria_id")
);

-- CreateTable
CREATE TABLE "Comentario" (
    "id_comentario" SERIAL NOT NULL,
    "conteudo" TEXT NOT NULL,
    "artigo_id" INTEGER NOT NULL,
    "usuario_id" INTEGER NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Comentario_pkey" PRIMARY KEY ("id_comentario")
);

-- CreateTable
CREATE TABLE "Visualizacao" (
    "id_visualizacoes" SERIAL NOT NULL,
    "artigo_id" INTEGER NOT NULL,
    "visto_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Visualizacao_pkey" PRIMARY KEY ("id_visualizacoes")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Medico_usuario_id_key" ON "Medico"("usuario_id");

-- CreateIndex
CREATE UNIQUE INDEX "Medico_crm_key" ON "Medico"("crm");

-- CreateIndex
CREATE UNIQUE INDEX "Artigo_slug_key" ON "Artigo"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "Categoria_nome_categoria_key" ON "Categoria"("nome_categoria");

-- AddForeignKey
ALTER TABLE "Medico" ADD CONSTRAINT "Medico_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AcaoAdministrativa" ADD CONSTRAINT "AcaoAdministrativa_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Artigo" ADD CONSTRAINT "Artigo_autor_id_fkey" FOREIGN KEY ("autor_id") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategoriasOnArtigos" ADD CONSTRAINT "CategoriasOnArtigos_artigo_id_fkey" FOREIGN KEY ("artigo_id") REFERENCES "Artigo"("id_artigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategoriasOnArtigos" ADD CONSTRAINT "CategoriasOnArtigos_categoria_id_fkey" FOREIGN KEY ("categoria_id") REFERENCES "Categoria"("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comentario" ADD CONSTRAINT "Comentario_artigo_id_fkey" FOREIGN KEY ("artigo_id") REFERENCES "Artigo"("id_artigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comentario" ADD CONSTRAINT "Comentario_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Visualizacao" ADD CONSTRAINT "Visualizacao_artigo_id_fkey" FOREIGN KEY ("artigo_id") REFERENCES "Artigo"("id_artigo") ON DELETE RESTRICT ON UPDATE CASCADE;
