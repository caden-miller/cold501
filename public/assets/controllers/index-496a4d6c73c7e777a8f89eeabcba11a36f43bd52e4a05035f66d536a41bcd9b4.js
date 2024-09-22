// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { definitionsFromContext } from "@hotwired/stimulus-loading"

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController);
