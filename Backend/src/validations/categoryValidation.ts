import { z } from "zod";

export const createCategorySchema = z.object({
  nome_categoria: z
    .string()
    .min(3, "Nome da categoria deve ter no mínimo 3 caracteres"),
});

export const updateCategorySchema = createCategorySchema.partial();

export type CreateCategoryInput = z.infer<typeof createCategorySchema>;
