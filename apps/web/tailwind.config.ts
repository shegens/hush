import type { Config } from "tailwindcss";

const config: Config = {
  content: ["./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        cream: "#FDF6EE",
        parchment: "#F7EDE2",
        blush: "#F9C49A",
        "blush-light": "#FCDFC4",
        wine: "#D96B10",
        "wine-light": "#F08030",
        "wine-pale": "rgba(215, 120, 40, 0.15)",
        muted: "rgba(215, 120, 40, 0.25)",
        text: "#221206",
        "text-muted": "#8C5828",
        "handle-stat": "#5C2E0E",
        "link-hover": "#F46080",
        heard: "#F46080",
      },
      fontFamily: {
        sans: ["system-ui", "sans-serif"],
        serif: ["Georgia", "serif"],
      },
    },
  },
  plugins: [],
};

export default config;
