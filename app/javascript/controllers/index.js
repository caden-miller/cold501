import { application } from "./application"

// Dynamically import all controllers
const modules = import.meta.glob("./**/*_controller.js")

for (const path in modules) {
  modules[path]().then((module) => {
    const controllerName = path
      .replace(/^\.\/(.*)_controller\.js$/, "$1")
      .replace(/\//g, "--")
    application.register(controllerName, module.default)
  })
}
