import { Request, Response, NextFunction } from "express";

export const authorizeRoles = (...allowedRoles: string[]) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const user = (req as any).user;

    if (!user) {
      return res.status(401).json({ error: "Usuário não autenticado" });
    }

    const tipo = user.tipo_usuario as string | undefined;
    if (!tipo) {
      return res.status(403).json({ error: "Acesso negado" });
    }

    if (!allowedRoles.includes(tipo)) {
      return res
        .status(403)
        .json({ error: "Acesso negado - permissões insuficientes" });
    }

    return next();
  };
};
