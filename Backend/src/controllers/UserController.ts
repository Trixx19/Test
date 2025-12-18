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
        return res.status(409).json({ error: "Email já cadastrado" });
      }

      let dadosMedicoTratados = undefined;

      if (validatedData.tipo_usuario === "ESPECIALISTA") {
        const crmFinal = validatedData.medico?.crm || validatedData.crm;
        const telefoneFinal = validatedData.medico?.telefone;
        const especialidadeFinal = validatedData.medico?.especialidade;

        if (!crmFinal || !telefoneFinal || !especialidadeFinal) {
           return res.status(400).json({
             error: "Para especialistas, CRM, Telefone e Especialidade são obrigatórios.",
           });
        }

        const crmExiste = await UserModel.findByCRM(crmFinal);
        if (crmExiste) {
          return res.status(409).json({ error: "CRM já cadastrado" });
        }

        dadosMedicoTratados = {
          crm: crmFinal,
          telefone: telefoneFinal,
          especialidade: especialidadeFinal
        };
      }

      const novoUsuario = await UserModel.create({
        nome: validatedData.nome,
        email: validatedData.email,
        senha: validatedData.senha,
        tipo_usuario: validatedData.tipo_usuario,
        medico: dadosMedicoTratados,
      });

      const usuarioResponse = UserModel.removeSensitiveData(novoUsuario);

      return res.status(201).json({
        message: "Usuário criado com sucesso",
        usuario: usuarioResponse,
      });

    } catch (error) {
      if (error instanceof ZodError) {
        return res.status(400).json({
          error: "Dados inválidos",
          details: error.issues.map((err) => ({
            campo: err.path.join("."),
            mensagem: err.message,
          })),
        });
      }
      console.error(error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
  
  static async FindByEmail(req: Request, res: Response) {
    try {
      const email = req.params.email as string;
      
      if (!email) return res.status(400).json({ error: "Email é obrigatório" });

      const usuario = await UserModel.findByEmailIncludingPassword(email);
      if (!usuario) return res.status(404).json({ error: "Usuário não encontrado" });

      const usuarioResponse = UserModel.removeSensitiveData(usuario);
      return res.status(200).json({ usuario: usuarioResponse });
    } catch (error) {
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async FindById(req: Request, res: Response) {
    try {
      const idParam = req.params.id as string;
      const id = parseInt(idParam, 10);
      
      if (isNaN(id)) return res.status(400).json({ error: "ID inválido" });

      const usuario = await UserModel.findById(id);
      const usuarioResponse = UserModel.removeSensitiveData(usuario);
      return res.status(200).json({ usuario: usuarioResponse });
    } catch (error) {
      return res.status(404).json({ error: "Usuário não encontrado" });
    }
  }

  static async update(req: Request, res: Response) {
    try {
      const idParam = req.params.id as string;
      const id = parseInt(idParam, 10);

      if (isNaN(id)) return res.status(400).json({ error: "ID inválido" });
      
      const usuarioAtualizado = await UserModel.update(id, req.body);
      const usuarioResponse = UserModel.removeSensitiveData(usuarioAtualizado);
      return res.status(200).json({ usuario: usuarioResponse });
    } catch (error: any) {
      if (error.message === "Usuário não encontrado") return res.status(404).json({ error: error.message });
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async delete(req: Request, res: Response) {
    try {
      const idParam = req.params.id as string;
      const id = parseInt(idParam, 10);

      if (isNaN(id)) return res.status(400).json({ error: "ID inválido" });
      
      await UserModel.delete(id);
      return res.status(200).json({ message: "Usuário deletado com sucesso" });
    } catch (error: any) {
      if (error.message === "Usuário não encontrado") return res.status(404).json({ error: error.message });
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
}