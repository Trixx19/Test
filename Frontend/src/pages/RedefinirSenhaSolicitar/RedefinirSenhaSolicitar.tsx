import "./RedefinirSenhaSolicitar.css";
import { useState } from "react";
import api from "../../api/client";

export default function RedefinirSenhaSolicitar() {
  const [emailOuUsuario, setEmailOuUsuario] = useState("");
  const [msg, setMsg] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();

    try {
      await api.get("/api/recuperar-senha", {
        params: { email: emailOuUsuario },
      });

      setMsg(
        "Se o e-mail existir, você receberá instruções para redefinir sua senha."
      );
    } catch (error) {
      setMsg("Erro ao solicitar redefinição. Tente novamente.");
    }
  }

  return (
    <div className="reset-container">
      <div className="reset-card">
        <h2 className="reset-title">Redefinir Senha</h2>
        <p className="reset-subtitle">Digite seu email ou seu Usuário</p>

        <form onSubmit={handleSubmit} className="reset-form">
          <input
            type="text"
            placeholder="Usuário/Email"
            className="reset-input"
            value={emailOuUsuario}
            onChange={(e) => setEmailOuUsuario(e.target.value)}
          />

          <div className="reset-info-box">
            Você receberá em seu email de cadastro as instruções para redefinir
            sua senha.
          </div>

          <button type="submit" className="reset-button">
            Avançar
          </button>
        </form>

        {msg && <p className="reset-message">{msg}</p>}
      </div>
    </div>
  );
}
