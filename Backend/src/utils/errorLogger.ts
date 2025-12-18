import fs from "fs";
import path from "path";

const LOG_DIR = path.join(process.cwd(), "logs");
const ERROR_LOG = path.join(LOG_DIR, "errors.log");

function ensureLogDir() {
  if (!fs.existsSync(LOG_DIR)) {
    fs.mkdirSync(LOG_DIR, { recursive: true });
  }
}

export default function logError(error: any, context?: Record<string, any>) {
  try {
    ensureLogDir();
    const entry = {
      timestamp: new Date().toISOString(),
      pid: process.pid,
      message: error?.message ?? String(error),
      stack: error?.stack ?? null,
      context: context ?? null,
    };
    fs.appendFileSync(ERROR_LOG, JSON.stringify(entry) + "\n", "utf8");
  } catch (err) {
    // Fallback para console se gravação falhar
    try {
      console.error("Failed to write error log:", err);
    } catch {}
  }
}
