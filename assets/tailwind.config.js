// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")
const colors = require("tailwindcss/colors");
const { parseColor } = require("tailwindcss/lib/util/color");

/** Converts HEX color to RGB */
const toRGB = (value) => {
  return parseColor(value).color.join(" ");
};

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/app_web.ex",
    "../lib/app_web/**/*.*ex"
  ],
  darkMode: "class",
  theme: {
    extend: {
      screens: {
        "3xl": "1600px",
      },
      colors: {
        theme: {
          1: "rgb(var(--color-theme-1) / <alpha-value>)",
          2: "rgb(var(--color-theme-2) / <alpha-value>)",
        },
        primary: "rgb(var(--color-primary) / <alpha-value>)",
        secondary: "rgb(var(--color-secondary) / <alpha-value>)",
        success: "rgb(var(--color-success) / <alpha-value>)",
        info: "rgb(var(--color-info) / <alpha-value>)",
        warning: "rgb(var(--color-warning) / <alpha-value>)",
        pending: "rgb(var(--color-pending) / <alpha-value>)",
        danger: "rgb(var(--color-danger) / <alpha-value>)",
        light: "rgb(var(--color-light) / <alpha-value>)",
        dark: "rgb(var(--color-dark) / <alpha-value>)",
        darkmode: {
          50: "rgb(var(--color-darkmode-50) / <alpha-value>)",
          100: "rgb(var(--color-darkmode-100) / <alpha-value>)",
          200: "rgb(var(--color-darkmode-200) / <alpha-value>)",
          300: "rgb(var(--color-darkmode-300) / <alpha-value>)",
          400: "rgb(var(--color-darkmode-400) / <alpha-value>)",
          500: "rgb(var(--color-darkmode-500) / <alpha-value>)",
          600: "rgb(var(--color-darkmode-600) / <alpha-value>)",
          700: "rgb(var(--color-darkmode-700) / <alpha-value>)",
          800: "rgb(var(--color-darkmode-800) / <alpha-value>)",
          900: "rgb(var(--color-darkmode-900) / <alpha-value>)",
        },
      },
      fontFamily: {
        "public-sans": ["Public Sans"],
      },
      backgroundImage: {
        waveform: "url('/assets/dist/images/bg-waveform.png')", 
        lucent: "url('/assets/dist/images/bg-lucent.png')",
        "chevron-white":
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23ffffff95' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E\")",
        "chevron-black":
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%2300000095' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E\")",
        "file-icon-empty-directory":
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='46' height='46' viewBox='0 0 46 46'%3E%3Cg id='Group_3' data-name='Group 3' transform='translate(-566.5 -92.5)'%3E%3Crect id='Rectangle_4' data-name='Rectangle 4' width='25' height='39' rx='3' transform='translate(584 94)' fill='%23bbc5d2' stroke='%23aab7c7' stroke-width='1'/%3E%3Cpath id='Rectangle_3' data-name='Rectangle 3' d='M3.191,0H22.34a3.1,3.1,0,0,1,3.191,3V36a3.1,3.1,0,0,1-3.191,3H3.191A3.1,3.1,0,0,1,0,36V3A3.1,3.1,0,0,1,3.191,0Z' transform='translate(569.468 93)' fill='%23bbc5d2' stroke='%23aab7c7' stroke-width='1'/%3E%3Crect id='Rectangle_5' data-name='Rectangle 5' width='45' height='41' rx='3' transform='translate(567 97)' fill='%23c7cfda' stroke='%23aab7c7' stroke-width='1'/%3E%3C/g%3E%3C/svg%3E%0A\")",
        "file-icon-directory":
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='46' height='46' viewBox='0 0 46 46'%3E%3Cg id='Group_3' data-name='Group 3' transform='translate(-566.5 -92.5)'%3E%3Crect id='Rectangle_4' data-name='Rectangle 4' width='24' height='39' rx='3' transform='translate(584 94)' fill='%23bbc5d2' stroke='%23aab7c7' stroke-width='1'/%3E%3Cpath id='Rectangle_3' data-name='Rectangle 3' d='M3,0H21a3,3,0,0,1,3,3V36a3,3,0,0,1-3,3H3a3,3,0,0,1-3-3V3A3,3,0,0,1,3,0Z' transform='translate(571 93)' fill='%23bbc5d2' stroke='%23aab7c7' stroke-width='1'/%3E%3Crect id='Rectangle_2' data-name='Rectangle 2' width='41' height='41' rx='3' transform='translate(569 97)' fill='%23d6dde7' stroke='%23aab7c7' stroke-width='1'/%3E%3Cpath id='Rectangle_5' data-name='Rectangle 5' d='M3,0H42a3,3,0,0,1,3,3V34a3,3,0,0,1-3,3H3a3,3,0,0,1-3-3V3A3,3,0,0,1,3,0Z' transform='translate(567 101)' fill='%23c7cfda' stroke='%23aab7c7' stroke-width='1'/%3E%3C/g%3E%3C/svg%3E%0A\")",
        "file-icon-file":
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='37.001' height='46.045' viewBox='0 0 37.001 46.045'%3E%3Cg id='Group_267' data-name='Group 267' transform='translate(-1580.004 -405.977)'%3E%3Cpath id='Subtraction_14' data-name='Subtraction 14' d='M-578.3-6519.478h-31.4a2.3,2.3,0,0,1-2.294-2.294v-40.458a2.3,2.3,0,0,1,2.294-2.293H-586v10.023h10v32.729A2.3,2.3,0,0,1-578.3-6519.478Z' transform='translate(2192.505 6971)' fill='%23c7cfda' stroke='%23aab7c7' stroke-width='1'/%3E%3Crect id='Rectangle_419' data-name='Rectangle 419' width='4' height='10' transform='translate(1604 407)' fill='%23c7cfda'/%3E%3Crect id='Rectangle_420' data-name='Rectangle 420' width='3' height='11.998' transform='translate(1615.998 415.505) rotate(90)' fill='%23c7cfda'/%3E%3Cpath id='Intersection_2' data-name='Intersection 2' d='M.409,59.473l0-7.331c2.1,1.984,8.331,8.363,8.331,8.363l-7.308,0A1.333,1.333,0,0,1,.409,59.473Z' transform='translate(1607.075 354.996)' fill='%23d6dde7' stroke='%23aab7c7' stroke-width='1'/%3E%3C/g%3E%3C/svg%3E%0A\")",
        "loading-puff":
            "url(\"data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='25' viewBox='0 0 44 44' %3E%3Cg stroke='white' fill='none' fill-rule='evenodd' stroke-width='4' %3E%3Ccircle cx='22' cy='22' r='1' %3E%3Canimate values='1; 20' attributeName='r' begin='0s' dur='1.8s' calcMode='spline' keyTimes='0; 1' keySplines='0.165, 0.84, 0.44, 1' repeatCount='indefinite' /%3E%3Canimate values='1; 0' attributeName='stroke-opacity' begin='0s' dur='1.8s' calcMode='spline' keyTimes='0; 1' keySplines='0.3, 0.61, 0.355, 1' repeatCount='indefinite' /%3E%3C/circle%3E%3Ccircle cx='22' cy='22' r='1' %3E%3Canimate values='1; 20' attributeName='r' begin='-0.9s' dur='1.8s' calcMode='spline' keyTimes='0; 1' keySplines='0.165, 0.84, 0.44, 1' repeatCount='indefinite' /%3E%3Canimate values='1; 0' attributeName='stroke-opacity' begin='-0.9s' dur='1.8s' calcMode='spline' keyTimes='0; 1' keySplines='0.3, 0.61, 0.355, 1' repeatCount='indefinite' /%3E%3C/circle%3E%3C/g%3E%3C/svg%3E\")",
      },
      container: {
        center: true,
      },
      maxWidth: {
        "1/4": "25%",
        "1/2": "50%",
        "3/4": "75%",
      },
      strokeWidth: {
        0.5: 0.5,
        1.5: 1.5,
        2.5: 2.5,
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({addVariant}) => addVariant("phx-no-feedback", [".phx-no-feedback&", ".phx-no-feedback &"])),
    plugin(({addVariant}) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({addVariant}) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({addVariant}) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function({matchComponents, theme}) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = {name, fullPath: path.join(iconsDir, dir, file)}
        })
      })
      matchComponents({
        "hero": ({name, fullPath}) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, {values})
    }),
    plugin(function ({ addBase }) {
      addBase({
        // Default colors
        ":root": {
          "--color-theme-1": toRGB("#03045e"),
          "--color-theme-2": toRGB("#0c4a6e"),
          "--color-primary": toRGB("#03045e"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
        },
        // Default dark-mode colors
        ".dark": {
          "--color-primary": toRGB(colors.blue["700"]),
          "--color-darkmode-50": "87 103 132",
          "--color-darkmode-100": "74 90 121",
          "--color-darkmode-200": "65 81 114",
          "--color-darkmode-300": "53 69 103",
          "--color-darkmode-400": "48 61 93",
          "--color-darkmode-500": "41 53 82",
          "--color-darkmode-600": "40 51 78",
          "--color-darkmode-700": "35 45 69",
          "--color-darkmode-800": "27 37 59",
          "--color-darkmode-900": "15 23 42",
        },
        // Theme 1 colors
        ".theme-1": {
          "--color-theme-1": toRGB(colors.violet["900"]),
          "--color-theme-2": toRGB(colors.rose["800"]),
          "--color-primary": toRGB(colors.violet["900"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 2 colors
        ".theme-2": {
          "--color-theme-1": toRGB(colors.purple["900"]),
          "--color-theme-2": toRGB(colors.cyan["700"]),
          "--color-primary": toRGB(colors.purple["900"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 3 colors
        ".theme-3": {
          "--color-theme-1": toRGB(colors.cyan["700"]),
          "--color-theme-2": toRGB(colors.violet["800"]),
          "--color-primary": toRGB(colors.cyan["700"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 4 colors
        ".theme-4": {
          "--color-theme-1": toRGB(colors.sky["700"]),
          "--color-theme-2": toRGB(colors.rose["800"]),
          "--color-primary": toRGB(colors.sky["700"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 5 colors
        ".theme-5": {
          "--color-theme-1": toRGB(colors.sky["800"]),
          "--color-theme-2": toRGB(colors.emerald["800"]),
          "--color-primary": toRGB(colors.sky["800"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 6 colors
        ".theme-6": {
          "--color-theme-1": toRGB("#247ba0"),
          "--color-theme-2": toRGB("#0a2463"),
          "--color-primary": toRGB("#247ba0"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 7 colors
        ".theme-7": {
          "--color-theme-1": toRGB(colors.lime["950"]),
          "--color-theme-2": toRGB(colors.teal["900"]),
          "--color-primary": toRGB(colors.lime["950"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 8 colors
        ".theme-8": {
          "--color-theme-1": toRGB("#357266"),
          "--color-theme-2": toRGB("#0E3B43"),
          "--color-primary": toRGB("#357266"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 9 colors
        ".theme-9": {
          "--color-theme-1": toRGB("#6C6C60"),
          "--color-theme-2": toRGB("#4D4D42"),
          "--color-primary": toRGB("#6C6C60"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 10 colors
        ".theme-10": {
          "--color-theme-1": toRGB(colors.indigo["800"]),
          "--color-theme-2": toRGB(colors.blue["900"]),
          "--color-primary": toRGB(colors.indigo["800"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 11 colors
        ".theme-11": {
          "--color-theme-1": toRGB("#2f3e46"),
          "--color-theme-2": toRGB("#52796f"),
          "--color-primary": toRGB("#2f3e46"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 12 colors
        ".theme-12": {
          "--color-theme-1": toRGB("#5e503f"),
          "--color-theme-2": toRGB("#22333b"),
          "--color-primary": toRGB("#5e503f"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 13 colors
        ".theme-13": {
          "--color-theme-1": toRGB("#5e548e"),
          "--color-theme-2": toRGB("#231942"),
          "--color-primary": toRGB("#5e548e"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 14 colors
        ".theme-14": {
          "--color-theme-1": toRGB("#02292f"),
          "--color-theme-2": toRGB("#767522"),
          "--color-primary": toRGB("#02292f"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 15 colors
        ".theme-15": {
          "--color-theme-1": toRGB("#4c956c"),
          "--color-theme-2": toRGB("#006466"),
          "--color-primary": toRGB("#4c956c"),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 16 colors
        ".theme-16": {
          "--color-theme-1": toRGB(colors.sky["900"]),
          "--color-theme-2": toRGB(colors.blue["950"]),
          "--color-primary": toRGB(colors.sky["900"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
        // Theme 17 colors
        ".theme-17": {
          "--color-theme-1": toRGB(colors.slate["900"]),
          "--color-theme-2": toRGB(colors.slate["800"]),
          "--color-primary": toRGB(colors.slate["900"]),
          "--color-secondary": toRGB(colors.slate["200"]),
          "--color-success": toRGB(colors.teal["600"]),
          "--color-info": toRGB(colors.cyan["600"]),
          "--color-warning": toRGB(colors.yellow["600"]),
          "--color-pending": toRGB(colors.orange["700"]),
          "--color-danger": toRGB(colors.red["700"]),
          "--color-light": toRGB(colors.slate["100"]),
          "--color-dark": toRGB(colors.slate["800"]),
          "&.dark": {
            "--color-primary": toRGB(colors.sky["800"]),
          },
        },
      });
    }),
  ],
  variants: {
    extend: {
      boxShadow: ["dark"],
    },
  },
}
