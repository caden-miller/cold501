// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)


import ModalController from "./modal_controller"
application.register("modal", ModalController)
