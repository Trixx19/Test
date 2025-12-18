import { Router } from "express";
import { CategoryController } from "../controllers/CategoryController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { authorizeRoles } from "../middleware/roleMiddleware.js";

const router = Router();

router.get("/categorias", CategoryController.index);
router.get("/categorias/:id", CategoryController.show);
router.post(
  "/categorias",
  authMiddleware,
  authorizeRoles("ADMIN"),
  CategoryController.create
);
router.put(
  "/categorias/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  CategoryController.update
);
router.delete(
  "/categorias/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  CategoryController.delete
);

export default router;
