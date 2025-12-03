import { Router } from "express";
import { RecuperarSenhaController } from "../controllers/RecuperarSenhaController.js";

const router = Router();

router.get("/recuperar-senha", RecuperarSenhaController.solicitarRecuperacao);
router.get("/validar-token", RecuperarSenhaController.validarToken);
router.post("/redefinir-senha", RecuperarSenhaController.redefinirSenha); 

export default router;
