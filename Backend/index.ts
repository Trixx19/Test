import express from "express";
import cors from "cors";
import * as dotenv from "dotenv";
import userRoutes from "./src/routes/userRoutes.js";
import authRoutes from "./src/routes/authRoutes.js";
import recuperarSenhaRoutes from "./src/routes/recuperarSenhaRoutes.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());

// Rotas
app.get("/", (_req, res) => {
  res.send("Hello, Imperio Noxus Backend!");
});

app.use("/api", userRoutes);
app.use(authRoutes);
app.use("/api", recuperarSenhaRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});