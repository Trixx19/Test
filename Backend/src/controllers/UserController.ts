import { Request, Response } from "express";
import { UserModel } from "../models/UserModel.js";
import { createUserSchema } from "../validations/userValidation.js";
import { ZodError } from "zod";

export class UserController {
  static async create(req: Request, res: Response) {
    try {
      const validatedData = createUserSchema.parse(req.body);

      const emailExiste = await UserModel.findByEmail(validatedData.email);
      if (emailExiste) {
        return res.status(409).json({
          error: "Email já cadastrado",
        });
      }

      if (validatedData.medico) {
        const crmExiste = await UserModel.findByCRM(validatedData.medico.crm);
        if (crmExiste) {
          return res.status(409).json({
            error: "CRM já cadastrado",
          });
        }
      }

      const novoUsuario = await UserModel.create(validatedData);

      // Remover dados sensíveis
      const usuarioResponse = UserModel.removeSensitiveData(novoUsuario);

      return res.status(201).json({
        message: "Usuário criado com sucesso",
        usuario: usuarioResponse,
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

      console.error("Erro ao criar usuário:", error);
      return res.status(500).json({
        error: "Erro interno do servidor",
      });
    }
  }

  static async FindById(req: Request, res: Response) {
    try {
      const idParam = req.params.id;

      if (!idParam) {
        return res.status(400).json({ error: "ID inválido" });
      }

      const id = parseInt(idParam, 10);

      if (isNaN(id) || id <= 0) {
        return res.status(400).json({ error: "ID inválido" });
      }

      const usuario = await UserModel.findById(id);

      if (!usuario) {
        return res.status(404).json({ error: "Usuário não encontrado" });
      }

      const usuarioResponse = UserModel.removeSensitiveData(usuario);
      return res.status(200).json({ usuario: usuarioResponse });
    } catch (error) {
      console.error("Erro ao buscar usuário:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async update(req: Request, res: Response) {
    try {
      const idParam = req.params.id;  
      if (!idParam) {
        return res.status(400).json({ error: "ID inválido" });
      }
      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0) {
        return res.status(400).json({ error: "ID inválido" });
      }
      const updatedData = req.body;
      const usuarioAtualizado = await UserModel.update(id, updatedData);
      const usuarioResponse = UserModel.removeSensitiveData(usuarioAtualizado);
      return res.status(200).json({ usuario: usuarioResponse });
    } catch (error) {
      console.error("Erro ao atualizar usuário:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async delete(req: Request, res: Response) {
    try {
      const idParam = req.params.id;  
      if (!idParam) {
        return res.status(400).json({ error: "ID inválido" });
      }
      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0) {
        return res.status(400).json({ error: "ID inválido" });
      }
      await UserModel.delete(id);
      return res.status(200).json({ message: "Usuário deletado com sucesso" });
    } catch (error) {
      console.error("Erro ao deletar usuário:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
}
