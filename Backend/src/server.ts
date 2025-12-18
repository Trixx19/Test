import "dotenv/config";
import app from "./app.js";
import logError from "./utils/errorLogger.js";

// Monkey-patch console.error to also persist errors to disk (minimal, non-invasive)
const originalConsoleError = console.error.bind(console);
console.error = (...args: any[]) => {
  try {
    const maybeError =
      args[0] instanceof Error
        ? args[0]
        : new Error(args.map((a) => String(a)).join(" "));
    logError(maybeError, { via: "console.error" });
  } catch (e) {
    // ignore logging failures
  }
  originalConsoleError(...args);
};

const PORT = process.env.PORT || 3333;

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
  console.log("Database URL:", process.env.DATABASE_URL); // Para debug
});
