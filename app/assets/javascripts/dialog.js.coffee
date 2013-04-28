processDialog = ->
  popup = $("#dialog_form")
  popup.dialog('option', 'position', ['center', 'center'])

  popup.find('.cancel-button')
    .click ->
      popup.dialog('close')
      return false
  popup.find('.dialog_form').submit ->
    $.ajax(
      type: this.method
      url: this.action
      data: $(this).serialize()
      dataType: "script"
      error: errorHandler
    )
    popup.dialog('close')
    return false


errorHandler = (xhr, status,error) ->
  $("#dialog_form").dialog('open')

jQuery ->
  popup = $("#dialog_form")

  popup.dialog(
    dialogClass: 'main_dialog'
    autoOpen: false
    modal: true
    minHeight: 330
    height: 'auto'
    width: 700
    resizable: false
    open: processDialog
  )

  $("a.dialog").live 'click', ->
    popup_url = $(this).attr('href')
    popup.load( popup_url + '.html #main', ->
      if popup.dialog( "isOpen" )
        processDialog()
      else
        popup.dialog('open')
    )
    return false

