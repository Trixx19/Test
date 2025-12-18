import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export const medicoController = {
  create: async (req: Request, res: Response) => {
    try {
      const { usuario_id, especialidade, telefone, crm, foto_url, biografia } = req.body;

      // Verifica se o usuário existe e é do tipo médico
      const usuario = await prisma.usuario.findUnique({
        where: { id_usuario: usuario_id },
      });

      if (!usuario) {
        return res.status(404).json({ message: 'Usuário não encontrado' });
      }

      if (usuario.tipo_usuario !== 'MEDICO') {
        return res.status(400).json({ message: 'Usuário não é do tipo médico' });
      }

      const novoMedico = await prisma.medico.create({
        data: {
          usuario_id,
          especialidade,
          telefone,
          crm,
          foto_url,
          biografia,
        },
      });

      return res.status(201).json(novoMedico);
    } catch (error: any) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao criar médico', error: error.message });
    }
  },

  //Listar todos
  list: async (req: Request, res: Response) => {
    try {
      const page = Number(req.query.page) || 1;
      const limit = Number(req.query.limit) || 10;
      const skip = (page - 1) * limit;

      const [medicos, total] = await prisma.$transaction([
        prisma.medico.findMany({
          include: {
            usuario: { select: { nome: true, email: true } },
            idiomas: true,
            formacoes: true,
            certificacoes: true,
            hospitais: true,
            contatos: true,
          },
          skip,
          take: limit,
        }),
        prisma.medico.count(),
      ]);

      return res.status(200).json({
        data: medicos,
        meta: {
          totalItems: total,
          totalPages: Math.ceil(total / limit),
          currentPage: page,
          pageSize: limit,
        },
      });
    } catch (error: any) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao listar médicos', error: error.message });
    }
  },

  //Buscar por ID
  getById: async (req: Request, res: Response) => {
    try {
      const { id } = req.params;

      const medico = await prisma.medico.findUnique({
        where: { id_medico: Number(id) },
        include: {
          usuario: { select: { nome: true, email: true } },
          idiomas: true,
          formacoes: true,
          certificacoes: true,
          hospitais: true,
          contatos: true,
        },
      });

      if (!medico) {
        return res.status(404).json({ message: 'Médico não encontrado' });
      }

      return res.status(200).json(medico);
    } catch (error: any) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao buscar médico', error: error.message });
    }
  },

  //Atualizar médico
  update: async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const data = req.body;

      const medico = await prisma.medico.findUnique({
        where: { id_medico: Number(id) },
      });

      if (!medico) {
        return res.status(404).json({ message: 'Médico não encontrado' });
      }

      const medicoAtualizado = await prisma.medico.update({
        where: { id_medico: Number(id) },
        data,
      });

      return res.status(200).json(medicoAtualizado);
    } catch (error: any) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao atualizar médico', error: error.message });
    }
  },

  //Deletar médico
  delete: async (req: Request, res: Response) => {
    try {
      const { id } = req.params;

      const medico = await prisma.medico.findUnique({
        where: { id_medico: Number(id) },
      });

      if (!medico) {
        return res.status(404).json({ message: 'Médico não encontrado' });
      }

      await prisma.medico.delete({
        where: { id_medico: Number(id) },
      });

      return res.status(200).json({ message: 'Médico deletado com sucesso' });
    } catch (error: any) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao deletar médico', error: error.message });
    }
  },

  //Busca avançada
  search: async (req: Request, res: Response) => {
    try {
      const { categoria, especialidade, nome, avaliacao, page = 1, limit = 10 } = req.query as any;

      const skip = (Number(page) - 1) * Number(limit);
      const take = Number(limit);

      const whereClause: any = {};

      if (especialidade) {
        whereClause.especialidade = { contains: especialidade, mode: 'insensitive' };
      }
      if (nome) {
        whereClause.usuario = { nome: { contains: nome, mode: 'insensitive' } };
      }
      if (categoria) {
        whereClause.usuario = {
          ...whereClause.usuario,
          artigos: {
            some: {
              categorias: {
                some: { categoria: { nome_categoria: { contains: categoria, mode: 'insensitive' } } },
              },
            },
          },
        };
      }
      if (avaliacao) {
        whereClause.avaliacao_media = { gte: Number(avaliacao) };
      }

      const [medicos, total] = await prisma.$transaction([
        prisma.medico.findMany({
          where: whereClause,
          include: {
            usuario: { select: { nome: true, email: true } },
          },
          skip,
          take,
        }),
        prisma.medico.count({ where: whereClause }),
      ]);

      return res.status(200).json({
        data: medicos,
        meta: {
          totalItems: total,
          totalPages: Math.ceil(total / Number(limit)),
          currentPage: Number(page),
          pageSize: Number(limit),
        },
      });
    } catch (error: any) {
      console.error(error);
      return res.status(500).json({ message: 'Erro ao buscar médicos', error: error.message });
    }
  },
};
