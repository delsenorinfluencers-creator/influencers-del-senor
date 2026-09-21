import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Jóvenes Influencers del Señor",
  description: "Medio de comunicación y evangelización digital de la Diócesis de Ocaña."
};

export default function RootLayout({
  children
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="es">
      <body>{children}</body>
    </html>
  );
}