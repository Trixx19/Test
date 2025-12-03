import { z } from "zod";

export const createArticleSchema = z.object({
  titulo: z.string().min(3, "Título deve ter no mínimo 3 caracteres"),
  conteudo: z.string().min(10, "Conteúdo muito curto"),
  slug: z.string().min(3, "Slug deve ter no mínimo 3 caracteres").optional(),
  autor_id: z.number().int().positive(),
  status: z.enum(["RASCUNHO", "PENDENTE_APROVACAO", "PUBLICADO"]).optional(),
  categorias: z.array(z.number().int().positive()).optional(),
});

export const updateArticleSchema = z.object({
  titulo: z
    .string()
    .min(3, "Título deve ter no mínimo 3 caracteres")
    .optional(),
  conteudo: z.string().min(10, "Conteúdo muito curto").optional(),
  slug: z.string().min(3, "Slug deve ter no mínimo 3 caracteres").optional(),
  status: z.enum(["RASCUNHO", "PENDENTE_APROVACAO", "PUBLICADO"]).optional(),
  categorias: z.array(z.number().int().positive()).optional(),
});

export type CreateArticleInput = z.infer<typeof createArticleSchema>;
export type UpdateArticleInput = z.infer<typeof updateArticleSchema>;
