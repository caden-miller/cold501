// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)
;
