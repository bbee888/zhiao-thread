import { registerAs } from "@nestjs/config";

const DEFAULT_DEV_JWT_SECRET_KEY = "dev-secret-key-please-change-0123456789abcdef0123456789abcdef";

const jwtConfig = registerAs("jwt", () => {
  const nodeEnv = process.env.NODE_ENV || "dev";
  const secretKey = process.env.JWT_SECRET_KEY || "";
  if (!secretKey && nodeEnv === "prod") {
    throw new Error("JWT_SECRET_KEY is required in production");
  }

  return {
    secretKey: secretKey || DEFAULT_DEV_JWT_SECRET_KEY,
    expiresIn: Number(process.env.JWT_EXPIRES_IN) || 7200,
    issuer: process.env.JWT_ISSUER || "youlai-nest",
  };
});

export default jwtConfig;

export type JwtConfig = ReturnType<typeof jwtConfig>;
