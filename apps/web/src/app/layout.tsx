"use client";

import { ParaProvider } from "@getpara/react-sdk";
import "@getpara/react-sdk/styles.css";
import type { ReactNode } from "react";

const PARA_ENV = process.env.NEXT_PUBLIC_PARA_ENV as "beta" | "prod" ?? "beta";
const PARA_API_KEY = process.env.NEXT_PUBLIC_PARA_API_KEY ?? "";

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>
        <ParaProvider
          paraClientConfig={{
            env: PARA_ENV,
            apiKey: PARA_API_KEY,
          }}
          config={{
            appName: "Hush",
          }}
          paraModalConfig={{
            logo: "/logo.svg",
          }}
        >
          {children}
        </ParaProvider>
      </body>
    </html>
  );
}
