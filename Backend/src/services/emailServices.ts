import nodemailer from "nodemailer";
import dotenv from "dotenv";

dotenv.config();

const transporter = nodemailer.createTransport({
  host: process.env.EMAIL_HOST,
  port: parseInt(process.env.EMAIL_PORT || "587", 10),
  secure: process.env.EMAIL_SECURE === "true", 
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

export class EmailService {
  /**
   * Envia um e-mail de recuperação de senha.
   * @param to E-mail do destinatário
   * @param nome Nome do usuário
   * @param token Token de redefinição
   */
  static async sendPasswordRecoveryEmail(
    to: string,
    nome: string,
    token: string
  ) {
  
    const recoveryLink = `http://FRONT_END.COM/resetar-senha?token=${token}`;

    const htmlContent = `
      <html>
        <body>
          <h2>Recuperação de Senha</h2>
          <p>Olá, ${nome},</p>
          <p>Recebemos uma solicitação para redefinir sua senha. Clique no link abaixo para criar uma nova senha:</p>
          <a href="${recoveryLink}" target="_blank">Redefinir Minha Senha</a>
          <p>Se você não solicitou isso, pode ignorar este e-mail.</p>
          <p>Este link expira em 30 minutos.</p>
        </body>
      </html>
    `;

    
    try {
      await transporter.sendMail({
        from: `"Super Brasil Telessaúde" <${process.env.EMAIL_FROM_ADDRESS}>`,
        to: to,
        subject: "Recuperação de Senha",
        html: htmlContent,
      });
      console.log(`E-mail de recuperação enviado para: ${to}`);
    } catch (error) {
      console.error(`Erro ao enviar e-mail para ${to}:`, error);
      throw new Error("Erro ao enviar e-mail de recuperação.");
    }
  }
}