// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


// Importações principais para a aplicação
import "@hotwired/turbo-rails"
import "@popperjs/core"
import "bootstrap"

// Rails UJS (para métodos DELETE e forms Ajax funcionarem corretamente)
import "controllers"
import "calendar"

import { Application } from "@hotwired/stimulus"


const application = Application.start()
application.register('modal', Modal)
application.register('alert', Alert)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

document.addEventListener('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    weekends: true
  });
});

import $ from 'jquery';
window.$ = window.jQuery = $;


export { application }
