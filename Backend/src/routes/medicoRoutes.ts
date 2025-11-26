import { Router, Request, Response, NextFunction } from 'express'
import { medicoController } from '../controllers/medicoController.js'
import { 
  searchMedicoSchema, 
  createMedicoSchema, 
  updateMedicoSchema, 
  idParamSchema 
} from '../validations/medicoValidations.js'
import { z } from 'zod'

export const medicoRoutes = Router()

// Middleware genérico de validação (para body, query ou params)
const validate =
  (schema: z.ZodSchema, property: 'body' | 'query' | 'params' = 'body') =>
  (req: Request, res: Response, next: NextFunction) => {
    try {
      const validated = schema.parse(req[property])
      req[property] = validated
      next()
    } catch (error) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          message: 'Erro de validação',
          errors: error.issues.map(issue => ({
            campo: issue.path.join('.'),
            mensagem: issue.message,
          })),
        })
      }
      return res.status(500).json({ message: 'Erro interno ao validar dados' })
    }
  }

//
// ==================== ROTAS DE MÉDICO ====================
//

// 🔍 Busca avançada com filtros
medicoRoutes.get(
  '/medicos/search',
  validate(searchMedicoSchema, 'query'),
  medicoController.search
)

// ➕ Criar médico
medicoRoutes.post(
  '/medicos',
  validate(createMedicoSchema, 'body'),
  medicoController.create
)

// 📋 Listar todos os médicos (com paginação)
medicoRoutes.get(
  '/medicos',
  medicoController.list
)

// 🔎 Buscar médico por ID
medicoRoutes.get(
  '/medicos/:id',
  validate(idParamSchema, 'params'),
  medicoController.getById
)

// ✏️ Atualizar médico
medicoRoutes.put(
  '/medicos/:id',
  validate(idParamSchema, 'params'),
  validate(updateMedicoSchema, 'body'),
  medicoController.update
)

// 🗑️ Deletar médico
medicoRoutes.delete(
  '/medicos/:id',
  validate(idParamSchema, 'params'),
  medicoController.delete
)
