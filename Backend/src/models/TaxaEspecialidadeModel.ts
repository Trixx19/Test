import prisma from "../lib/prisma";

export class TaxaEspecialidadeModel {
  static async create(data: { especialidade_id: number; taxa: number }) {
    return await prisma.taxaEspecialidade.create({ data });
  }

  static async findAll(opts: {
    page?: number | string;
    limit?: number | string;
    especialidade_id?: number | string;
  }) {
    const pageNum = opts.page ? Number(opts.page) : 1;
    const limitNum = opts.limit ? Number(opts.limit) : 10;
    const page =
      Number.isFinite(pageNum) && pageNum > 0 ? Math.floor(pageNum) : 1;
    const limit =
      Number.isFinite(limitNum) && limitNum > 0 ? Math.floor(limitNum) : 10;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (opts.especialidade_id)
      where.especialidade_id = Number(opts.especialidade_id);

    const [items, total] = await prisma.$transaction([
      prisma.taxaEspecialidade.findMany({
        where,
        skip,
        take: limit,
        orderBy: { criado_em: "desc" },
      }),
      prisma.taxaEspecialidade.count({ where }),
    ]);

    return {
      items,
      meta: {
        totalItems: total,
        totalPages: Math.ceil(total / limit),
        currentPage: page,
        pageSize: limit,
      },
    };
  }

  static async findById(id: number) {
    return await prisma.taxaEspecialidade.findUnique({ where: { id } });
  }

  static async update(id: number, data: { taxa?: number }) {
    return await prisma.taxaEspecialidade.update({ where: { id }, data });
  }

  static async delete(id: number) {
    return await prisma.taxaEspecialidade.delete({ where: { id } });
  }
}

export default TaxaEspecialidadeModel;
