import { z } from "zod";

export const createTaxaSchema = z.object({
  especialidade_id: z
    .number({ invalid_type_error: "especialidade_id deve ser um número" })
    .int()
    .positive(),
  taxa: z
    .number({ invalid_type_error: "taxa deve ser um número" })
    .nonnegative("taxa deve ser maior ou igual a 0"),
});

export const updateTaxaSchema = z.object({
  taxa: z
    .number({ invalid_type_error: "taxa deve ser um número" })
    .nonnegative("taxa deve ser maior ou igual a 0")
    .optional(),
});

export const listTaxaSchema = z.object({
  page: z
    .string()
    .optional()
    .transform((val) => (val ? parseInt(val, 10) : 1)),
  limit: z
    .string()
    .optional()
    .transform((val) => (val ? parseInt(val, 10) : 10)),
  especialidade_id: z
    .string()
    .optional()
    .transform((val) => (val ? parseInt(val, 10) : undefined)),
});

export const idParamSchema = z.object({
  id: z
    .string()
    .refine((s) => /^\d+$/.test(s), { message: "ID inválido" })
    .transform((s) => parseInt(s, 10)),
});

export type CreateTaxaInput = z.infer<typeof createTaxaSchema>;
export type UpdateTaxaInput = z.infer<typeof updateTaxaSchema>;
