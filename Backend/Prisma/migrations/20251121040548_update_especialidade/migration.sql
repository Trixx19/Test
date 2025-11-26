/*
  Warnings:

  - You are about to drop the column `avaliacao_media` on the `Medico` table. All the data in the column will be lost.
  - You are about to drop the column `biografia` on the `Medico` table. All the data in the column will be lost.
  - You are about to drop the column `foto_url` on the `Medico` table. All the data in the column will be lost.
  - You are about to drop the column `total_consultas` on the `Medico` table. All the data in the column will be lost.
  - You are about to drop the `CertificacaoMedica` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ContatoMedico` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `FormacaoMedica` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `HospitaisMedico` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `IdiomaMedico` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."CertificacaoMedica" DROP CONSTRAINT "CertificacaoMedica_medico_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."ContatoMedico" DROP CONSTRAINT "ContatoMedico_medico_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."FormacaoMedica" DROP CONSTRAINT "FormacaoMedica_medico_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."HospitaisMedico" DROP CONSTRAINT "HospitaisMedico_medico_id_fkey";

-- DropForeignKey
ALTER TABLE "public"."IdiomaMedico" DROP CONSTRAINT "IdiomaMedico_medico_id_fkey";

-- AlterTable
ALTER TABLE "Medico" DROP COLUMN "avaliacao_media",
DROP COLUMN "biografia",
DROP COLUMN "foto_url",
DROP COLUMN "total_consultas";

-- DropTable
DROP TABLE "public"."CertificacaoMedica";

-- DropTable
DROP TABLE "public"."ContatoMedico";

-- DropTable
DROP TABLE "public"."FormacaoMedica";

-- DropTable
DROP TABLE "public"."HospitaisMedico";

-- DropTable
DROP TABLE "public"."IdiomaMedico";

-- CreateTable
CREATE TABLE "avaliacoes_medicos" (
    "id" SERIAL NOT NULL,
    "nota" INTEGER NOT NULL,
    "comentario" TEXT,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "avaliador_id" INTEGER NOT NULL,
    "medico_id" INTEGER NOT NULL,

    CONSTRAINT "avaliacoes_medicos_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "avaliacoes_medicos" ADD CONSTRAINT "avaliacoes_medicos_avaliador_id_fkey" FOREIGN KEY ("avaliador_id") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "avaliacoes_medicos" ADD CONSTRAINT "avaliacoes_medicos_medico_id_fkey" FOREIGN KEY ("medico_id") REFERENCES "Medico"("id_medico") ON DELETE RESTRICT ON UPDATE CASCADE;
