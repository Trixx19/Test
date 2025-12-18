import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export class CategoryModel {
  static async findAll() {
    return await prisma.categoria.findMany({ orderBy: { nome_categoria: "asc" } });
  }

  static async findById(id: number) {
    return await prisma.categoria.findUnique({ where: { id_categoria: id } });
  }

  static async findByName(nome_categoria: string) {
    return await prisma.categoria.findUnique({ where: { nome_categoria } });
  }

  static async create(data: { nome_categoria: string }) {
    return await prisma.categoria.create({ data });
  }

  static async update(id: number, data: { nome_categoria?: string }) {
    return await prisma.categoria.update({ where: { id_categoria: id }, data });
  }

  static async delete(id: number) {
    return await prisma.categoria.delete({ where: { id_categoria: id } });
  }
}
