import { Router } from "express";
import { UserController } from "../controllers/UserController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.post("/usuarios", UserController.create);
router.get("/usuarios/:id", UserController.FindById);
router.put("/usuarios/:id", authMiddleware, UserController.update);
router.delete("/usuarios/:id", authMiddleware, UserController.delete);
router.get("/usuarios", UserController.FindByEmail);

export default router;
