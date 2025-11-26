import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import { jwtConfig } from "../config/jwt.config.js";

interface TokenPayload {
  id: number;
  tipo_usuario: string;
  iat?: number;
  exp?: number;
}

declare global {
  namespace Express {
    interface Request {
      user?: TokenPayload;
    }
  }
}

export const authMiddleware = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({
      error: "Token não fornecido",
    });
  }

  const parts = authHeader.split(" ");

  if (parts.length !== 2 || !parts[1]) {
    return res.status(401).json({
      error: "Token mal formatado",
    });
  }

  const [scheme, token] = parts;

  if (!token || scheme !== "Bearer") {
    return res.status(401).json({
      error: "Token mal formatado",
    });
  }

  try {
    const decoded = jwt.verify(
      token,
      String(jwtConfig.secret)
    ) as unknown as Record<string, any>;

    if (
      decoded &&
      typeof decoded === "object" &&
      "id" in decoded &&
      typeof decoded.id === "number" &&
      "tipo_usuario" in decoded &&
      typeof decoded.tipo_usuario === "string"
    ) {
      req.user = {
        id: decoded.id,
        tipo_usuario: decoded.tipo_usuario,
      };
      return next();
    }

    throw new Error("Token payload inválido");
  } catch (error) {
    return res.status(401).json({
      error: "Token inválido",
    });
  }
};
