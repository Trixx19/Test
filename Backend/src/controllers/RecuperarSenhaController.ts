import { Request, Response } from "express";
import bcrypt from "bcryptjs";
import crypto from "crypto";
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();
import { ZodError } from "zod";
import { solicitarRecuperacaoSchema } from "../validations/recuperarSenhaValidation.js";
import { EmailService } from "../services/emailServices.js"; 
export class RecuperarSenhaController {
  static async solicitarRecuperacao(req: Request, res: Response) {
    try {
      const { email } = solicitarRecuperacaoSchema.parse(req.body);
      const usuario = await prisma.usuario.findUnique({
        where: { email },
      });

      if (!usuario) {
        return res.status(200).json({
          message:
            "Se este e-mail estiver cadastrado, enviaremos instruções para recuperação.",
        });
      }

     
      const token = crypto.randomBytes(32).toString("hex");
      const expiraEm = new Date(Date.now() + 30 * 60 * 1000); 

      await prisma.redefinirSenha.create({
        data: {
          usuario_id: usuario.id_usuario,
          email,
          token,
          expira_em: expiraEm,
          usado: false, 
        },
      });

      await EmailService.sendPasswordRecoveryEmail(
        usuario.email,
        usuario.nome,
        token
      );

      return res.status(200).json({
        message:
          "Se este e-mail estiver cadastrado, enviaremos instruções para recuperação.",
      });
    } catch (error) {
      if (error instanceof ZodError) {
        return res.status(400).json({
          error: "Dados inválidos",
          details: error.errors.map((err) => ({
            campo: err.path.join("."),
            mensagem: err.message,
          })),
        });
      }

      console.error("Erro ao solicitar recuperação:", error);
      return res.status(500).json({
        error: "Erro interno ao solicitar recuperação de senha",
      });
    }
  }

  static async redefinirSenha(req: Request, res: Response) {
    try {
      const { token, nova_senha } = req.body;

      if (!token || !nova_senha) {
        return res.status(400).json({ error: "Token e nova senha são obrigatórios" });
      }

      const record = await prisma.redefinirSenha.findFirst({
        where: {
          token: token,                 
          usado: false,
          expira_em: { gt: new Date() }, 
        },
      });

      if (!record) {
        return res.status(400).json({ error: "Token inválido ou expirado" });
      }

      const novaSenhaHash = await bcrypt.hash(nova_senha, 10);
      
      await prisma.usuario.update({
        where: { id_usuario: record.usuario_id },
        data: { senha_hash: novaSenhaHash },
      });

      await prisma.redefinirSenha.update({
        where: { id_redefinir: record.id_redefinir },
        data: { usado: true },
      });

      return res.status(200).json({ message: "Senha redefinida com sucesso" });

    } catch (error) {
      console.error("Erro ao redefinir senha:", error);
      return res.status(500).json({ error: "Erro interno ao redefinir senha" });
    }
  }
  
}