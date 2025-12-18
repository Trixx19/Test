import { Router, Request, Response, NextFunction } from "express";
import { EspecialistaController } from "../controllers/EspecialistaController.js";
import { searchEspecialistaSchema } from "../validations/especialistasValidation";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { authorizeRoles } from "../middleware/roleMiddleware.js";
import { z } from "zod";

export const especialistaRoutes = Router();

const validateQuery =
  (schema: z.ZodSchema) =>
  (req: Request, res: Response, next: NextFunction) => {
    try {
      req.query = schema.parse(req.query) as any;
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          message: "Filtros inválidos",
          errors: error.issues.map((issue) => ({
            campo: issue.path.join("."),
            mensagem: issue.message,
          })),
        });
      }
      next(error);
    }
  };

especialistaRoutes.get(
  "/especialistas/search",
  validateQuery(searchEspecialistaSchema),
  EspecialistaController.search
);

especialistaRoutes.get("/especialistas/:id", EspecialistaController.show);

especialistaRoutes.delete(
  "/especialistas/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  EspecialistaController.delete
);
