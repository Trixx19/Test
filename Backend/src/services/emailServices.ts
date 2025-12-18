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
    // Frontend route for resetting password (include token + email)
    const recoveryLink = `http://localhost:5173/redefinir-senha/nova?token=${token}&email=${encodeURIComponent(
      to
    )}`;

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
      return true;
    } catch (error) {
      console.error(`Erro ao enviar e-mail para ${to}:`, error);
      //Não estoura excessão - apenas registra e retorna false para chamador decidir
      return false;
    }
  }
}
