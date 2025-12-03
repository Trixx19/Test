import { useState } from "react";
import { useAuth } from "../../context/AuthContext";
import { useNavigate } from "react-router-dom";
import "./Login.css";

// Imagens do layout
import imgMedico from "../../assets/img/medico.png";
import imgPaciente from "../../assets/img/paciente.png";
import logo from "../../assets/img/logo.png"; 

// Ícones dos botões (Novos)
import googleIcon from "../../assets/img/google.png";
import outlookIcon from "../../assets/img/outlook.jpg"; // Note que é .jpg
import linkedinIcon from "../../assets/img/linkedin.png";
// import olhoIcon from "../../assets/img/olho.png"; // Opcional: caso queira usar no input de senha

export default function Login() {
  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [mostrarSenha, setMostrarSenha] = useState(false);
  const [erro, setErro] = useState("");
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErro("");
    try {
      await login(email, senha);
      navigate("/dashboard");
    } catch (error) {
      setErro("Usuário ou senha incorretos.");
    }
  };

  return (
    <div className="login-container">
      <div className="top-bar-decoration"></div>

      <header className="login-header">
        <div className="logo-area">
           <img src={logo} alt="Logo Super Brasil" className="logo-img" />
           
           {/* Container para empilhar os textos */}
           <div className="titles-container">
             <h2 className="title-main">Super Brasil</h2>
             <h2 className="title-sub">Telessaúde</h2>
           </div>
        </div>
        <h2 className="slogan">A saúde onde você estiver!</h2>
      </header>

      <main className="login-main">
        <div className="character-left">
           <img src={imgMedico} alt="Ilustração Médico" className="char-img" />
        </div>

        <div className="login-card">
          <h1>LOGIN</h1>
          <p className="subtitle">Acesse sua conta para continuar.</p>

          <form onSubmit={handleSubmit}>
            <div className="input-group">
              <input 
                type="email" 
                placeholder="Usuário/Email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required 
              />
            </div>

            <div className="input-group password-group">
              <input 
                type={mostrarSenha ? "text" : "password"} 
                placeholder="Senha"
                value={senha}
                onChange={(e) => setSenha(e.target.value)}
                required 
              />
              <button 
                type="button" 
                className="toggle-eye"
                onClick={() => setMostrarSenha(!mostrarSenha)}
              >
                {mostrarSenha ? "🙈" : "👁️"} 
                {/* Se quiser usar a imagem do olho, troque a linha acima por: 
                    <img src={olhoIcon} alt="Ver senha" style={{width: '20px'}} /> 
                */}
              </button>
            </div>

            {erro && <span className="error-msg">{erro}</span>}

            <button type="submit" className="btn-entrar">ENTRAR</button>
          </form>

          {/* Botões com as imagens reais */}
          <div className="social-login">
            <button className="social-btn" title="Entrar com Google">
              <img src={googleIcon} alt="Google" />
            </button>
            <button className="social-btn" title="Entrar com Outlook">
              <img src={outlookIcon} alt="Outlook" />
            </button>
            <button className="social-btn" title="Entrar com LinkedIn">
              <img src={linkedinIcon} alt="LinkedIn" />
            </button>
          </div>

          <div className="links">
            <a href="#">Redefinir Senha</a>
            <br />
            <a href="#">Criar nova conta</a>
          </div>
        </div>

        <div className="character-right">
           <img src={imgPaciente} alt="Ilustração Paciente" className="char-img" />
        </div>
      </main>

      <footer className="login-footer">
        <p>Ao entrar, você concorda com nossos termos de uso e política de privacidade!</p>
      </footer>
    </div>
  );
}