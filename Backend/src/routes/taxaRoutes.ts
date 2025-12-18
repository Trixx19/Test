import { Router, Request, Response, NextFunction } from "express";
import { z } from "zod";
import TaxaEspecialidadeController from "../controllers/TaxaEspecialidadeController";
import {
  createTaxaSchema,
  updateTaxaSchema,
  listTaxaSchema,
  idParamSchema,
} from "../validations/taxaValidation";
import { authMiddleware } from "../middleware/authMiddleware";
import { authorizeRoles } from "../middleware/roleMiddleware";

const router = Router();

const validate =
  (schema: z.ZodSchema, property: "body" | "query" | "params" = "body") =>
  (req: Request, res: Response, next: NextFunction) => {
    try {
      const validated = schema.parse(req[property]);
      // Avoid directly assigning to `req.query` or `req.params` because in some
      // environments these properties are defined with getters and cannot be
      // re-assigned. Instead, merge validated values into the existing object.
      if (property === "body") {
        req.body = validated as any;
      } else {
        const target: any = (req as any)[property] || {};
        Object.assign(target, validated as any);
      }
      next();
    } catch (error) {
      // Se for ZodError, formatamos os issues
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          message: "Erro de validação",
          errors: error.issues.map((issue) => ({
            campo: issue.path.join("."),
            mensagem: issue.message,
          })),
        });
      }

      // Para outros erros (ex.: valores inesperados na query como chaves vazias),
      // retornamos 400 com mensagem de validação e logamos para debug.
      console.error("Validation middleware error:", error);
      return res.status(400).json({
        message: "Erro de validação",
        details: String(error?.message || error),
      });
    }
  };

// Listar taxas (com paginação e filtro opcional por especialidade)
router.get(
  "/taxas",
  validate(listTaxaSchema, "query"),
  TaxaEspecialidadeController.list
);

// Buscar por id
router.get(
  "/taxas/:id",
  validate(idParamSchema, "params"),
  TaxaEspecialidadeController.show
);

// Criar (apenas ADMIN)
router.post(
  "/taxas",
  authMiddleware,
  authorizeRoles("ADMIN"),
  validate(createTaxaSchema, "body"),
  TaxaEspecialidadeController.create
);

// Atualizar (apenas ADMIN)
router.put(
  "/taxas/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  validate(idParamSchema, "params"),
  validate(updateTaxaSchema, "body"),
  TaxaEspecialidadeController.update
);

// Deletar (apenas ADMIN)
router.delete(
  "/taxas/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  validate(idParamSchema, "params"),
  TaxaEspecialidadeController.delete
);

export default router;
