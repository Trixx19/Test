import { Router } from "express";
import { CategoryController } from "../controllers/CategoryController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";

const router = Router();

router.get("/categorias", CategoryController.index);
router.get("/categorias/:id", CategoryController.show);
router.post("/categorias", authMiddleware, CategoryController.create);
router.put("/categorias/:id", authMiddleware, CategoryController.update);
router.delete("/categorias/:id", authMiddleware, CategoryController.delete);

export default router;
