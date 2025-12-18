import { Request, Response } from "express";
import { ZodError } from "zod";
import prisma from "../lib/prisma";
import TaxaEspecialidadeModel from "../models/TaxaEspecialidadeModel";

export class TaxaEspecialidadeController {
  static async list(req: Request, res: Response) {
    try {
      const { page, limit, especialidade_id } = req.query as any;

      const result = await TaxaEspecialidadeModel.findAll({
        page,
        limit,
        especialidade_id,
      });

      return res.status(200).json(result);
    } catch (error) {
      console.error("Erro ao listar taxas:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async show(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const taxa = await TaxaEspecialidadeModel.findById(id);
      if (!taxa) return res.status(404).json({ error: "Taxa não encontrada" });

      return res.status(200).json({ data: taxa });
    } catch (error) {
      console.error("Erro ao buscar taxa:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async create(req: Request, res: Response) {
    try {
      const { especialidade_id, taxa } = req.body as {
        especialidade_id: number;
        taxa: number;
      };

      const existe = await prisma.especialidade.findUnique({
        where: { id_especialidade: especialidade_id },
      });
      if (!existe)
        return res.status(404).json({ error: "Especialidade não encontrada" });

      try {
        const created = await TaxaEspecialidadeModel.create({
          especialidade_id,
          taxa,
        });
        return res.status(201).json({ data: created });
      } catch (e: any) {
        if (e && e.code === "P2002") {
          return res
            .status(409)
            .json({ error: "Já existe uma taxa para essa especialidade" });
        }
        throw e;
      }
    } catch (error) {
      if (error instanceof ZodError) {
        return res
          .status(400)
          .json({ error: "Dados inválidos", details: error.issues });
      }
      console.error("Erro ao criar taxa:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async update(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const exists = await TaxaEspecialidadeModel.findById(id);
      if (!exists)
        return res.status(404).json({ error: "Taxa não encontrada" });

      const { taxa } = req.body as { taxa?: number };

      const updated = await TaxaEspecialidadeModel.update(id, { taxa });
      return res.status(200).json({ data: updated });
    } catch (error) {
      console.error("Erro ao atualizar taxa:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }

  static async delete(req: Request, res: Response) {
    try {
      const id = Number(req.params.id);
      if (isNaN(id) || id <= 0)
        return res.status(400).json({ error: "ID inválido" });

      const exists = await TaxaEspecialidadeModel.findById(id);
      if (!exists)
        return res.status(404).json({ error: "Taxa não encontrada" });

      await TaxaEspecialidadeModel.delete(id);
      return res.status(200).json({ message: "Taxa removida com sucesso" });
    } catch (error) {
      console.error("Erro ao deletar taxa:", error);
      return res.status(500).json({ error: "Erro interno do servidor" });
    }
  }
}

export default TaxaEspecialidadeController;
