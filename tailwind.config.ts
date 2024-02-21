import type { Config } from "tailwindcss"
const defaultTheme = require("tailwindcss/defaultTheme")

export default {
  darkMode: ["class", '[data-mode="dark"]'],
  content: [
    "pkg/views/**/*.{css,ts,tsx,go,html,svg,mdx,md,js,json,templ,tmpl,yml,yaml,xml,php,py,rb,rs,java,kt,htm,sql,sh,swift,tsv,txt,graphql,less,scss,sass,styl,stylus}"
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          '"Inter var", sans-serif',
          {
            fontFeatureSettings: '"cv11", "ss01"',
            fontVariationSettings: '"opsz" 32'
          },
          ...defaultTheme.fontFamily.sans
        ]
      }
    }
  },
  plugins: [
    require("daisyui"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/container-queries")
  ],
  daisyui: {
    themes: false, // false: only light + dark | true: all themes | array: specific themes like this ["light", "dark", "cupcake"]
    darkTheme: "dark", // name of one of the included themes for dark mode
    base: true, // applies background color and foreground color for root element by default
    styled: true, // include daisyUI colors and design decisions for all components
    utils: true, // adds responsive and modifier utility classes
    prefix: "", // prefix for daisyUI classnames (components, modifiers and responsive class names. Not colors)
    logs: true, // Shows info about daisyUI version and used config in the console when building your CSS
    themeRoot: ":root" // The element that receives theme color CSS variables
  }
} satisfies Config
