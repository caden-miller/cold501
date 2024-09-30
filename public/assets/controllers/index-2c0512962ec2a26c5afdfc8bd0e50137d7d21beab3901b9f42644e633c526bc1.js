// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import ModalsController from "./modals_controller"
application.register("modals", ModalsController)

;
