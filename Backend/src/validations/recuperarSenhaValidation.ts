import { z } from "zod";

export const solicitarRecuperacaoSchema = z.object({
  email: z.string().email("Email inválido"),
});