import api from "../api/client";

export type LoginPayload = {
  email: string;
  senha: string;
};

export type LoginResponse = {
  message: string;
  usuario: any;
  token: string;
};

const login = async (payload: LoginPayload) => {
  const { data } = await api.post<LoginResponse>("/api/login", payload);
  return data;
};

export default { login };
