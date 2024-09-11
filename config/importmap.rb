# config/importmap.rb
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@popperjs/core", to: "popper.min.js"
pin "bootstrap", to: "bootstrap.min.js"
pin "@rails/actioncable", to: "actioncable.min.js"
pin "controllers", to: "controllers.js"
pin "application", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@fullcalendar/core", to: "@fullcalendar--core.js" # @6.1.15
pin "preact" # @10.12.1
pin "preact/compat", to: "preact--compat.js" # @10.12.1
pin "preact/hooks", to: "preact--hooks.js" # @10.12.1
pin "@fullcalendar/daygrid", to: "@fullcalendar--daygrid.js" # @6.1.15
pin "@fullcalendar/timegrid", to: "@fullcalendar--timegrid.js" # @6.1.15
pin "@fullcalendar/interaction", to: "@fullcalendar--interaction.js" # @6.1.15
