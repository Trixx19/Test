import { z } from "zod";

export const createUserSchema = z.object({
  nome: z.string().min(3, "Nome deve ter no mínimo 3 caracteres"),
  email: z.string().email("Email inválido"),
  senha: z.string().min(6, "Senha deve ter no mínimo 6 caracteres"),

  tipo_usuario: z.preprocess(
    (val) => {
      if (typeof val !== "string") return val;
      const v = val
        .normalize("NFKD")
        .replace(/\p{Diacritic}/gu, "")
        .toUpperCase();
      if (v === "USUARIO" || v === "PACIENTE") return "PACIENTE";
      if (v === "ADMINISTRADOR" || v === "ADMIN") return "ADMIN";
      if (v.startsWith("MED")) return "MEDICO";
      return v;
    },
    z.enum(["ADMIN", "MEDICO", "PACIENTE"], {
      errorMap: () => ({ message: "Tipo de usuário inválido" }),
    })
  ),
  medico: z
    .object({
      especialidade: z
        .string()
        .min(3, "Especialidade deve ter no mínimo 3 caracteres"),
      telefone: z.string().min(10, "Telefone inválido"),
      crm: z.string().min(4, "CRM deve ter no mínimo 4 caracteres"),
    })
    .optional(),
});

export type CreateUserInput = z.infer<typeof createUserSchema>;
