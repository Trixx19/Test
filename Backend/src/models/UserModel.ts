import bcrypt from "bcryptjs";
import prisma from "../generated/prisma.js";
import { TipoUsuario } from "@prisma/client";

interface CreateUserData {
  nome: string;
  email: string;
  senha: string;
  tipo_usuario: "ADMIN" | "ESPECIALISTA" | "PACIENTE";
  medico?: {
    crm: string;
    telefone: string;
    especialidade: string;
  } | undefined;
}

interface UpdateUserData {
  nome?: string;
  email?: string;
  senha?: string;
  tipo_usuario?: TipoUsuario;
}

export class UserModel {
  static async findByEmail(email: string) {
    return await prisma.usuario.findUnique({
      where: { email },
      include: { medico: { include: { especialidades: true } } },
    });
  }

  static async findByCRM(crm: string) {
    return await prisma.medico.findUnique({
      where: { crm },
    });
  }

  static async create(data: CreateUserData) {
    const { nome, email, senha, tipo_usuario, medico } = data;

    const senha_hash = await bcrypt.hash(senha, 10);

    let tipoEnum: TipoUsuario = TipoUsuario.PACIENTE;
    if (tipo_usuario === "ADMIN") tipoEnum = TipoUsuario.ADMIN;
    if (tipo_usuario === "ESPECIALISTA") tipoEnum = TipoUsuario.ESPECIALISTA;

    const usuario = await prisma.usuario.create({
      data: {
        nome,
        email,
        senha_hash,
        tipo_usuario: tipoEnum,
        ...(tipoEnum === TipoUsuario.ESPECIALISTA && medico
          ? {
              medico: {
                create: {
                  crm: medico.crm,
                  telefone: medico.telefone,
                  especialidades: {
                    connectOrCreate: {
                      where: { nome: medico.especialidade },
                      create: { 
                        nome: medico.especialidade,
                        orgao_resp: "Conselho Federal"
                      },
                    },
                  },
                },
              },
            }
          : {}),
      },
      include: {
        medico: {
          include: {
            especialidades: true,
          },
        },
      },
    });

    return usuario;
  }

  static async update(id: number, data: UpdateUserData) {
    const { nome, email, senha, tipo_usuario } = data;

    const usuarioExistente = await prisma.usuario.findUnique({
      where: { id_usuario: id },
    });

    if (!usuarioExistente) {
      throw new Error("Usuário não encontrado");
    }

    const updateData: any = {};

    if (nome !== undefined) updateData.nome = nome;
    if (email !== undefined) updateData.email = email;
    if (tipo_usuario !== undefined) updateData.tipo_usuario = tipo_usuario;

    if (senha) {
      updateData.senha_hash = await bcrypt.hash(senha, 10);
    }

    const usuarioAtualizado = await prisma.usuario.update({
      where: { id_usuario: id },
      data: updateData,
      include: { medico: true },
    });

    return usuarioAtualizado;
  }

  static async delete(id: number) {
    const usuarioExistente = await prisma.usuario.findUnique({
      where: { id_usuario: id },
    });

    if (!usuarioExistente) {
      throw new Error("Usuário não encontrado");
    }

    await prisma.usuario.delete({
      where: { id_usuario: id },
    });

    return { message: "Usuário deletado com sucesso" };
  }

  static async findById(id: number) {
    return await prisma.usuario.findUniqueOrThrow({
      where: { id_usuario: id },
      include: { medico: { include: { especialidades: true } } },
    });
  }

  static async findByEmailIncludingPassword(email: string) {
    return await prisma.usuario.findUnique({
      where: { email },
      include: { medico: true },
    });
  }

  static removeSensitiveData(usuario: any) {
    const { senha_hash, ...usuarioSemSenha } = usuario;
    return usuarioSemSenha;
  }
}