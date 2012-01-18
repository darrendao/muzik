// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery-ui
//= require autocomplete-rails

function formatTime(time){
  if (time >= 1439){
    return "23:59"
  }
  var hours = parseInt(time / 60 % 24);
  var minutes = parseInt(time % 60);
  minutes = minutes + "";
  if (minutes.length == 1) {
    minutes = "0" + minutes;
  }
  return hours + ":" + minutes;
}
