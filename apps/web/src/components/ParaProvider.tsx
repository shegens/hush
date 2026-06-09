"use client";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Environment, ParaProvider as ParaSDKProvider } from "@getpara/react-sdk";
import "@getpara/react-sdk/styles.css";
import type { ReactNode } from "react";

const API_KEY = process.env.NEXT_PUBLIC_PARA_API_KEY ?? "";
const ENV = (process.env.NEXT_PUBLIC_PARA_ENVIRONMENT as Environment) || Environment.BETA;

if (!API_KEY) {
  throw new Error("NEXT_PUBLIC_PARA_API_KEY is not set.");
}

const queryClient = new QueryClient();

export function ParaProvider({ children }: { children: ReactNode }) {
  return (
    <QueryClientProvider client={queryClient}>
      <ParaSDKProvider
        paraClientConfig={{ apiKey: API_KEY, env: ENV }}
        config={{ appName: "Hush" }}
        paraModalConfig={{
          logo: "/logo.svg",
          disableEmailLogin: false,
          disablePhoneLogin: true,
          authLayout: ["AUTH:FULL", "EXTERNAL:FULL"],
          oAuthMethods: ["APPLE", "GOOGLE"],
          recoverySecretStepEnabled: true,
          twoFactorAuthEnabled: false,
          theme: {
            foregroundColor: "#221206",
            backgroundColor: "#FDF6EE",
            accentColor: "#D96B10",
            mode: "light",
            borderRadius: "sm",
            font: "Georgia",
          },
        }}
      >
        {children}
      </ParaSDKProvider>
    </QueryClientProvider>
  );
}
