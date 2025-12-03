import { Request, Response } from "express";
import bcrypt from "bcryptjs";
import crypto from "crypto";
import prisma from "../lib/prisma";
import { EmailService } from "../services/emailServices.js";

export class RecuperarSenhaController {

  // ✅ GERAR TOKEN — GET
  static async solicitarRecuperacao(req: Request, res: Response) {
    try {
      const { email } = req.query;

      if (!email || typeof email !== "string") {
        return res.status(400).json({ error: "E-mail é obrigatório" });
      }

      const usuario = await prisma.usuario.findUnique({
        where: { email },
      });

      // Mensagem sempre igual → segurança
      if (!usuario) {
        return res.status(200).json({
          message:
            "Se este e-mail estiver cadastrado, enviaremos instruções para recuperação.",
        });
      }

      const token = crypto.randomBytes(32).toString("hex");
      const expiraEm = new Date(Date.now() + 60 * 60 * 1000); // 1h

      await prisma.redefinirSenha.create({
        data: {
          usuario_id: usuario.id_usuario,
          email,
          token,
          expira_em: expiraEm,
        },
      });

      // Envia email (não falha a requisição caso erro)
      try {
        await EmailService.sendPasswordRecoveryEmail(
          usuario.email,
          usuario.nome,
          token
        );
      } catch (err) {
        console.warn("⚠ EMAIL NÃO ENVIADO — prosseguindo mesmo assim");
      }

      return res.status(200).json({
        message:
          "Se este e-mail estiver cadastrado, enviaremos instruções para recuperação.",
      });
    } catch (error) {
      console.error("Erro ao solicitar recuperação:", error);
      return res.status(500).json({
        error: "Erro interno ao solicitar recuperação de senha",
      });
    }
  }

  //  VALIDA TOKEN — GET
  static async validarToken(req: Request, res: Response) {
    try {
      const { token, email } = req.query;

      if (!token || !email) {
        return res.status(400).json({
          error: "Token e email são obrigatórios",
        });
      }

      const registro = await prisma.redefinirSenha.findFirst({
        where: {
          token: token.toString(),
          email: email.toString(),
          usado: false,
        },
      });

      if (!registro) {
        return res.status(401).json({ error: "Token inválido" });
      }

      if (registro.expira_em < new Date()) {
        return res.status(401).json({ error: "Token expirado" });
      }

      return res.status(200).json({
        message: "Token válido",
        usuario_id: registro.usuario_id,
      });
    } catch (error) {
      console.error("Erro ao validar token:", error);
      return res.status(500).json({ error: "Erro interno ao validar token" });
    }
  }

  // REDEFINIR SENHA — POST
  static async redefinirSenha(req: Request, res: Response) {
    try {
      const { token, nova_senha } = req.body;

      if (!token || !nova_senha) {
        return res
          .status(400)
          .json({ error: "Token e nova senha são obrigatórios" });
      }

      const registro = await prisma.redefinirSenha.findFirst({
        where: {
          token,
          usado: false,
          expira_em: { gt: new Date() },
        },
      });

      if (!registro) {
        return res.status(401).json({ error: "Token inválido ou expirado" });
      }

      
      const novaSenhaHash = await bcrypt.hash(nova_senha, 10);

      await prisma.usuario.update({
        where: { id_usuario: registro.usuario_id },
        data: { senha_hash: novaSenhaHash },
      });

      await prisma.redefinirSenha.update({
        where: { id_redefinir: registro.id_redefinir },
        data: { usado: true },
      });

      return res.status(200).json({ message: "Senha redefinida com sucesso" });
    } catch (error) {
      console.error("Erro ao redefinir senha:", error);
      return res
        .status(500)
        .json({ error: "Erro interno ao redefinir senha" });
    }
  }
}
