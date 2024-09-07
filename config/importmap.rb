# config/importmap.rb
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@popperjs/core", to: "popper.min.js"
pin "bootstrap", to: "bootstrap.min.js"
pin "@rails/actioncable", to: "actioncable.min.js"
pin "controllers", to: "controllers.js"
pin "application", preload: true
pin "moment", to: "https://cdn.jsdelivr.net/npm/moment@2.29.1/min/moment.min.js"
pin "@fullcalendar/core", to: "https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/main.min.js"
pin "@rails/ujs", to: "https://unpkg.com/@rails/ujs@7.0.0-rc.2/lib/assets/compiled/rails-ujs.js"
pin "appointments_calendar", to: "appointments_calendar.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
