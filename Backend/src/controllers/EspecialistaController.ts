import { Request, Response } from "express";
import { ZodError } from "zod";
import { EspecialistaModel } from "../models/EspecialistaModel";
import { searchEspecialistaSchema } from "../validations/especialistasValidation";

export class EspecialistaController {

  static async search(req: Request, res: Response) {
    try {
      const validatedQuery = searchEspecialistaSchema.parse(req.query);

      const result = await EspecialistaModel.search(validatedQuery);

      return res.status(200).json(result);
    } catch (error) {
      if (error instanceof ZodError) {
        return res.status(400).json({
          error: "Filtros inválidos",
          details: error.issues.map((err) => ({
            campo: err.path.join("."),
            mensagem: err.message,
          })),
        });
      }

      console.error("Erro ao buscar especialistas:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async show(req: Request, res: Response) {
    try {
      const idParam = req.params.id as string;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });

      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const especialista = await EspecialistaModel.findById(id);

      if (!especialista)
        return res.status(404).json({ error: "Especialista não encontrado" });

      return res.status(200).json({ data: especialista });
    } catch (error) {
      console.error("Erro ao buscar especialista:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async delete(req: Request, res: Response) {
    try {
      if (!req.user || req.user.tipo_usuario !== "ADMIN") {
        return res.status(403).json({ error: "Acesso negado" });
      }

      const idParam = req.params.id as string; 
      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0) return res.status(400).json({ error: "ID inválido" });

      const existe = await EspecialistaModel.findById(id);
      if (!existe) return res.status(404).json({ error: "Especialista não encontrado" });

      await EspecialistaModel.delete(id);

      return res.status(200).json({ message: "Especialista removido com sucesso" });
    } catch (error) {
      console.error("Erro ao deletar especialista:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
}