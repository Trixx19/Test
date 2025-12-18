import "./styles.css";
import { PassoCard } from "../../components/PassoCard/PassoCard";
import imagem1 from "../../assets/icones/image 21.png";
import { BeneficioCard } from "../../components/BeneficioCard/BeneficioCard";

import shield from '../../assets/icones/image 34.png';
import seta from '../../assets/icones/image 27.png';

export default function TelaPassos() {
  return (
    <div className="tela-passos-container">

      {/* Banner superior */}
      <div className="banner">
        <h1>Como Funciona a Super Brasil Telessaúde?</h1>
        <p>
          Conectamos você aos melhores profissionais de saúde através de uma plataforma
          simples, segura e conveniente.
        </p>
      </div>

      <h2 className="subtitulo">Apenas 4 Passos para seu Atendimento</h2>

      {/* Cards */}
      <div className="cards-container">
        <PassoCard
          image={imagem1}
          title="Busque seu Médico"
          text="Pesquise por especialidade, localização ou nome do profissional. Veja avaliações e perfis completos."
        />

        <PassoCard
          image={imagem1}
          title="Agende sua Consulta"
          text="Escolha o melhor horário disponível na agenda do médico. Agendamento rápido e fácil."
        />

        <PassoCard
          image={imagem1}
          title="Realize a Teleconsulta"
          text="Atendimento por vídeo com qualidade e segurança. Fale com seu médico de onde estiver."
        />

        <PassoCard
          image={imagem1}
          title="Receba Documentos"
          text="Receitas, atestados e exames enviados digitalmente. Tudo organizado no seu perfil."
        />
      </div>
      <div className="beneficios-container">

      <div className="beneficios-box">

        <div className="beneficios-left">
          <h1>Por que escolher a Super Brasil?</h1>
          <p className="beneficios-texto">
            Nossa plataforma oferece tudo o que você precisa para cuidar
            da sua saúde com praticidade e segurança.
          </p>

          <ul className="beneficios-lista">
            <li><img src={seta} alt="" /> Consultas online com médicos certificados</li>
            <li><img src={seta} alt="" />Agendamento 24/7 pela plataforma</li>
            <li><img src={seta} alt="" /> Histórico médico completo e seguro</li>
            <li><img src={seta} alt="" /> Receitas digitais válidas</li>
            <li><img src={seta} alt="" /> Suporte ao paciente</li>
            <li><img src={seta} alt="" /> Preços transparentes</li>
            <li><img src={seta} alt="" /> Pagamento seguro</li>
            <li><img src={seta} alt="" /> Avaliações verificadas</li>
          </ul>
        </div>

        <div className="beneficios-right">
          <BeneficioCard
            icon={shield}
            title="Segurança e Privacidade"
            text="Seus dados médicos são protegidos com criptografia de ponta e seguem todas as normas da LGPD."
          />

          <BeneficioCard
            icon={shield}
            title="Pagamento Facilitado"
            text="Aceita todas as formas de pagamento. Parcelamento disponível e preços transparentes."
          />
        </div>

      </div>

      <div className="beneficios-cta">
        <h2>Pronto para começar?</h2>
        <p className="cta-texto">
          Cadastre-se agora e tenha acesso a milhares de médicos especializados
        </p>
      </div>

    </div>

    </div>
    
    
  );
}
