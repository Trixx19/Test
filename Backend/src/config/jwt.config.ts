import { Secret } from "jsonwebtoken";

export const jwtConfig = {
  secret: (process.env.JWT_SECRET ||
    "sua-chave-secreta-muito-segura") as Secret,
  expiresIn: "1d" as const,
};
