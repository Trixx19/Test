import { Request, Response } from "express";
import { ArticleModel } from "../models/ArticleModel.js";
import {
  createArticleSchema,
  updateArticleSchema,
} from "../validations/articleValidation.js";
import { ZodError } from "zod";

export class ArticleController {
  static async index(_req: Request, res: Response) {
    try {
      const artigos = await ArticleModel.findAll();
      return res.json({ artigos });
    } catch (error) {
      console.error("Erro ao listar artigos:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async show(req: Request, res: Response) {
    try {
      const idParam = req.params.id;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });
      const id = parseInt(idParam, 10);
      if (isNaN(id)) return res.status(400).json({ error: "ID inválido" });

      const artigo = await ArticleModel.findById(id);
      if (!artigo)
        return res.status(404).json({ error: "Artigo não encontrado" });

      return res.json({ artigo });
    } catch (error) {
      console.error("Erro ao buscar artigo:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async store(req: Request, res: Response) {
    try {
      const validated = createArticleSchema.parse(req.body);

      const novo = await ArticleModel.create(validated);
      return res.status(201).json({ message: "Artigo criado", artigo: novo });
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
      if (
        error instanceof Error &&
        error.message.startsWith("Categorias inválidas")
      ) {
        return res.status(400).json({ error: error.message });
      }
      console.error("Erro ao criar artigo:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async update(req: Request, res: Response) {
    try {
      const idParam = req.params.id;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });
      const id = parseInt(idParam, 10);
      if (isNaN(id)) return res.status(400).json({ error: "ID inválido" });

      const validated = updateArticleSchema.parse(req.body);
      const atualizado = await ArticleModel.update(id, validated);
      return res.json({ message: "Artigo atualizado", artigo: atualizado });
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
      if (
        error instanceof Error &&
        error.message.startsWith("Categorias inválidas")
      ) {
        return res.status(400).json({ error: error.message });
      }
      console.error("Erro ao atualizar artigo:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async destroy(req: Request, res: Response) {
    try {
      const idParam = req.params.id;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });
      const id = parseInt(idParam, 10);
      if (isNaN(id)) return res.status(400).json({ error: "ID inválido" });

      await ArticleModel.delete(id);
      return res.json({ message: "Artigo removido" });
    } catch (error) {
      console.error("Erro ao remover artigo:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
}
