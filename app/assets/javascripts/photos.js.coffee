# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

setFileUpload = ->
  $('#photo_photo').attr('name','photo[photo]')
  $('#new_photo').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png|mov|mpeg|mpeg4|avi)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_photo').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpg or png image file")
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')

window.insertAtCaret = (areaId, text) ->
  txtarea = document.getElementById(areaId)
  scrollPos = txtarea.scrollTop
  strPos = 0
  br = ((if (txtarea.selectionStart or txtarea.selectionStart is "0") then "ff" else ((if document.selection then "ie" else false))))
  if br is "ie"
    txtarea.focus()
    range = document.selection.createRange()
    range.moveStart "character", -txtarea.value.length
    strPos = range.text.length
  else strPos = txtarea.selectionStart  if br is "ff"
  front = (txtarea.value).substring(0, strPos)
  back = (txtarea.value).substring(strPos, txtarea.value.length)
  txtarea.value = front + text + back
  strPos = strPos + text.length
  if br is "ie"
    txtarea.focus()
    range = document.selection.createRange()
    range.moveStart "character", -txtarea.value.length
    range.moveStart "character", strPos
    range.moveEnd "character", 0
    range.select()
  else if br is "ff"
    txtarea.selectionStart = strPos
    txtarea.selectionEnd = strPos
    txtarea.focus()
  txtarea.scrollTop = scrollPos


#split = (val) ->
#  val.split /,\s*/
#extractLast = (term) ->
#  split(term).pop()
#setAutoComplete = ->
#  $("input.autocomplete").each ->
#    src = $(this).data("source")
#    $(this).autocomplete
#      source: (request, response) ->
#        $.getJSON src,
#          term: extractLast(request.term)
#        , response
#
#      search: ->
#        # custom minLength
#        term = extractLast(@value)
#
#      focus: ->
#        # prevent value inserted on focus
#        false
#
#      select: (event, ui) ->
#        terms = split(@value)
#        # remove the current input
#        terms.pop()
#        # add the selected item
#        terms.push ui.item.value
#        # add placeholder to get the comma-and-space at the end
#        terms.push ""
#
#        
#        @value = terms.join(", ")
jQuery ->
  setFileUpload()
  #setAutoComplete()
  
  $(".thumbnails li").click ->
    insertAtCaret('post_content','[photo]' + $(this).data("photo") + '[/photo]')