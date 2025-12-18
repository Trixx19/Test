import { z } from "zod";

// 🔍 Busca de médicos
export const searchMedicoSchema = z.object({
  categoria: z.string().optional(),
  especialidade: z.string().optional(),
  nome: z.string().optional(),
  avaliacao: z.coerce.number().min(1).max(5).optional(), // 'coerce' transforma string em número
  page: z.coerce.number().min(1).default(1),
  limit: z.coerce.number().min(5).max(50).default(10),
});

// ➕ Criação de médico
export const createMedicoSchema = z.object({
  usuario_id: z.number({
    required_error: "O ID do usuário é obrigatório",
    invalid_type_error: "usuario_id deve ser um número",
  }),
  especialidade: z
    .string()
    .min(2, "Especialidade deve ter pelo menos 2 caracteres"),
  telefone: z
    .string()
    .min(8, "Telefone deve ter pelo menos 8 dígitos")
    .regex(/^[0-9()+\-\s]+$/, "Telefone contém caracteres inválidos"),
  crm: z.string().min(4, "CRM deve ter pelo menos 4 caracteres"),
  foto_url: z.string().url("URL da foto inválida").optional(),
  biografia: z.string().max(1000, "Biografia muito longa").optional(),
});

// ✏️ Atualização de médico
export const updateMedicoSchema = z.object({
  especialidade: z
    .string()
    .min(2, "Especialidade deve ter pelo menos 2 caracteres")
    .optional(),
  telefone: z
    .string()
    .min(8, "Telefone deve ter pelo menos 8 dígitos")
    .regex(/^[0-9()+\-\s]+$/, "Telefone contém caracteres inválidos")
    .optional(),
  crm: z.string().min(4, "CRM deve ter pelo menos 4 caracteres").optional(),
  foto_url: z.string().url("URL da foto inválida").optional(),
  biografia: z.string().max(1000, "Biografia muito longa").optional(),
});

// 🔎 ID param (usado em GET, PUT, DELETE)
export const idParamSchema = z.object({
  id: z.coerce.number().int().positive("O ID precisa ser um número positivo"),
});
