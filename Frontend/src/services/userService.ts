import api from "../api/client";

export interface MedicoData {
  especialidade: string;
  telefone: string;
  crm: string;
}

export interface CreateUserDTO {
  nome: string;
  email: string;
  senha: string;
  tipo_usuario: "PACIENTE" | "ESPECIALISTA" | "ADMIN"; 
  medico?: MedicoData;
}

export const UserService = {
  create: async (userData: CreateUserDTO) => {
    try {
      const response = await api.post("/usuarios", userData);
      return response.data;
    } catch (error: any) {
      throw error.response ? error.response.data : new Error("Erro de conexão");
    }
  },

  getById: async (id: number) => {
    try {
      const response = await api.get(`/usuarios/${id}`);
      return response.data;
    } catch (error: any) {
      throw error.response ? error.response.data : new Error("Erro ao buscar usuário");
    }
  },

  update: async (id: number, userData: Partial<CreateUserDTO>) => {
    try {
      const response = await api.put(`/usuarios/${id}`, userData);
      return response.data;
    } catch (error: any) {
      throw error.response ? error.response.data : new Error("Erro ao atualizar");
    }
  },

  delete: async (id: number) => {
    try {
      const response = await api.delete(`/usuarios/${id}`);
      return response.data;
    } catch (error: any) {
      throw error.response ? error.response.data : new Error("Erro ao deletar");
    }
  }
};