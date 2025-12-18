import { useState } from "react";
import { useAuth } from "../../context/AuthContext";
import { useNavigate, Link } from "react-router-dom";
import { X, Check } from "lucide-react";
import "./Login.css";

import Header from "../../components/Header_Login/Header";
import Footer from "../../components/Footer/Footer";
import imgMedico from "../../assets/img/medico.png";
import imgPaciente from "../../assets/img/paciente.png";
import googleIcon from "../../assets/img/google.png";
import outlookIcon from "../../assets/img/outlook.jpg";
import linkedinIcon from "../../assets/img/linkedin.png";

export default function Login() {
  const [email, setEmail] = useState("");
  const [senha, setSenha] = useState("");
  const [mostrarSenha, setMostrarSenha] = useState(false);
  const [erro, setErro] = useState("");

  const [modalAberto, setModalAberto] = useState(false);
  const [perfilSelecionado, setPerfilSelecionado] = useState<'MEDICO' | 'PACIENTE' | null>(null);

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

  const handleAvançarCadastro = () => {
    if (perfilSelecionado === 'PACIENTE') {
      navigate('/cadastro');
    } else if (perfilSelecionado === 'MEDICO') {
      alert("Cadastro de especialista em breve!");
    }
  };

  return (
    <div className="login-container relative">
      <Header />

      <main className="login-main">
        
        <div className="character-left">
           <img src={imgMedico} alt="Médico" className="char-img" />
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
              </button>
            </div>

            {erro && <span className="error-msg">{erro}</span>}

            <button type="submit" className="btn-entrar">ENTRAR</button>
          </form>

          <div className="social-login">
            <button className="social-btn"><img src={googleIcon} alt="Google" /></button>
            <button className="social-btn"><img src={outlookIcon} alt="Outlook" /></button>
            <button className="social-btn"><img src={linkedinIcon} alt="LinkedIn" /></button>
          </div>

          <div className="links">
            <Link to="/redefinir-senha">Redefinir Senha</Link>
            <br />
            <button 
              type="button"
              onClick={() => setModalAberto(true)}
              className="text-blue-600 hover:underline bg-transparent border-none cursor-pointer mt-2 font-['League_Spartan'] text-base"
            >
              Criar nova conta
            </button>
          </div>
        </div>

        <div className="character-right">
           <img src={imgPaciente} alt="Paciente" className="char-img" />
        </div>
      </main>

      <Footer />

      {modalAberto && (
        <div className="fixed inset-0 z-[999] flex items-center justify-center bg-black bg-opacity-50 backdrop-blur-sm p-4 font-['League_Spartan']">
          
          <div className="relative bg-white w-full max-w-lg rounded-[30px] shadow-2xl p-8 flex flex-col items-center animate-fadeIn">

            <button 
              onClick={() => setModalAberto(false)}
              className="absolute top-5 right-6 text-gray-400 hover:text-red-500 transition-colors"
            >
              <X size={28} />
            </button>

            <h2 className="text-3xl font-bold mb-2 text-black">Criar nova conta</h2>
            <p className="text-gray-600 mb-8">Você é médico ou paciente?</p>

            <div className="flex flex-col sm:flex-row gap-6 justify-center w-full mb-10">

              <button
                onClick={() => setPerfilSelecionado('MEDICO')}
                className={`
                  relative w-40 h-14 rounded-full flex items-center justify-center font-bold text-white transition-all duration-300
                  ${perfilSelecionado === 'MEDICO' 
                    ? 'bg-[#4A90E2] ring-4 ring-blue-200 scale-105 shadow-lg' 
                    : 'bg-[#4A90E2] opacity-80 hover:opacity-100'}
                `}
              >
                {perfilSelecionado === 'MEDICO' && <Check size={20} className="absolute left-3" />}
                Especialista
              </button>

              <button
                onClick={() => setPerfilSelecionado('PACIENTE')}
                className={`
                  relative w-40 h-14 rounded-full flex items-center justify-center font-bold text-white transition-all duration-300
                  ${perfilSelecionado === 'PACIENTE' 
                    ? 'bg-[#43A047] ring-4 ring-green-200 scale-105 shadow-lg' 
                    : 'bg-[#43A047] opacity-80 hover:opacity-100'}
                `}
              >
                {perfilSelecionado === 'PACIENTE' && <Check size={20} className="absolute left-3" />}
                Paciente
              </button>
            </div>

            <button
              onClick={handleAvançarCadastro}
              disabled={!perfilSelecionado}
              className={`
                w-48 py-3 rounded-full font-bold text-white text-xl shadow-md transition-all
                ${!perfilSelecionado 
                  ? 'bg-gray-300 cursor-not-allowed' 
                  : 'bg-[#F9D443] hover:bg-yellow-400 transform hover:scale-105'}
              `}
              style={{ textShadow: '0px 1px 2px rgba(0,0,0,0.1)' }}
            >
              Avançar
            </button>

          </div>
        </div>
      )}
    </div>
  );
}