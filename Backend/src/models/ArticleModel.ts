import { PrismaClient } from "@prisma/client";
import { generateUniqueSlug } from "../../utils/slugify";

const prisma = new PrismaClient();

export class ArticleModel {
  static async checkSlugExists(slug: string): Promise<boolean> {
    const artigo = await prisma.artigo.findUnique({
      where: { slug },
      select: { id_artigo: true },
    });
    return !!artigo;
  }

  static removeSensitiveData(data: any): any {
    if (Array.isArray(data)) {
      return data.map((item) => this.removeSensitiveData(item));
    }

    if (data && typeof data === "object") {
      const cleaned = { ...data };
      if (cleaned.autor && cleaned.autor.senha_hash) {
        const { senha_hash, ...autorSemSenha } = cleaned.autor;
        cleaned.autor = autorSemSenha;
      }
      if (cleaned.comentarios) {
        cleaned.comentarios = cleaned.comentarios.map((c: any) => {
          if (c.usuario && c.usuario.senha_hash) {
            const { senha_hash, ...usuarioSemSenha } = c.usuario;
            return { ...c, usuario: usuarioSemSenha };
          }
          return c;
        });
      }
      return cleaned;
    }

    return data;
  }

  static async findAll() {
    const artigos = await prisma.artigo.findMany({
      include: {
        autor: true,
        comentarios: {
          include: {
            usuario: true,
          },
        },
        categorias: {
          include: { categoria: true },
        },
        visualizacoes: true,
      },
      orderBy: { criado_em: "desc" },
    });

    return this.removeSensitiveData(artigos);
  }

  static async findById(id: number) {
    const artigo = await prisma.artigo.findUnique({
      where: { id_artigo: id },
      include: {
        autor: true,
        comentarios: {
          include: {
            usuario: true,
          },
        },
        categorias: { include: { categoria: true } },
        visualizacoes: true,
      },
    });

    return artigo ? this.removeSensitiveData(artigo) : null;
  }

  static async create(data: any) {
    const {
      titulo,
      conteudo,
      slug: providedSlug,
      autor_id,
      status,
      categorias,
    } = data;

    const slug =
      providedSlug || (await generateUniqueSlug(titulo, this.checkSlugExists));

    const artigo = await prisma.artigo.create({
      data: {
        titulo,
        conteudo,
        slug,
        autor_id,
        status,
      },
    });

    if (categorias && Array.isArray(categorias) && categorias.length > 0) {
      const existentes = await prisma.categoria.findMany({
        where: { id_categoria: { in: categorias } },
        select: { id_categoria: true },
      });

      const existentesIds = existentes.map((c) => c.id_categoria);
      const invalid = categorias.filter(
        (id: number) => !existentesIds.includes(id)
      );
      if (invalid.length > 0) {
        await prisma.artigo.delete({ where: { id_artigo: artigo.id_artigo } });
        throw new Error(`Categorias inválidas: ${invalid.join(", ")}`);
      }

      const createManyData = categorias.map((categoriaId: number) => ({
        artigo_id: artigo.id_artigo,
        categoria_id: categoriaId,
      }));

      await prisma.categoriasOnArtigos.createMany({ data: createManyData });
    }

    const artigoCompleto = await this.findById(artigo.id_artigo);
    return this.removeSensitiveData(artigoCompleto);
  }

  static async update(id: number, data: any) {
    const { titulo, conteudo, slug, status, categorias } = data;

    await prisma.artigo.update({
      where: { id_artigo: id },
      data: {
        ...(titulo && { titulo }),
        ...(conteudo && { conteudo }),
        ...(slug && { slug }),
        ...(status && { status }),
      },
    });

    if (categorias) {
      if (Array.isArray(categorias) && categorias.length > 0) {
        const existentes = await prisma.categoria.findMany({
          where: { id_categoria: { in: categorias } },
          select: { id_categoria: true },
        });
        const existentesIds = existentes.map((c) => c.id_categoria);
        const invalid = categorias.filter(
          (id: number) => !existentesIds.includes(id)
        );
        if (invalid.length > 0) {
          throw new Error(`Categorias inválidas: ${invalid.join(", ")}`);
        }
      }

      await prisma.categoriasOnArtigos.deleteMany({
        where: { artigo_id: id },
      });

      if (Array.isArray(categorias) && categorias.length > 0) {
        const createManyData = categorias.map((categoriaId: number) => ({
          artigo_id: id,
          categoria_id: categoriaId,
        }));

        await prisma.categoriasOnArtigos.createMany({ data: createManyData });
      }
    }

    const artigoAtualizado = await this.findById(id);
    return this.removeSensitiveData(artigoAtualizado);
  }

  static async delete(id: number) {
    await prisma.artigo.delete({ where: { id_artigo: id } });
  }
}
