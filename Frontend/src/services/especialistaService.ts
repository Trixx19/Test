import api from "../api/client";

export type SearchEspecialistaFilters = {
  nome?: string;
  especialidade?: string;
  categoria?: string;
  avaliacao?: number;
  page?: number;
  limit?: number;
};

export type EspecialistaSummary = {
  id_usuario: number;
  nome: string;
  email?: string;
  especialidades?: Array<{ nome: string; orgao_resp?: string }>;
};

export type Meta = {
  totalItems: number;
  totalPages: number;
  currentPage: number;
  pageSize: number;
};

export type SearchResult = {
  especialistas: EspecialistaSummary[];
  meta: Meta;
};

export type EspecialistaDetail = any;

const defaultSearchParams = { page: 1, limit: 10 };

const search = async (filters: SearchEspecialistaFilters = {}) => {
  const params = { ...defaultSearchParams, ...filters } as any;
  const { data } = await api.get<SearchResult>("/api/especialistas/search", {
    params,
  });
  return data;
};

const getById = async (id: number) => {
  const { data } = await api.get<{ data: EspecialistaDetail }>(
    `/api/especialistas/${id}`
  );
  return data.data;
};

const remove = async (id: number) => {
  const { data } = await api.delete<{ message: string }>(
    `/api/especialistas/${id}`
  );
  return data;
};

export default { search, getById, remove };
