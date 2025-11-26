import express from "express";
import cors from "cors";
import userRoutes from "./routes/userRoutes.js";
import authRoutes from "./routes/authRoutes.js";
import recuperarSenhaRoutes from "./routes/recuperarSenhaRoutes.js";
import categoryRoutes from "./routes/categoryRoutes.js";
import articleRoutes from "./routes/articleRoutes.js";
import { medicoRoutes } from "./routes/medicoRoutes.js";

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Root health check
app.get("/", (_req, res) => {
  res.send("Hello, Imperio Noxus Backend!");
});

// Rotas
app.use("/api", userRoutes);
app.use("/api", authRoutes);
app.use("/api", recuperarSenhaRoutes);
app.use("/api", categoryRoutes);
app.use("/api", articleRoutes);
app.use("/api", medicoRoutes);

export default app;
