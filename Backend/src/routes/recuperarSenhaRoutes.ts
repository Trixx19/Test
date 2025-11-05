import { Router } from "express";
import { RecuperarSenhaController } from "../controllers/RecuperarSenhaController.js";

const router = Router();

router.post("/recuperar-senha", RecuperarSenhaController.solicitarRecuperacao);

router.post("/redefinir-senha", RecuperarSenhaController.redefinirSenha);

export default router;