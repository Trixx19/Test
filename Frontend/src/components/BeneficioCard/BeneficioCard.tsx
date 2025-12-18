import React from "react";
import "./styles.css";

interface BeneficioCardProps {
  icon: string;
  title: string;
  text: string;
}

export const BeneficioCard: React.FC<BeneficioCardProps> = ({ icon, title, text }) => {
  return (
    <div className="beneficio-card">
      <div className="beneficio-icon-container">
        <img src={icon} alt={title} className="beneficio-icon" />
      </div>
      <div>
        <h3 className="beneficio-card-title">{title}</h3>
        <p className="beneficio-card-text">{text}</p>
      </div>
    </div>
  );
};
