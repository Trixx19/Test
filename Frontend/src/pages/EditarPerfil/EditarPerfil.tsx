import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { 
  ArrowLeft, 
  Camera, 
  Plus, 
  Trash2, 
  Edit2, 
  X,
  Upload
} from 'lucide-react';

export default function EditarPerfil() {
  const [idiomas, setIdiomas] = useState(['Português', 'Inglês', 'Espanhol']);
  const [novoIdioma, setNovoIdioma] = useState('');

  const handleAddIdioma = () => {
    if (novoIdioma && !idiomas.includes(novoIdioma)) {
      setIdiomas([...idiomas, novoIdioma]);
      setNovoIdioma('');
    }
  };

  const removeIdioma = (lang: string) => {
    setIdiomas(idiomas.filter(l => l !== lang));
  };

  return (
    <div className="p-6 max-w-7xl mx-auto font-sans bg-white min-h-screen text-gray-800">

      <div className="mb-6">
        <Link to="/perfil" className="flex items-center gap-2 text-gray-600 hover:text-gray-900 transition-colors mb-4">
          <ArrowLeft size={20} />
          Voltar para o Perfil
        </Link>
        <h1 className="text-3xl font-bold text-gray-900">Editar Meu Perfil Profissional</h1>
      </div>

      <div className="flex flex-col lg:flex-row gap-8">

        <div className="flex-1 bg-blue-50/80 rounded-3xl p-6 lg:p-8 space-y-8 border border-blue-100">

          <div>
            <h2 className="text-xl font-bold text-blue-600 mb-4 border-b border-blue-200 pb-2">
              Dados Pessoais
            </h2>
            
            <div className="space-y-4">
              <div>
                <label className="block text-sm font-bold text-gray-700 mb-1">Nome Completo*</label>
                <input 
                  type="text" 
                  defaultValue="Dr. Carlos Eduardo Silva"
                  className="w-full bg-white border-none rounded-lg p-3 shadow-sm focus:ring-2 focus:ring-blue-400 outline-none"
                />
              </div>

              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-bold text-gray-700 mb-1">Especialidade*</label>
                  <select className="w-full bg-white border-none rounded-lg p-3 shadow-sm focus:ring-2 focus:ring-blue-400 outline-none text-gray-700">
                    <option>Cardiologia</option>
                    <option>Dermatologia</option>
                    <option>Ortopedia</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-bold text-gray-700 mb-1">CRM*</label>
                  <input 
                    type="text" 
                    defaultValue="123456-SP"
                    className="w-full bg-white border-none rounded-lg p-3 shadow-sm focus:ring-2 focus:ring-blue-400 outline-none"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-bold text-gray-700 mb-1">Sobre Você*</label>
                <textarea 
                  rows={4}
                  className="w-full bg-white border-none rounded-lg p-3 shadow-sm focus:ring-2 focus:ring-blue-400 outline-none resize-none"
                  defaultValue="Médico cardiologista com mais de 14 anos de experiência..."
                ></textarea>
                <p className="text-xs text-gray-400 mt-1 text-right">165/500 caracteres</p>
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div>
                  <label className="block text-sm font-bold text-gray-700 mb-1">Email*</label>
                  <input type="email" defaultValue="carlos.silva@gmail.com" className="w-full bg-white rounded-lg p-3 shadow-sm" />
                </div>
                <div>
                  <label className="block text-sm font-bold text-gray-700 mb-1">Data de Nascimento*</label>
                  <input type="date" className="w-full bg-white rounded-lg p-3 shadow-sm" />
                </div>
                <div>
                  <label className="block text-sm font-bold text-gray-700 mb-1">Telefone*</label>
                  <input type="tel" defaultValue="(11) 98765-4321" className="w-full bg-white rounded-lg p-3 shadow-sm" />
                </div>
              </div>

              <div>
                <label className="block text-sm font-bold text-gray-700 mb-1">Idiomas*</label>
                <div className="flex gap-2 mb-3">
                  <input 
                    type="text" 
                    placeholder="Adicionar idioma" 
                    value={novoIdioma}
                    onChange={(e) => setNovoIdioma(e.target.value)}
                    className="flex-1 bg-white rounded-lg p-3 shadow-sm outline-none"
                  />
                  <button onClick={handleAddIdioma} className="bg-blue-500 hover:bg-blue-600 text-white p-3 rounded-lg shadow-md transition-colors">
                    <Plus size={24} />
                  </button>
                </div>
                <div className="flex flex-wrap gap-2">
                  {idiomas.map(lang => (
                    <span key={lang} className="bg-white px-3 py-1 rounded-full text-sm text-gray-700 shadow-sm flex items-center gap-2 border border-gray-100">
                      {lang}
                      <button onClick={() => removeIdioma(lang)} className="text-gray-400 hover:text-red-500"><X size={14} /></button>
                    </span>
                  ))}
                </div>
              </div>
            </div>
          </div>

          <div>
            <h2 className="text-xl font-bold text-blue-600 mb-4 border-b border-blue-200 pb-2">
              Dados Profissionais
            </h2>

            <div className="space-y-6">

              <div className="bg-white/50 p-4 rounded-xl">
                <div className="flex justify-between items-center mb-3">
                  <label className="text-sm font-bold text-blue-800">Hospitais e clínicas</label>
                  <button className="text-xs bg-blue-500 text-white px-3 py-1 rounded-full hover:bg-blue-600 transition">Adicionar +</button>
                </div>
                {['Hospital Sírio-Libanês', 'Hospital Albert Einstein'].map((hosp, idx) => (
                  <div key={idx} className="flex justify-between items-center bg-white p-3 rounded-lg mb-2 shadow-sm">
                    <div>
                      <p className="font-bold text-gray-800">{hosp}</p>
                      <p className="text-xs text-gray-500">Médico Cardiologista</p>
                    </div>
                    <div className="flex gap-2 text-sm">
                      <button className="text-blue-500 hover:underline">Editar</button>
                      <button className="text-red-400 hover:underline">Remover</button>
                    </div>
                  </div>
                ))}
              </div>

              <div className="bg-white/50 p-4 rounded-xl">
                 <label className="block text-sm font-bold text-blue-800 mb-3">Certificações e Títulos</label>
                 <div className="space-y-2">
                    <input type="text" defaultValue="Título de Especialista em Cardiologia - SBC" className="w-full bg-white p-3 rounded-lg shadow-sm" />
                    <input type="text" defaultValue="Fellow American College of Cardiology" className="w-full bg-white p-3 rounded-lg shadow-sm" />
                    <button className="text-xs text-gray-500 hover:text-blue-600 flex items-center gap-1 mx-auto mt-2">
                      Adicionar Certificação <Plus size={12} />
                    </button>
                 </div>
              </div>

              <div>
                <label className="block text-sm font-bold text-blue-800 mb-1">Preço da Consulta</label>
                <p className="text-xs text-gray-500 mb-1">Valor da Consulta Online (R$)</p>
                <input type="number" defaultValue="250" className="w-full bg-white p-3 rounded-lg shadow-sm font-bold text-gray-800" />
              </div>

              <div className="bg-white/50 p-4 rounded-xl">
                <div className="flex justify-between items-center mb-3">
                  <label className="text-sm font-bold text-blue-800">Formação Acadêmica</label>
                  <button className="text-xs bg-blue-500 text-white px-3 py-1 rounded-full hover:bg-blue-600 transition">Adicionar +</button>
                </div>
                <div className="bg-white p-3 rounded-lg shadow-sm mb-2 relative border-l-4 border-blue-400">
                   <h4 className="font-bold text-gray-800">Medicina</h4>
                   <p className="text-xs text-gray-500">Universidade de São Paulo (USP)</p>
                   <p className="text-xs text-gray-400">Ano: 2009</p>
                   <div className="absolute top-3 right-3 flex gap-2 text-xs">
                      <button className="text-blue-500">Editar</button>
                      <button className="text-red-400">Remover</button>
                   </div>
                </div>
              </div>

              <div className="bg-white/50 p-4 rounded-xl">
                <h4 className="text-sm font-bold text-blue-800 mb-3">Disponibilidade</h4>
                <div className="space-y-2">
                  <label className="flex items-center justify-between bg-white p-3 rounded-lg shadow-sm cursor-pointer">
                    <div>
                      <span className="font-bold text-gray-800 block text-sm">Aceitando novos pacientes</span>
                      <span className="text-xs text-gray-500">Seu perfil aparecerá nas buscas</span>
                    </div>
                    <input type="checkbox" defaultChecked className="w-5 h-5 accent-blue-600" />
                  </label>
                  <label className="flex items-center justify-between bg-white p-3 rounded-lg shadow-sm cursor-pointer">
                    <div>
                      <span className="font-bold text-gray-800 block text-sm">Consultas de emergência</span>
                      <span className="text-xs text-gray-500">Disponível para urgências</span>
                    </div>
                    <input type="checkbox" className="w-5 h-5 accent-blue-600" />
                  </label>
                </div>
              </div>

            </div>
          </div>
          
          <div className="pt-4">
             <button className="w-full bg-blue-600 hover:bg-blue-700 text-white py-4 rounded-xl font-bold text-lg shadow-lg transition-transform hover:scale-[1.01]">
                Salvar Alterações
             </button>
          </div>

        </div>

        <div className="w-full lg:w-80 flex flex-col gap-6">

          <div className="bg-blue-100/50 rounded-3xl p-6 flex flex-col items-center text-center border border-blue-100">
            <h3 className="text-blue-600 font-bold mb-6 w-full text-left">Foto de Perfil</h3>
            
            <div className="relative mb-6 group cursor-pointer">
              <div className="w-40 h-40 rounded-full overflow-hidden border-4 border-white shadow-md">
                <img 
                   src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=2070&auto=format&fit=crop" 
                   alt="Perfil" 
                   className="w-full h-full object-cover"
                />
              </div>
              <div className="absolute inset-0 bg-black/30 rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                 <Camera className="text-white" size={32} />
              </div>
            </div>

            <button className="w-full bg-blue-200 hover:bg-blue-300 text-blue-800 py-2.5 rounded-lg font-bold flex items-center justify-center gap-2 mb-2 transition-colors">
              <Upload size={18} />
              Alterar Foto
            </button>
            <p className="text-xs text-gray-500">JPG, PNG até 5MB</p>
          </div>

          <div className="space-y-3">
            <button className="w-full bg-[#C00000] hover:bg-red-800 text-white py-3 rounded-2xl font-bold shadow-md transition-colors">
              Excluir Conta
            </button>
            <button className="w-full bg-[#FFD700] hover:bg-yellow-500 text-black py-3 rounded-2xl font-bold shadow-md transition-colors">
              Desativar Conta
            </button>
          </div>

        </div>

      </div>
    </div>
  );
}