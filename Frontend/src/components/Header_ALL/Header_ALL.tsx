import React from 'react';
import { Link, useLocation } from 'react-router-dom';
import { Search, Home, FileText, HelpCircle, RefreshCw, Wallet, User } from 'lucide-react';

import imgFaixa from '../../assets/img/header.jpg'; 
import logo from '../../assets/img/logo.png'; 

interface HeaderProps {
  mostrarNavegacao?: boolean;
}

export default function Header({ mostrarNavegacao = true }: HeaderProps) {
  const location = useLocation();

  const isActive = (path: string) => location.pathname === path;
  return (
    <header className="w-full flex flex-col bg-white shadow-sm sticky top-0 z-50 font-sans">

      <div 
        className="w-full h-5 md:h-6" 
        style={{ 
          backgroundImage: `url(${imgFaixa})`,
          backgroundRepeat: 'repeat-x',
          backgroundSize: 'contain',
          backgroundPosition: 'center'
        }}
      />

      <div className="max-w-7xl w-full mx-auto px-4 py-3 flex items-center justify-between gap-4">

        <Link to={mostrarNavegacao ? "/dashboard" : "/"} className="flex items-center gap-3 select-none">
          <img src={logo} alt="Super Brasil" className="h-10 md:h-12" />
          <div className="flex flex-col leading-tight">
            <span className="text-[#003B4C] font-bold text-lg md:text-xl tracking-tight">Super Brasil</span>
            <span className="text-gray-600 text-sm font-medium">Telessaúde</span>
          </div>
        </Link>

        {mostrarNavegacao && (
          <>
            <div className="hidden md:flex flex-1 max-w-lg mx-4">
              <div className="w-full relative group">
                <input 
                  type="text" 
                  placeholder="Pesquisar" 
                  className="w-full bg-[#A3D9C9]/20 border border-[#A3D9C9] text-gray-700 rounded-full py-2.5 pl-12 pr-4 focus:outline-none focus:ring-2 focus:ring-[#A3D9C9] focus:bg-white transition-all placeholder-gray-500"
                />
                <Search className="absolute left-4 top-3 text-black" size={20} />
              </div>
            </div>

            <nav className="flex items-center gap-2 md:gap-3">
              <NavItem 
                icon={<Home size={20} />} 
                link="/dashboard" 
                tooltip="Início" 
                active={isActive('/dashboard')} 
              />
              <NavItem 
                icon={<FileText size={20} />} 
                link="/meus-artigos" 
                tooltip="Meus Artigos" 
                active={isActive('/meus-artigos')} 
              />
              <NavItem 
                icon={<HelpCircle size={20} />} 
                link="#" 
                tooltip="Ajuda" 
              />
              <NavItem 
                icon={<RefreshCw size={20} />} 
                link="#" 
                tooltip="Sincronizar" 
              />
              <NavItem 
                icon={<Wallet size={20} />} 
                link="#" 
                tooltip="Carteira" 
              />
              <NavItem 
                icon={<User size={20} />} 
                link="/perfil" 
                tooltip="Meu Perfil" 
                active={isActive('/perfil') || isActive('/perfil/editar')} 
              />
            </nav>
          </>
        )}

      </div>
    </header>
  );
}

function NavItem({ icon, link, tooltip, active = false }: { icon: React.ReactNode, link: string, tooltip: string, active?: boolean }) {
  return (
    <Link 
      to={link} 
      title={tooltip}
      className={`
        w-10 h-10 rounded-full flex items-center justify-center border transition-all duration-200
        ${active 
          ? 'border-[#009E7F] text-[#009E7F] bg-[#009E7F]/10' 
          : 'border-[#009E7F] text-black hover:bg-[#009E7F] hover:text-white'}
      `}
    >
      {icon}
    </Link>
  );
}