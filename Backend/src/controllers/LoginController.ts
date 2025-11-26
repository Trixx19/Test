import { Request, Response } from "express";
import { UserModel } from "../models/UserModel.js";
import { loginSchema } from "../validations/loginValidation.js";
import { ZodError } from "zod";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { jwtConfig } from "../config/jwt.config.js";

interface TokenPayload {
  id: number;
  tipo_usuario: string;
}

export class LoginController {
  static async login(req: Request, res: Response) {
    try {
      const validatedData = loginSchema.parse(req.body);

      const usuario = await UserModel.findByEmail(validatedData.email);
      if (!usuario) {
        return res.status(401).json({
          error: "Credenciais inválidas",
        });
      }

      const senhaCorreta = await bcrypt.compare(
        validatedData.senha,
        usuario.senha_hash
      );

      if (!senhaCorreta) {
        return res.status(401).json({
          error: "Credenciais inválidas",
        });
      }

      const payload: TokenPayload = {
        id: usuario.id_usuario,
        tipo_usuario: usuario.tipo_usuario,
      };

      const token = jwt.sign(payload, jwtConfig.secret, {
        expiresIn: jwtConfig.expiresIn,
      });

      const usuarioResponse = UserModel.removeSensitiveData(usuario);

      return res.status(200).json({
        message: "Login realizado com sucesso",
        usuario: usuarioResponse,
        token,
      });
    } catch (error) {
      if (error instanceof ZodError) {
        console.error("Erro de validação no login:", error);
        return res.status(400).json({
          error: "Dados inválidos",
          details:
            error.issues?.map((err) => ({
              campo: err.path.join("."),
              mensagem: err.message,
            })) ?? [],
        });
      }

      console.error("Erro ao realizar login:", error);
      return res.status(500).json({
        error: "Erro interno do servidor",
      });
    }
  }
}
