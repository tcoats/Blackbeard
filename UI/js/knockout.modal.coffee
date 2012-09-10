ko.bindingHandlers.modal =
  init: (element, valueAccessor, allBindingsAccessor) ->
    allBindings = allBindingsAccessor()
    $element = $ element
    $element.addClass 'hide modal'

    if allBindings.modalOptions
      if allBindings.modalOptions.beforeClose
        $element.on 'hide', () ->
          allBindings.modalOptions.beforeClose()

    ko.bindingHandlers.with.init.apply @, arguments

  update: (element, valueAccessor) ->
    value = ko.utils.unwrapObservable valueAccessor()

    returnValue = ko.bindingHandlers.with.update.apply @, arguments

    if value
      $(element).modal 'show'
    else
      $(element).modal 'hide'

    returnValue