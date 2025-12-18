import { PrismaClient } from '@prisma/client';

declare global {
  // allow global variable in development to persist across module reloads
  // eslint-disable-next-line no-var
  var _prisma: PrismaClient | undefined;
}

const prisma =
  process.env.NODE_ENV === 'production'
    ? new PrismaClient()
    : global._prisma ?? (global._prisma = new PrismaClient());

export default prisma;
