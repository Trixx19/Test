import bcrypt from "bcryptjs";
import prisma from '../generated/prisma.js';
import type { Usuario } from "@prisma/client";

type TipoUsuario = Usuario['tipo_usuario'];

interface MedicoData {
  especialidade: string;
  telefone: string;
  crm: string;
}

interface CreateUserData {
  nome: string;
  email: string;
  senha: string;
  tipo_usuario: TipoUsuario;
  medico?: MedicoData | undefined;
}

interface UpdateUserData {
  nome?: string;
  email?: string;
  senha?: string;
  tipo_usuario?: TipoUsuario;
  medico?: MedicoData | null;
}

export class UserModel {
  // Buscar usuário por email
  static async findByEmail(email: string) {
    return await prisma.usuario.findUnique({
      where: { email },
      include: { medico: true },
    });
  }

  // Verificar se CRM já existe
  static async findByCRM(crm: string) {
    return await prisma.medico.findUnique({
      where: { crm },
    });
  }

  // Criar novo usuário
  static async create(data: CreateUserData) {
    const { nome, email, senha, tipo_usuario, medico } = data;

    // Hash da senha
    const senha_hash = await bcrypt.hash(senha, 10);

    // Criar usuário (com médico se fornecido)
    const usuario = await prisma.usuario.create({
      data: {
        nome,
        email,
        senha_hash,
        tipo_usuario,
        ...(medico && {
          medico: {
            create: {
              especialidade: medico.especialidade,
              telefone: medico.telefone,
              crm: medico.crm,
            },
          },
        }),
      },
      include: {
        medico: true,
      },
    });

    return usuario;
  }

  // Atualizar usuário
  static async update(id: number, data: UpdateUserData) {
    const { nome, email, senha, tipo_usuario, medico } = data;

    const usuarioExistente = await prisma.usuario.findUnique({
      where: { id_usuario: id },
      include: { medico: true },
    });

    if (!usuarioExistente) {
      throw new Error("Usuário não encontrado");
    }

    const updateData: any = {};

    if (nome !== undefined) updateData.nome = nome;
    if (email !== undefined) updateData.email = email;
    if (tipo_usuario !== undefined) updateData.tipo_usuario = tipo_usuario;

    // Hash da nova senha se fornecida
    if (senha) {
      updateData.senha_hash = await bcrypt.hash(senha, 10);
    }

    if (medico !== undefined) {
      if (medico === null) {
        if (usuarioExistente.medico) {
          updateData.medico = {
            delete: true,
          };
        }
      } else {

        if (usuarioExistente.medico) {
          updateData.medico = {
            update: {
              especialidade: medico.especialidade,
              telefone: medico.telefone,
              crm: medico.crm,
            },
          };
        } else {
          updateData.medico = {
            create: {
              especialidade: medico.especialidade,
              telefone: medico.telefone,
              crm: medico.crm,
            },
          };
        }
      }
    }

    const usuarioAtualizado = await prisma.usuario.update({
      where: { id_usuario: id },
      data: updateData,
      include: {
        medico: true,
      },
    });

    return usuarioAtualizado;
  }

  static async delete(id: number) {
    // Verificar se usuário existe
    const usuarioExistente = await prisma.usuario.findUnique({
      where: { id_usuario: id },
      include: { medico: true },
    });

    if (!usuarioExistente) {
      throw new Error("Usuário não encontrado");
    }

    // Deletar médico associado primeiro (se existir)
    if (usuarioExistente.medico) {
      await prisma.medico.delete({
        where: { id_medico: usuarioExistente.medico.id_medico },
      });
    }

    await prisma.usuario.delete({
      where: { id_usuario: id },
    });

    return { message: "Usuário deletado com sucesso" };
  }

  // Remover senha_hash do objeto
  static removeSensitiveData(usuario: any) {
    const { senha_hash, ...usuarioSemSenha } = usuario;
    return usuarioSemSenha;
  }

  static async findById(id: number) {
    return await prisma.usuario.findUniqueOrThrow({
      where: { id_usuario: id },
      include: { medico: true },
    });
  }
}
