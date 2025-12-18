import React from "react";
import logo from "../../assets/img/logo.png"; 

import { FaLinkedin, FaFacebook, FaInstagramSquare, FaWhatsappSquare } from "react-icons/fa";

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="w-full bg-[#333333] text-white py-10 px-6 mt-auto font-sans">
      <div className="max-w-7xl mx-auto flex flex-col md:flex-row justify-between items-center gap-8">

        <div className="w-full md:w-auto flex justify-center md:justify-start">
          <div className="bg-[#4AA985] p-5 rounded-xl max-w-[320px] w-full shadow-sm">
            <div className="flex items-center gap-3 mb-2">
              <img 
                src={logo} 
                alt="Super Brasil Logo" 
                className="h-10 w-auto brightness-0 invert" 
              />
              <div className="flex flex-col leading-none text-white">
                <span className="font-extrabold text-lg tracking-wide">SUPER BRASIL</span>
                <span className="font-normal text-sm">TELESSAÚDE</span>
              </div>
            </div>
            <p className="text-xs text-white/90 leading-tight font-medium">
              Tecnologia para democratizar o acesso à saúde em todo o Brasil
            </p>
          </div>
        </div>

        {/* 2. CENTRO: Copyright e Dados */}
        <div className="text-center space-y-1">
          <p className="text-sm text-gray-200 font-medium">
            © {currentYear} SUPER SUPER BRASIL TELESSAÚDE
          </p>
          <p className="text-sm text-gray-200">
            CNPJ nº 50.029.808/0001-70
          </p>
          <p className="text-sm text-gray-400 mt-2">
            Todos os direitos reservados.
          </p>
        </div>

        {/* 3. LADO DIREITO: Redes Sociais */}
        <div className="flex flex-col items-center md:items-end gap-3">
          <p className="text-sm font-medium">Conheça a Super Brasil Telessaúde nas redes:</p>
          
          <div className="flex gap-3">
            <SocialIcon 
              href="https://www.linkedin.com/company/super-brasil-telessa%C3%BAde/" 
              color="bg-[#3b7dc0]" 
              icon={<FaLinkedin />} 
              title="LinkedIn" 
            />
            <SocialIcon 
              href="#" 
              color="bg-[#c9b008]" 
              icon={<FaInstagramSquare />} 
              title="Instagram" 
            />
            <SocialIcon 
              href="https://www.facebook.com/rogerio.morais.1257" 
              color="bg-[#3b65c0]" 
              icon={<FaFacebook />} 
              title="Facebook" 
            />
            <SocialIcon 
              href="https://api.whatsapp.com/send/?phone=5585911889563&text&type=phone_number&app_absent=0" 
              color="bg-[#4aa985]" 
              icon={<FaWhatsappSquare />} 
              title="WhatsApp" 
            />
          </div>
        </div>

      </div>
    </footer>
  );
}

function SocialIcon({ href, color, icon, title }: { href: string, color: string, icon: React.ReactNode, title: string }) {
  return (
    <a 
      href={href} 
      title={title}
      target="_blank"
      rel="noopener noreferrer"
      className={`
        w-10 h-10 rounded-lg flex items-center justify-center text-white text-2xl 
        transition-transform hover:-translate-y-1 shadow-md
        ${color}
      `}
    >
      {icon}
    </a>
  );
}