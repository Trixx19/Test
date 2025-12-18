import "./Header.css";
import logo from "../../assets/img/logo.png";
import headerImg from "../../assets/img/header.jpg";

export default function Header() {
  return (
    <header className="main-header">
      {/* Banner Superior */}
      <div className="header-banner-wrapper">
        <img 
          src={headerImg} 
          alt="Banner Super Brasil" 
          className="header-banner-img" 
        />
      </div>

      {/* Conteúdo do Header (Logo + Texto) */}
      <div className="header-content">
        <div className="logo-area">
          <img src={logo} alt="Logo Super Brasil" className="logo-img" />
          <div className="titles-container">
            <h2 className="title-main">Super Brasil</h2>
            <h2 className="title-sub">Telessaúde</h2>
          </div>
        </div>
        <h2 className="slogan">A saúde onde você estiver!</h2>
      </div>
    </header>
  );
}
