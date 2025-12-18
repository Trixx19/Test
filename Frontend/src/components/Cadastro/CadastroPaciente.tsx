import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { StepPacienteDados } from './StepPacienteDados';
import { StepPacienteEndereco } from './StepPacienteEndereco';
import { StepPacienteConta } from './StepPacienteConta';
import { UserService } from '../../services/userService';
import Header from '../Header_Login/Header';

export function CadastroPaciente() {
  const navigate = useNavigate();
  const [step, setStep] = useState(1);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const [formData, setFormData] = useState({
    nome: '', 
    cpf: '', 
    nascimento: '', 
    apelido: '', 
    genero: '', 
    celular: '',
    cep: '', 
    endereco: '', 
    numero: '', 
    complemento: '', 
    bairro: '', 
    cidade: '', 
    estado: '',
    imagem: null, 
    email: '', 
    senha: '', 
    confirmarSenha: ''
  });

  const handleNext = () => setStep((prev) => prev + 1);
  const handleBack = () => setStep((prev) => prev - 1);

  const handleChange = (newValues: any) => {
    setFormData((prev) => ({ ...prev, ...newValues }));
  };

  const handleSubmit = async () => {
    if (formData.senha !== formData.confirmarSenha) {
      alert("As senhas não coincidem!");
      return;
    }

    if (!formData.email || !formData.senha || !formData.nome) {
      alert("Preencha os campos obrigatórios (Nome, Email e Senha).");
      return;
    }

    setIsSubmitting(true);

    try {
      const payload = {
        nome: formData.nome,
        email: formData.email,
        senha: formData.senha,
        tipo_usuario: "PACIENTE" as const
      };

      await UserService.create(payload);

      alert("Cadastro realizado com sucesso!");
      navigate('/login');

    } catch (error: any) {
      console.error(error);
      const msg = error.error || "Erro ao criar conta. Tente novamente.";
      alert(msg);
    } finally {
      setIsSubmitting(false);
    }
  };
  
  return (
    <div className="min-h-screen bg-white flex flex-col items-center font-['League_Spartan'] text-gray-800">
      
      <div className="w-full max-w-5xl p-6 mt-8 flex flex-col items-center">

        <div className="text-center mb-8">
          <h2 className="text-3xl font-bold mb-1">Criar nova conta</h2>
          <h3 className="text-2xl font-bold">Paciente</h3>
        </div>

        <div className="w-full mb-10 min-h-[400px]">
          {step === 1 && (
            <StepPacienteDados data={formData} onChange={handleChange} />
          )}

          {step === 2 && (
            <StepPacienteEndereco data={formData} onChange={handleChange} />
          )}

          {step === 3 && (
            <StepPacienteConta data={formData} onChange={handleChange} />
          )}
        </div>

        <div className="w-full max-w-4xl flex justify-end items-center mt-4 px-4">

          {step > 1 && (
            <button 
              onClick={handleBack} 
              disabled={isSubmitting}
              className="mr-6 text-gray-500 font-bold hover:text-black transition-colors disabled:opacity-50"
            >
              Voltar
            </button>
          )}

          <button
            onClick={step === 3 ? handleSubmit : handleNext}
            disabled={isSubmitting}
            className="px-12 py-3 rounded-full font-bold text-white text-lg shadow-md transition-transform transform hover:scale-105 bg-[#F9D443] hover:bg-yellow-400 disabled:opacity-70 disabled:cursor-not-allowed flex items-center gap-2"
            style={{ textShadow: '0px 1px 2px rgba(0,0,0,0.1)' }}
          >
            {isSubmitting ? 'Salvando...' : (step === 3 ? 'Criar Conta!' : 'Avançar')}
          </button>
        </div>

      </div>
    </div>
  );
}