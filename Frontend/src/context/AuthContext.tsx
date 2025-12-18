import { createContext, useContext, useState, useEffect, type ReactNode } from "react";
import api from "../api/client";

interface User {
  id: number;
  nome: string;
  email: string;
  tipo_usuario: "ADMIN" | "MEDICO" | "PACIENTE";
}

interface AuthContextData {
  user: User | null;
  isAuthenticated: boolean;
  login: (email: string, senha: string) => Promise<void>;
  logout: () => void;
  loading: boolean;
}

const AuthContext = createContext<AuthContextData>({} as AuthContextData);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const storagedUser = localStorage.getItem("@SuperBrasil:user");
    const storagedToken = localStorage.getItem("access_token");

    if (storagedToken && storagedUser) {
      api.defaults.headers.Authorization = `Bearer ${storagedToken}`;
      setUser(JSON.parse(storagedUser));
    }
    setLoading(false);
  }, []);

  async function login(email: string, senha: string) {
    
    const response = await api.post("/api/login", { email, senha });

    const { token, usuario } = response.data;

    localStorage.setItem("@SuperBrasil:user", JSON.stringify(usuario));
    localStorage.setItem("access_token", token);

    api.defaults.headers.Authorization = `Bearer ${token}`;
    setUser(usuario);
  }

  function logout() {
    localStorage.removeItem("@SuperBrasil:user");
    localStorage.removeItem("access_token");
    api.defaults.headers.Authorization = "";
    setUser(null);
  }

  return (
    <AuthContext.Provider value={{ user, isAuthenticated: !!user, login, logout, loading }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}