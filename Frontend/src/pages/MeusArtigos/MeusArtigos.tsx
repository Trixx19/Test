import React, { useState } from 'react';
import { 
  Plus, 
  BarChart3, 
  Eye, 
  Heart, 
  MessageSquare, 
  TrendingUp, 
  Edit3, 
  Trash2 
} from 'lucide-react';

const articlesData = [
  {
    id: 1,
    title: "10 Dicas para Manter seu Coração Saudável",
    description: "Descubra as melhores práticas para cuidar da saúde cardiovascular e prevenir doenças do coração.",
    image: "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?q=80&w=2070&auto=format&fit=crop", // Imagem genérica de estetoscópio
    views: 1234,
    likes: 80,
    comments: 23,
    status: 'Publicado'
  },
  {
    id: 2,
    title: "Prevenção de Doenças Cardiovasculares",
    description: "Como manter seu coração saudável através de hábitos simples e eficazes no dia a dia.",
    image: "https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?q=80&w=2070&auto=format&fit=crop", // Imagem genérica médica
    views: 856,
    likes: 67,
    comments: 15,
    status: 'Publicado'
  },
  {
    id: 3,
    title: "Alimentação e Saúde do Coração",
    description: "Os melhores alimentos para proteger seu coração e prevenir problemas cardiovasculares.",
    image: "https://images.unsplash.com/photo-1490645935967-10de6ba17061?q=80&w=2053&auto=format&fit=crop", // Imagem de comida saudável
    views: 2103,
    likes: 142,
    comments: 34,
    status: 'Publicado'
  }
];

export default function MeusArtigos() {
  const [tabAtual, setTabAtual] = useState('Publicados');

  return (
    <div className="p-6 max-w-7xl mx-auto font-sans bg-white min-h-screen">

      <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 gap-4">
        <div>
          <h1 className="text-3xl font-bold text-gray-800">
            Meus Artigos
          </h1>
          <p className="text-gray-500 mt-1">
            Gerencie todos os seus artigos publicados e rascunhos
          </p>
        </div>
        
        <button className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2.5 rounded-full flex items-center gap-2 font-medium shadow-lg transition-all">
          <Plus size={20} />
          Criar meu artigo
        </button>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <StatCard 
          icon={<BarChart3 size={24} />} 
          value="3" 
          label="Artigos Publicados" 
        />
        <StatCard 
          icon={<Eye size={24} />} 
          value="4.193" 
          label="Total de Visualizações" 
        />
        <StatCard 
          icon={<Heart size={24} />} 
          value="298" 
          label="Total de Curtidas" 
        />
        <StatCard 
          icon={<MessageSquare size={24} />} 
          value="72" 
          label="Total de Comentários" 
        />
      </div>

      <div className="flex gap-4 mb-6 border-b border-gray-100 pb-1">
        <TabButton 
          active={tabAtual === 'Publicados'} 
          onClick={() => setTabAtual('Publicados')}
          label="Publicados (3)" 
        />
        <TabButton 
          active={tabAtual === 'Rascunhos'} 
          onClick={() => setTabAtual('Rascunhos')}
          label="Rascunhos (1)" 
        />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {articlesData.map((article) => (
          <ArticleCard key={article.id} data={article} />
        ))}
      </div>
    </div>
  );
}

function StatCard({ icon, value, label }: { icon: React.ReactNode, value: string, label: string }) {
  return (
    <div className="bg-gray-100 rounded-2xl p-6 flex flex-col items-center justify-center relative text-center min-h-[140px]">
      <div className="absolute top-4 right-4 text-gray-400">
        <TrendingUp size={16} />
      </div>
      <div className="mb-2 text-gray-700">
        {icon}
      </div>
      <h3 className="text-3xl font-bold text-gray-800 mb-1">{value}</h3>
      <p className="text-blue-500 text-sm font-medium">{label}</p>
    </div>
  );
}

function TabButton({ active, label, onClick }: { active: boolean, label: string, onClick: () => void }) {
  return (
    <button 
      onClick={onClick}
      className={`px-6 py-2 rounded-full text-sm font-medium transition-colors border ${
        active 
          ? 'bg-gray-800 text-white border-gray-800' 
          : 'bg-white text-gray-600 border-gray-300 hover:bg-gray-50'
      }`}
    >
      {label}
    </button>
  );
}

function ArticleCard({ data }: { data: any }) {
  return (
    <div className="bg-gray-50 rounded-3xl overflow-hidden border border-gray-200 shadow-sm hover:shadow-md transition-shadow">
      <div className="relative h-48 w-full">
        <img src={data.image} alt={data.title} className="w-full h-full object-cover" />
        <span className="absolute top-4 left-4 bg-blue-600 text-white text-xs font-bold px-3 py-1 rounded-md">
          {data.status}
        </span>
      </div>

      <div className="p-5">
        <h3 className="text-lg font-bold text-gray-800 leading-tight mb-2">
          {data.title}
        </h3>
        <p className="text-gray-500 text-sm mb-4 line-clamp-2">
          {data.description}
        </p>

        <div className="flex gap-4 text-gray-400 text-xs mb-6">
          <div className="flex items-center gap-1">
            <Eye size={14} /> {data.views}
          </div>
          <div className="flex items-center gap-1">
            <Heart size={14} /> {data.likes}
          </div>
          <div className="flex items-center gap-1">
            <MessageSquare size={14} /> {data.comments}
          </div>
        </div>

        <div className="flex gap-3">
          <button className="flex-1 flex items-center justify-center gap-2 border border-blue-400 text-blue-600 font-medium py-2 rounded-full hover:bg-blue-50 transition-colors">
            <Edit3 size={16} />
            Editar
          </button>
          <button className="px-3 py-2 border border-gray-300 text-gray-500 rounded-full hover:bg-red-50 hover:text-red-500 hover:border-red-200 transition-colors">
            <Trash2 size={18} />
          </button>
        </div>
      </div>
    </div>
  );
}