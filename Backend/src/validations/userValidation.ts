import { z } from "zod";

export const createUserSchema = z
  .object({
    nome: z.string().min(3, "Nome deve ter no mínimo 3 caracteres"),
    email: z.string().email("Email inválido"),
    senha: z.string().min(6, "Senha deve ter no mínimo 6 caracteres"),
    tipo_usuario: z
      .preprocess((val) => {
        if (typeof val !== "string") return val;
        const v = val.normalize("NFKD").replace(/\p{Diacritic}/gu, "").toUpperCase();
        if (v === "USUARIO" || v === "PACIENTE") return "PACIENTE";
        if (v === "ADMINISTRADOR" || v === "ADMIN") return "ADMIN";
        if (v.startsWith("ESP") || v.startsWith("MED")) return "ESPECIALISTA";
        return v;
      }, z.enum(["ADMIN", "ESPECIALISTA", "PACIENTE"]))
      .refine((v) => ["ADMIN", "ESPECIALISTA", "PACIENTE"].includes(v), {
        message: "Tipo de usuário inválido",
      }),
    crm: z.string().regex(/^\d{4,7}$/, "CRM inválido").optional(),
    uf_crm: z.string().length(2, "UF inválida").optional(),
    medico: z
      .object({
        especialidade: z.string().min(2).optional(),
        telefone: z.string().min(8).optional(),
        crm: z.string().regex(/^\d{4,7}$/).optional(),
        uf_crm: z.string().length(2).optional(),
        foto_url: z.string().url().optional(),
        biografia: z.string().max(1000).optional(),
      })
      .optional(),
    status: z.enum(["pendente", "ativo", "rejeitado"]).default("pendente"),
  })
  .refine(
    (data) => {
      if (data.tipo_usuario === "ESPECIALISTA") {
        const crm = data.crm ?? data.medico?.crm;
        const especialidade = data.medico?.especialidade;
        const telefone = data.medico?.telefone;
        return !!crm && !!especialidade && !!telefone;
      }
      return true;
    },
    {
      message: "Especialistas precisam de CRM, Especialidade e Telefone",
      path: ["medico"],
    }
  );

export type CreateUserInput = z.infer<typeof createUserSchema>;