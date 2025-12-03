import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "../context/AuthContext"; // Importar o Provider
import Login from "../pages/Login/Login"; // Importar a nova tela

// Componente simples para proteger rotas
import { useAuth } from "../context/AuthContext";
function RotaPrivada({ children }: { children: JSX.Element }) {
  const { isAuthenticated, loading } = useAuth();
  if (loading) return <div>Carregando...</div>;
  return isAuthenticated ? children : <Navigate to="/" />;
}

export default function Router() {
  return (
    <BrowserRouter>
      {/* O AuthProvider deve envolver as rotas para prover o estado */}
      <AuthProvider>
        <Routes>
          <Route path="/" element={<Login />} />
          
          {/* Exemplo de rota protegida */}
          <Route 
            path="/dashboard" 
            element={
              <RotaPrivada>
                <h1>Bem-vindo ao Sistema (Dashboard)</h1>
              </RotaPrivada>
            } 
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}