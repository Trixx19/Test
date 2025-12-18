import "./RedefinirSenhaNova.css";
import { useState, useEffect } from "react";
import { useLocation } from "react-router-dom";
import api from "../../api/client";

export default function RedefinirSenhaNova() {
  const [novaSenha, setNovaSenha] = useState("");
  const [confirmarSenha, setConfirmarSenha] = useState("");
  const [msg, setMsg] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();

    if (novaSenha !== confirmarSenha) {
      setMsg("As senhas não coincidem.");
      return;
    }

    try {
      const params = new URLSearchParams(window.location.search);
      const token = params.get("token");

      if (!token) {
        setMsg("Token ausente.");
        return;
      }

      await api.post("/api/redefinir-senha", { token, nova_senha: novaSenha });

      setMsg("Senha redefinida com sucesso!");
    } catch (error) {
      setMsg("Erro ao redefinir senha.");
    }
  }

  useEffect(() => {
    const params = new URLSearchParams(window.location.search);
    const token = params.get("token");
    const email = params.get("email");

    if (!token || !email) {
      setMsg("Link inválido de recuperação de senha.");
      return;
    }

    // Validar token no backend
    (async () => {
      try {
        await api.get("/api/validar-token", { params: { token, email } });
        // token válido — nada a fazer
      } catch (err) {
        setMsg("Token inválido ou expirado.");
      }
    })();
  }, []);

  return (
    <div className="reset-nova-container">
      <div className="reset-nova-card">
        <h2 className="reset-nova-title">Redefinir Senha</h2>
        <p className="reset-nova-subtitle">
          Digite sua senha aleatória e a nova senha
        </p>

        <form onSubmit={handleSubmit} className="reset-nova-form">
          <input
            type="password"
            placeholder="Nova Senha"
            className="reset-nova-input"
            value={novaSenha}
            onChange={(e) => setNovaSenha(e.target.value)}
          />

          <input
            type="password"
            placeholder="Repita a nova senha"
            className="reset-nova-input"
            value={confirmarSenha}
            onChange={(e) => setConfirmarSenha(e.target.value)}
          />

          <button type="submit" className="reset-nova-button">
            Avançar
          </button>
        </form>

        {msg && <p className="reset-nova-message">{msg}</p>}
      </div>
    </div>
  );
}
