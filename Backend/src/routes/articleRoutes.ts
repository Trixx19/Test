import { Router } from "express";
import { ArticleController } from "../controllers/ArticleController.js";
import { authMiddleware } from "../middleware/authMiddleware.js";
import { authorizeRoles } from "../middleware/roleMiddleware.js";

const router = Router();

router.get("/articles", ArticleController.index);
router.get("/articles/:id", ArticleController.show);
// Protegidas: criar/atualizar/remover
router.post(
  "/articles",
  authMiddleware,
  authorizeRoles("ADMIN", "MEDICO"),
  ArticleController.store
);

router.put(
  "/articles/:id",
  authMiddleware,
  authorizeRoles("ADMIN", "MEDICO"),
  ArticleController.update
);

// Deleção pode ficar apenas para ADMIN (ajuste se necessário)
router.delete(
  "/articles/:id",
  authMiddleware,
  authorizeRoles("ADMIN"),
  ArticleController.destroy
);

export default router;
