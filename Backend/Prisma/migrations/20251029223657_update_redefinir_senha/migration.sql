-- CreateTable
CREATE TABLE "RedefinirSenha" (
    "id_redefinir" SERIAL NOT NULL,
    "usuario_id" INTEGER NOT NULL,
    "email" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expira_em" TIMESTAMP(3) NOT NULL,
    "usado" BOOLEAN NOT NULL DEFAULT false,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "RedefinirSenha_pkey" PRIMARY KEY ("id_redefinir")
);

-- CreateIndex
CREATE UNIQUE INDEX "RedefinirSenha_token_key" ON "RedefinirSenha"("token");

-- CreateIndex
CREATE INDEX "RedefinirSenha_usuario_id_idx" ON "RedefinirSenha"("usuario_id");

-- CreateIndex
CREATE INDEX "RedefinirSenha_expira_em_idx" ON "RedefinirSenha"("expira_em");

-- AddForeignKey
ALTER TABLE "RedefinirSenha" ADD CONSTRAINT "RedefinirSenha_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;
