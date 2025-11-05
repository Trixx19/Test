import express from 'express';
import cors from "cors";
import userRoutes from "./routes/userRoutes.js";
import authRoutes from "./routes/authRoutes.js";
import recuperarSenhaRoutes from "./routes/recuperarSenhaRoutes.js";

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Rotas
app.use("/api", userRoutes);
app.use(authRoutes);
app.use("/api", recuperarSenhaRoutes);

export default app;