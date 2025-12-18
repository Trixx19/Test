import { Router } from "express";
import { UserController } from "../controllers/UserController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.post("/usuarios", UserController.create);
// Proteger acesso ao perfil do usuário
router.get("/usuarios/:id", authMiddleware, UserController.FindById);
router.put("/usuarios/:id", authMiddleware, UserController.update);
router.delete("/usuarios/:id", authMiddleware, UserController.delete);
router.get("/usuarios/busca/:email", UserController.FindByEmail);

export default router;
