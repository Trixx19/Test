import { Request, Response } from "express";
import { ZodError } from "zod";
import { CategoryModel } from "../models/CategoryModel.js";
import {
  createCategorySchema,
  updateCategorySchema,
} from "../validations/categoryValidation.js";

export class CategoryController {
  static async index(_req: Request, res: Response) {
    try {
      const categorias = await CategoryModel.findAll();
      return res.status(200).json({ categorias });
    } catch (error) {
      console.error("Erro ao listar categorias:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async show(req: Request, res: Response) {
    try {
      const idParam = req.params.id;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });

      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const categoria = await CategoryModel.findById(id);
      if (!categoria)
        return res.status(404).json({ error: "Categoria não encontrada" });

      return res.status(200).json({ categoria });
    } catch (error) {
      console.error("Erro ao buscar categoria:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async create(req: Request, res: Response) {
    try {
      if (!req.user || req.user.tipo_usuario !== "ADMIN") {
        return res.status(403).json({ error: "Acesso negado" });
      }

      const validated = createCategorySchema.parse(req.body);

      const existe = await CategoryModel.findByName(validated.nome_categoria);
      if (existe) {
        return res
          .status(409)
          .json({ error: "Nome de categoria já cadastrado" });
      }

      const nova = await CategoryModel.create({
        nome_categoria: validated.nome_categoria,
      });
      return res
        .status(201)
        .json({ message: "Categoria criada com sucesso", categoria: nova });
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

      console.error("Erro ao criar categoria:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async update(req: Request, res: Response) {
    try {
      if (!req.user || req.user.tipo_usuario !== "ADMIN") {
        return res.status(403).json({ error: "Acesso negado" });
      }

      const idParam = req.params.id;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });
      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const validatedData = updateCategorySchema.parse(req.body);
      const updateData: { nome_categoria?: string } = {};

      if (validatedData.nome_categoria !== undefined) {
        updateData.nome_categoria = validatedData.nome_categoria;
      }

      const categoriaExistente = await CategoryModel.findById(id);
      if (!categoriaExistente)
        return res.status(404).json({ error: "Categoria não encontrada" });

      if (updateData.nome_categoria) {
        const outra = await CategoryModel.findByName(updateData.nome_categoria);
        if (outra && outra.id_categoria !== id) {
          return res
            .status(409)
            .json({ error: "Nome de categoria já cadastrado" });
        }
      }

      const atualizada = await CategoryModel.update(id, updateData);
      return res
        .status(200)
        .json({ message: "Categoria atualizada", categoria: atualizada });
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

      console.error("Erro ao atualizar categoria:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async delete(req: Request, res: Response) {
    try {
      if (!req.user || req.user.tipo_usuario !== "ADMIN") {
        return res.status(403).json({ error: "Acesso negado" });
      }

      const idParam = req.params.id;
      if (!idParam) return res.status(400).json({ error: "ID inválido" });
      const id = parseInt(idParam, 10);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const categoriaExistente = await CategoryModel.findById(id);
      if (!categoriaExistente)
        return res.status(404).json({ error: "Categoria não encontrada" });

      await CategoryModel.delete(id);
      return res
        .status(200)
        .json({ message: "Categoria deletada com sucesso" });
    } catch (error) {
      console.error("Erro ao deletar categoria:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
}
