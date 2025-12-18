import React from "react";
import "./styles.css";

interface PassoCardProps {
  image: string;
  title: string;
  text: string;
}

export const PassoCard: React.FC<PassoCardProps> = ({ image, title, text }) => {
  return (
    <div className="passo-card">
      <div className="passo-img-container">
        <img src={image} alt={title} className="passo-img" />
      </div>

      <h2 className="passo-title">{title}</h2>
      <p className="passo-text">{text}</p>
    </div>
  );
};
