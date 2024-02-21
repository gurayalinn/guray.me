![GitHub Release](https://img.shields.io/github/v/release/gurayalinn/guray.me?include_prereleases&sort=semver&display_name=tag&style=flat&logo=github&logoColor=white&label=RELEASE&labelColor=black&color=white&cacheSeconds=0&link=https%3A%2F%2Fgithub.com%2Fgurayalinn%2Fguray.me)
![GitHub go.mod Go version](https://img.shields.io/github/go-mod/go-version/gurayalinn/guray.me?filename=go.mod&style=flat&logo=go&logoColor=white&label=PACKAGES&labelColor=black&color=white&link=https%3A%2F%2Fgithub.com%2Fgurayalinn%2Fguray.me%2Fblob%2Fmaster%2F.github%2FPACKAGE.md)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/gurayalinn/guray.me/checks.yml?branch=master&style=flat&logo=githubactions&logoColor=white&label=TEST&labelColor=black&cacheSeconds=0&link=https%3A%2F%2Fgithub.com%2Fgurayalinn%2Fguray.me%2Factions%2Fworkflows%2Fchecks.yml)
![Codecov](https://img.shields.io/codecov/c/github/gurayalinn/guray?style=flat&logo=codecov&logoColor=white&label=CODECOV&labelColor=black&cacheSeconds=0&link=https%3A%2F%2Fguray.me)
![GitHub License](https://img.shields.io/github/license/gurayalinn/guray.me?style=flat&logo=opensourceinitiative&logoColor=white&label=LICENSE&labelColor=black&color=white&cacheSeconds=15&link=https%3A%2F%2Fgithub.com%2Fgurayalinn%2Fguray.me%2Fblob%2Fmaster%2FLICENSE)
![Mozilla HTTP Observatory Grade](https://img.shields.io/mozilla-observatory/grade/guray.me?publish&style=flat&logo=lighthouse&logoColor=white&label=RANK&labelColor=black&color=&cacheSeconds=15&link=https%3A%2F%2Fguray.me%2F)
![Website](https://img.shields.io/website?url=https%3A%2F%2Fguray.me%2F&up_message=UP&up_color=green&down_message=DOWN&down_color=red&style=flat&logo=cloudflare&logoColor=white&label=WEBSITE&labelColor=black&cacheSeconds=0&link=https%3A%2F%2Fguray.me)
[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/gurayalin.svg?style=social&labelColor=white&logo=x&logoColor=black&label=Twitter%20%40gurayalin)](https://twitter.com/gurayalin)

<p align="center">
  <picture>
 <source media="(prefers-color-scheme: dark)" srcset="/assets/favicon/favicon.svg">
 <source media="(prefers-color-scheme: light)" srcset="/assets/favicon/favicon.svg">
	<img src="/assets/favicon/favicon.svg" width=33% height=auto alt="banner" />
</picture>
</p>
<h1 align="center"><strong><a>guray.me</a></a></h1>
<p align="center">
    <strong><em>My personal blog website powered by GO.</em></strong>
</p>

### ✨ Features

[Package List](/.github/PACKAGE.md)

> [!IMPORTANT] >**_In this application, instead of using the [html/template](https://pkg.go.dev/html/template) package (native Golang templates), we use the [a-h/templ](https://github.com/a-h/templ) library. This amazing library implements a templating language (very similar to JSX) that compiles to Go code. Templ will allow us to write code almost identical to Go (with expressions, control flow, if/else, for loops, etc.) and have autocompletion thanks to strong typing. This means that errors appear at compile time and any calls to these templates (which are compiled as Go functions) from the handlers side will always require the correct data, minimizing errors and thus increasing the security and speed of our coding._**

### ⚙️ Setup:

<details>
  <summary>📝 Local development usage</summary>

> #### **Note**: `make help` list of functions.

```bash
make dev
```

- ⚡️ Running on [localhost:8080](http://localhost:8080)

</details>

---

Besides the obvious prerequisite of having Go! on your machine, you must have Air installed for hot reloading when editing code.

Start the app in development mode:

```
$ air # Ctrl + C to stop the application
```

Build:

```bash
$ go build -o ./bin/main ./cmd/server/main.go # ./bin/main to run the application / Ctrl + C to stop the application
```

> [!TIP] >**_In order to have autocompletion and syntax highlighting in VS Code for the Teml templating language, you will have to install the [templ-vscode](https://marketplace.visualstudio.com/items?itemName=a-h.templ) extension (for vim/nvim install this [plugin](https://github.com/joerdav/templ.vim)). To generate the Go code corresponding to these templates you will have to download this [executable binary](https://github.com/a-h/templ/releases/latest) from Github and place it in the PATH of your system. The command:_**

```bash
$ templ generate --watch --proxy="http://localhost:8080" --cmd "air"
```

> [!TIP] >**_ This will allow us to monitor changes to the .templ files and compile them as we save them. Review the documentation on Templ [installation](https://templ.guide/quick-start/installation) and [support](https://templ.guide/commands-and-tools/ide-support/) for your IDE._**

---

### ⭐ Star History

<div align="center">
 <a target="_blank" href="https://star-history.com/#gurayalinn/guray.me&Date">
  <picture>
 <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=gurayalinn/guray.me&type=Date">
 <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=gurayalinn/guray.me&type=Date">
	<img src="https://api.star-history.com/svg?repos=gurayalinn/guray.me&type=Date" width=80% height=auto alt="Star History Chart" />
</picture>
 </a>
</div>

### 📃 License

<strong> &copy; 2024</strong> [APACHE-2.0](LICENSE)
