import { ParaProvider } from "@/components/ParaProvider";
import type { ReactNode } from "react";

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="en">
      <body>
        <ParaProvider>{children}</ParaProvider>
      </body>
    </html>
  );
}
