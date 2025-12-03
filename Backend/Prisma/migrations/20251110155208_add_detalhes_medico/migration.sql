/*
  Warnings:

  - You are about to drop the `avaliacoes_medicos` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "avaliacoes_medicos" DROP CONSTRAINT "avaliacoes_medicos_avaliador_id_fkey";

-- DropForeignKey
ALTER TABLE "avaliacoes_medicos" DROP CONSTRAINT "avaliacoes_medicos_medico_id_fkey";

-- AlterTable
ALTER TABLE "Medico" ADD COLUMN     "avaliacao_media" DOUBLE PRECISION DEFAULT 0.0,
ADD COLUMN     "biografia" TEXT,
ADD COLUMN     "foto_url" TEXT,
ADD COLUMN     "total_consultas" INTEGER DEFAULT 0;

-- DropTable
DROP TABLE "avaliacoes_medicos";

-- CreateTable
CREATE TABLE "IdiomaMedico" (
    "id_idioma" SERIAL NOT NULL,
    "medico_id" INTEGER NOT NULL,
    "idioma" TEXT NOT NULL,

    CONSTRAINT "IdiomaMedico_pkey" PRIMARY KEY ("id_idioma")
);

-- CreateTable
CREATE TABLE "FormacaoMedica" (
    "id_formacao" SERIAL NOT NULL,
    "medico_id" INTEGER NOT NULL,
    "curso" TEXT NOT NULL,
    "instituicao" TEXT NOT NULL,
    "inicio" INTEGER,
    "fim" INTEGER,

    CONSTRAINT "FormacaoMedica_pkey" PRIMARY KEY ("id_formacao")
);

-- CreateTable
CREATE TABLE "CertificacaoMedica" (
    "id_certificacao" SERIAL NOT NULL,
    "medico_id" INTEGER NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT,
    "instituicao" TEXT,
    "ano" INTEGER,

    CONSTRAINT "CertificacaoMedica_pkey" PRIMARY KEY ("id_certificacao")
);

-- CreateTable
CREATE TABLE "HospitaisMedico" (
    "id_hospital" SERIAL NOT NULL,
    "medico_id" INTEGER NOT NULL,
    "nome" TEXT NOT NULL,
    "cidade" TEXT NOT NULL,
    "estado" TEXT NOT NULL,

    CONSTRAINT "HospitaisMedico_pkey" PRIMARY KEY ("id_hospital")
);

-- CreateTable
CREATE TABLE "ContatoMedico" (
    "id_contato" SERIAL NOT NULL,
    "medico_id" INTEGER NOT NULL,
    "email" TEXT,
    "telefone" TEXT,
    "site" TEXT,
    "endereco" TEXT,

    CONSTRAINT "ContatoMedico_pkey" PRIMARY KEY ("id_contato")
);

-- CreateIndex
CREATE UNIQUE INDEX "ContatoMedico_medico_id_key" ON "ContatoMedico"("medico_id");

-- AddForeignKey
ALTER TABLE "IdiomaMedico" ADD CONSTRAINT "IdiomaMedico_medico_id_fkey" FOREIGN KEY ("medico_id") REFERENCES "Medico"("id_medico") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FormacaoMedica" ADD CONSTRAINT "FormacaoMedica_medico_id_fkey" FOREIGN KEY ("medico_id") REFERENCES "Medico"("id_medico") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CertificacaoMedica" ADD CONSTRAINT "CertificacaoMedica_medico_id_fkey" FOREIGN KEY ("medico_id") REFERENCES "Medico"("id_medico") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "HospitaisMedico" ADD CONSTRAINT "HospitaisMedico_medico_id_fkey" FOREIGN KEY ("medico_id") REFERENCES "Medico"("id_medico") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ContatoMedico" ADD CONSTRAINT "ContatoMedico_medico_id_fkey" FOREIGN KEY ("medico_id") REFERENCES "Medico"("id_medico") ON DELETE RESTRICT ON UPDATE CASCADE;
