import { Link } from 'react-router-dom';
import React from 'react';
import { 
  Star, 
  MapPin, 
  Mail, 
  Phone, 
  Linkedin, 
  GraduationCap, 
  Award, 
  Building2, 
  Edit3, 
  Clock, 
  CalendarCheck 
} from 'lucide-react';

export default function MeuPerfil() {
  return (
    <div className="p-6 max-w-7xl mx-auto font-sans bg-gray-50 min-h-screen text-gray-800">
      
      <h1 className="text-3xl font-bold mb-6 text-gray-900">Meu Perfil Profissional</h1>

      <div className="bg-white rounded-3xl p-8 shadow-sm border border-gray-200 mb-6">
        <div className="flex flex-col lg:flex-row gap-10">

          <div className="flex flex-col items-center w-full lg:w-1/3">
            <div className="relative mb-4">
              <div className="w-48 h-48 rounded-full overflow-hidden border-4 border-gray-100 shadow-inner">
                <img 
                  src="https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=2070&auto=format&fit=crop" 
                  alt="Dr. Carlos" 
                  className="w-full h-full object-cover"
                />
              </div>
              <div className="absolute bottom-2 right-4 bg-blue-600 text-white px-3 py-1 rounded-full flex items-center gap-1 shadow-lg">
                <Star size={14} fill="white" />
                <span className="font-bold text-sm">4.9</span>
              </div>
            </div>

            <h2 className="text-xl font-bold text-gray-900">Dr. Carlos Eduardo Silva</h2>
            <p className="text-blue-600 font-semibold mb-1">Cardiologista</p>
            <p className="text-gray-400 text-sm mb-4">CRM: 123456-CE</p>

            <div className="flex flex-wrap justify-center gap-2 mb-6">
              <span className="bg-blue-100 text-blue-600 px-3 py-1 rounded-lg text-xs font-medium">Cardiologia</span>
              <span className="bg-blue-100 text-blue-600 px-3 py-1 rounded-lg text-xs font-medium">Ecocardiografia</span>
              <span className="bg-blue-100 text-blue-600 px-3 py-1 rounded-lg text-xs font-medium">Medicina Preventiva</span>
            </div>
            
            <Link to="/perfil/editar" className="w-full bg-[#2C3E50] hover:bg-[#34495e] text-white py-3 rounded-xl flex items-center justify-center gap-2 font-medium transition-colors shadow-lg">
              <Edit3 size={18} />
              Editar Perfil
            </Link>
          </div>

          <div className="flex-1">

            <div className="mb-8">
              <h3 className="flex items-center gap-2 text-lg font-bold mb-3">
                <span className="w-1 h-6 bg-blue-600 rounded-full block"></span>
                Sobre Mim
              </h3>
              <p className="text-gray-500 text-sm leading-relaxed text-justify">
                Médico cardiologista com mais de 14 anos de experiência no diagnóstico e tratamento de doenças cardiovasculares. Especialista em ecocardiografia e medicina preventiva, com foco em proporcionar um atendimento humanizado e personalizado para cada paciente. Comprometido com a excelência médica e a atualização constante em sua área de atuação.
              </p>
            </div>

            <div className="flex gap-4 mb-6">
              <div className="bg-blue-100 rounded-xl p-4 flex-1 flex flex-col items-center justify-center text-blue-800">
                <div className="flex items-center gap-2 mb-1 text-sm font-semibold opacity-80">
                  <Clock size={16} /> Experiência
                </div>
                <span className="font-bold text-lg">14 anos</span>
              </div>
              <div className="bg-blue-100 rounded-xl p-4 flex-1 flex flex-col items-center justify-center text-blue-800">
                <div className="flex items-center gap-2 mb-1 text-sm font-semibold opacity-80">
                  <CalendarCheck size={16} /> Consultas
                </div>
                <span className="font-bold text-lg">1500+ realizadas</span>
              </div>
            </div>

            <div className="bg-[#FFF8DC] border border-yellow-100 rounded-xl p-6 mb-6">
              <h4 className="flex items-center gap-2 text-yellow-700 font-bold mb-4 text-sm uppercase tracking-wide">
                <div className="border rounded-full border-yellow-600 p-0.5"><span className="text-xs">i</span></div>
                Informações de Contato
              </h4>
              <ul className="space-y-3 text-sm text-gray-700">
                <li className="flex items-center gap-3">
                  <Mail size={16} className="text-gray-400" />
                  dr.carlos.silva@superbrasil.com.br
                </li>
                <li className="flex items-center gap-3">
                  <Phone size={16} className="text-gray-400" />
                  (85) 99876 - 5432
                </li>
                <li className="flex items-center gap-3">
                  <Linkedin size={16} className="text-gray-400" />
                  https://www.linkedin.com/in/carlos-eduardo
                </li>
              </ul>
            </div>

            <div>
              <h4 className="font-bold mb-3">Idiomas</h4>
              <div className="flex gap-3">
                {['Português', 'Inglês', 'Espanhol'].map(lang => (
                  <span key={lang} className="border border-gray-300 text-gray-600 px-4 py-1.5 rounded-full text-sm">
                    {lang}
                  </span>
                ))}
              </div>
            </div>

          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">

        <div className="bg-white rounded-3xl p-8 shadow-sm border border-gray-200 h-full">
          <h3 className="flex items-center gap-2 text-blue-500 font-bold text-lg mb-6">
            <GraduationCap size={24} />
            Formação Acadêmica
          </h3>

          <div className="space-y-6 relative pl-2">

            <div className="relative border-l-2 border-blue-400 pl-6 pb-2">
              <h4 className="font-bold text-gray-800">Medicina</h4>
              <p className="text-gray-500 text-sm">Universidade de São Paulo (USP)</p>
              <p className="text-gray-400 text-xs mt-1">2005 - 2010</p>
            </div>

            <div className="relative border-l-2 border-blue-400 pl-6 pb-2">
              <h4 className="font-bold text-gray-800">Residência em Cardiologia</h4>
              <p className="text-gray-500 text-sm">Hospital das Clínicas - FMUSP</p>
              <p className="text-gray-400 text-xs mt-1">2011 - 2014</p>
            </div>

            <div className="relative border-l-2 border-blue-400 pl-6">
              <h4 className="font-bold text-gray-800">Doutorado em Cardiologia</h4>
              <p className="text-gray-500 text-sm">Universidade Federal de São Paulo (UNIFESP)</p>
              <p className="text-gray-400 text-xs mt-1">2015 - 2018</p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-3xl p-8 shadow-sm border border-gray-200 border-t-4 border-t-yellow-400 h-full">
          <h3 className="flex items-center gap-2 text-yellow-500 font-bold text-lg mb-6">
            <Award size={24} />
            Certificações e Especializações
          </h3>
          
          <ul className="space-y-4">
            {[
              "Especialização em Ecocardiografia pela Sociedade Brasileira de Cardiologia",
              "Certificação em Cardiologia Intervencionista",
              "Curso Avançado de Eletrocardiografia",
              "Pós-graduação em Medicina do Esporte",
              "Certificado Internacional em Cardiologia Preventiva"
            ].map((item, index) => (
              <li key={index} className="flex items-start gap-3 text-sm text-gray-700">
                <span className="mt-1.5 w-2.5 h-2.5 rounded-full bg-yellow-400 shrink-0"></span>
                {item}
              </li>
            ))}
          </ul>
        </div>
      </div>

      <div className="bg-white rounded-3xl p-8 shadow-sm border border-gray-200">
        <h3 className="flex items-center gap-2 text-blue-500 font-bold text-lg mb-6">
          <Building2 size={24} />
          Hospitais e Clínicas
        </h3>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          {['Hospital do Coração (HCor)', 'Hospital Albert Einstein', 'Clínica CardioSaúde'].map((hospital) => (
            <div key={hospital} className="bg-blue-200/50 rounded-xl p-6 flex flex-col justify-center min-h-[100px]">
              <h4 className="font-bold text-gray-800 text-sm mb-2">{hospital}</h4>
              <div className="flex items-center gap-2 text-gray-500 text-xs">
                <MapPin size={16} className="text-gray-700" />
                São Paulo, SP
              </div>
            </div>
          ))}
        </div>
      </div>

    </div>
  );
}