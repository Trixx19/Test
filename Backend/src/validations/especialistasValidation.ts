import { z } from 'zod'

export const searchEspecialistaSchema = z.object({
  nome: z.string().optional(),
  especialidade: z.string().optional(),
  categoria: z.string().optional(),

  avaliacao: z.coerce.number().min(1).max(5).optional(),

  page: z.coerce.number().min(1).default(1),
  limit: z.coerce.number().min(5).max(50).default(10),
})