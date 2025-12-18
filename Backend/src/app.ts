import express, { Request, Response, NextFunction } from "express";
import cors from "cors";
import userRoutes from "./routes/userRoutes.js";
import authRoutes from "./routes/authRoutes.js";
import recuperarSenhaRoutes from "./routes/recuperarSenhaRoutes.js";
import categoryRoutes from "./routes/categoryRoutes.js";
import articleRoutes from "./routes/articleRoutes.js";
import medicoRoutes from "./routes/medicoRoutes.js";
import { especialistaRoutes } from "./routes/especialistaRoutes.js";
import taxaRoutes from "./routes/taxaRoutes.js";
import logError from "./utils/errorLogger.js";

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());
app.get("/api/ping", (req, res) => {
  res.json({ message: "PONG! O Backend está vivo! 🏓" });
});

// Log handled error responses (status >= 400) without changing response flow
app.use((req: Request, res: Response, next: NextFunction) => {
  const chunks: Buffer[] = [];
  const oldWrite = res.write.bind(res) as (
    chunk: any,
    ...args: any[]
  ) => boolean;
  const oldEnd = res.end.bind(res) as (chunk?: any, ...args: any[]) => void;

  (res as any).write = (chunk: any, ...args: any[]) => {
    try {
      if (chunk)
        chunks.push(
          Buffer.isBuffer(chunk) ? chunk : Buffer.from(String(chunk))
        );
    } catch (e) {
      // ignore
    }
    return oldWrite(chunk, ...args);
  };

  (res as any).end = (chunk?: any, ...args: any[]) => {
    try {
      if (chunk)
        chunks.push(
          Buffer.isBuffer(chunk) ? chunk : Buffer.from(String(chunk))
        );
      const status = res.statusCode || 200;
      if (status >= 400) {
        let body: any = null;
        try {
          const buf = Buffer.concat(chunks);
          const text = buf.toString("utf8");
          body = text ? JSON.parse(text) : text;
        } catch (e) {
          try {
            body = Buffer.concat(chunks).toString("utf8");
          } catch {}
        }
        try {
          logError(new Error("HTTP error response"), {
            status,
            route: req.originalUrl,
            method: req.method,
            body,
          });
        } catch (e) {
          // ignore
        }
      }
    } catch (e) {
      // ignore
    }
    return oldEnd(chunk, ...args);
  };

  next();
});

// Root health check
app.get("/", (_req, res) => {
  res.send("Hello, Imperio Noxus Backend!");
});

// Debug endpoint to force a test log entry (safe to remove later)
app.get("/__logtest", (_req, res) => {
  try {
    logError(new Error("logtest"), { via: "__logtest" });
  } catch (e) {
    console.error("logtest failed", e);
  }
  return res.json({ ok: true });
});

// Rotas
app.use("/api", userRoutes);
app.use("/api", authRoutes);
app.use("/api", recuperarSenhaRoutes);
app.use("/api", categoryRoutes);
app.use("/api", articleRoutes);
app.use("/api", medicoRoutes);
app.use("/api", especialistaRoutes);
app.use("/api", taxaRoutes);

// Error handler for invalid JSON body (body-parser SyntaxError)
app.use((err: any, _req: Request, res: Response, _next: NextFunction) => {
  if (err instanceof SyntaxError && "body" in err) {
    return res
      .status(400)
      .json({ error: "JSON inválido no corpo da requisição" });
  }
  try {
    logError(err, {
      route: (_req as any)?.originalUrl,
      method: (_req as any)?.method,
    });
  } catch (e) {
    // ignore logging failure
  }
  console.error(err);
  return res.status(500).json({ error: "Erro interno do servidor" });
});

export default app;
