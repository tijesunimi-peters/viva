# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

hideNotify = ->
  $("div.notification").fadeOut(500)

@notify = (v, time) ->
  $("<div/>", {
    "class": "notification white",
    text: v,
    click: ->
      $("div.notification").fadeOut(500)
  }).appendTo("body").fadeIn(500)

  setTimeout(hideNotify, time)
