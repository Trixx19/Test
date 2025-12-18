import { PrismaClient } from "@prisma/client";
import { TipoUsuario } from "@prisma/client";

const prisma = new PrismaClient();

type SearchFilters = {
  nome?: string;
  especialidade?: string;
  categoria?: string;
  avaliacao?: number;
  page: number;
  limit: number;
};

export class EspecialistaModel {
  
  static async search(filters: SearchFilters) {
    const { nome, especialidade, categoria, avaliacao, page, limit } = filters;

    const skip = (page - 1) * limit;
    const take = limit;

    const whereClause: any = {
      tipo_usuario: TipoUsuario.ESPECIALISTA,
    };

    if (nome) {
      whereClause.nome = { contains: nome, mode: "insensitive" };
    }

    if (especialidade) {
      whereClause.especialidades = {
        some: {
          nome: { contains: especialidade, mode: "insensitive" },
        },
      };
    }

    if (categoria) {
      whereClause.artigos = {
        some: {
          categorias: {
            some: {
              categoria: {
                nome_categoria: { contains: categoria, mode: "insensitive" },
              },
            },
          },
        },
      };
    }

    if (avaliacao !== undefined) {
      whereClause.avaliacoes_recebidas = {
        some: { nota: avaliacao },
      };
    }

    const [especialistas, total] = await prisma.$transaction([
      prisma.usuario.findMany({
        where: whereClause,
        select: {
          id_usuario: true,
          nome: true,
          email: true,
          especialidades: {
            select: { nome: true, orgao_resp: true },
          },
        },
        skip,
        take,
        orderBy: { nome: "asc" },
      }),

      prisma.usuario.count({ where: whereClause }),
    ]);

    return {
      especialistas,
      meta: {
        totalItems: total,
        totalPages: Math.ceil(total / limit),
        currentPage: page,
        pageSize: limit,
      },
    };
  }

  static async findById(id: number) {
    return prisma.usuario.findFirst({
      where: {
        id_usuario: id,
        tipo_usuario: TipoUsuario.ESPECIALISTA,
      },
      include: {
        especialidades: true,
        avaliacoes_recebidas: {
          select: { nota: true, comentario: true },
        },
      },
    });
  }

  static async delete(id: number) {
    return prisma.usuario.delete({
      where: { id_usuario: id },
    });
  }
}