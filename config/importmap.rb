# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@ultimate_turbo_modal", to: "ultimate_turbo_modal.js"
pin_all_from "app/javascript/controllers", under: "controllers"
