import { Router } from "express";
import { medicoController } from "../controllers/medicoController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { authorizeRoles } from "../middleware/roleMiddleware.js";

const router = Router();

router.get("/medicos", medicoController.list);
router.get("/medicos/:id", medicoController.getById);

router.post(
  "/medicos",
  authMiddleware,
  authorizeRoles("ADMIN", "MEDICO"),
  medicoController.create
);

router.put(
  "/medicos/:id",
  authMiddleware,
  authorizeRoles("ADMIN", "MEDICO"),
  medicoController.update
);

router.delete(
  "/medicos/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  medicoController.delete
);

export default router;
