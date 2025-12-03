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
