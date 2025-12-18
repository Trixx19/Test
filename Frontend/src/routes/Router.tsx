import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import type { ReactNode } from "react";
import { AuthProvider, useAuth } from "../context/AuthContext"; 
import Login from "../pages/Login/Login"; 
import MeusArtigos from "../pages/MeusArtigos/MeusArtigos";
import { CadastroPage } from "../pages/Cadastro/CadastroPage"; 
import TelaPassos from "../pages/TelaPassos/TelaPassos";
import MeuPerfil from "../pages/MeuPerfil/MeuPerfil";
import EditarPerfil from "../pages/EditarPerfil/EditarPerfil";
import MainLayout from "../layouts/MainLayout";

import RedefinirSenhaSolicitar from "../pages/RedefinirSenhaSolicitar/RedefinirSenhaSolicitar"; 
import RedefinirSenhaNova from "../pages/RedefinirSenhaNova/RedefinirSenhaNova";

// --- 1. ADICIONE ESSA IMPORTAÇÃO ---

// Componente para proteger rotas
function RotaPrivada({ children }: { children: ReactNode }) { 
  const { isAuthenticated, loading } = useAuth();
  
  if (loading) return <div>Carregando...</div>;
  
  return isAuthenticated ? <>{children}</> : <Navigate to="/login" />;
}


export default function Router() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <Routes>
          {/* Rota raiz redireciona para login */}
          <Route path="/" element={<Navigate to="/login" />} />
          
          <Route path="/login" element={<Login />} />
          <Route path="/cadastro" element={<CadastroPage />} /> 
          <Route element={<MainLayout />}>
            <Route path="/meus-artigos" element={<MeusArtigos />} />
            <Route path="/login" element={<Login />} />
            <Route path="/ajuda" element={<TelaPassos />} />
            <Route path="/perfil" element={<MeuPerfil />} />
            <Route path="/perfil/editar" element={<EditarPerfil />} />
          </Route>
          
          {/* Rotas de redefinição de senha */}
          <Route path="/redefinir-senha" element={<RedefinirSenhaSolicitar />} />
          <Route path="/redefinir-senha/nova" element={<RedefinirSenhaNova />} />
          
          <Route 
            path="/dashboard" 
            element={
              <RotaPrivada>
                <h1>Dashboard - Área Logada</h1>
              </RotaPrivada>
            } 
          />
        </Routes>
      </AuthProvider>
    </BrowserRouter>
  );
}