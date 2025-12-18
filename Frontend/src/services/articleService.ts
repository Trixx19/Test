import api from "../api/client";

export type Article = {
  id_artigo?: number;
  titulo: string;
  conteudo: string;
  slug?: string;
  autor?: any;
  categorias?: any[];
  status?: string;
  criado_em?: string;
};

export type CreateArticlePayload = {
  titulo: string;
  conteudo: string;
  slug?: string;
  autor_id?: number;
  status?: string;
  categorias?: number[];
};

export type UpdateArticlePayload = Partial<CreateArticlePayload>;

const getAll = async () => {
  const { data } = await api.get<{ artigos: Article[] }>("/api/articles");
  return data.artigos;
};

const getById = async (id: number) => {
  const { data } = await api.get<{ artigo: Article }>(`/api/articles/${id}`);
  return data.artigo;
};

const create = async (payload: CreateArticlePayload) => {
  const { data } = await api.post<{ message: string; artigo: Article }>(
    "/api/articles",
    payload
  );
  return data;
};

const update = async (id: number, payload: UpdateArticlePayload) => {
  const { data } = await api.put<{ message: string; artigo: Article }>(
    `/api/articles/${id}`,
    payload
  );
  return data;
};

const remove = async (id: number) => {
  const { data } = await api.delete<{ message: string }>(`/api/articles/${id}`);
  return data;
};

export default { getAll, getById, create, update, remove };
