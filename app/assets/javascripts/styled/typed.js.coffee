do ($ = jQuery) ->
  class Typed
    constructor: (element) ->
      @element = $ element
      @target  = $ @element.data('target')

      unless @target.length
        @target = @element.parent().find('h1, h2, h3, h4, h5, h6, p').first()

      @element.text @getContent()

    getContent: ->
      weight = @target.css 'font-weight'
      size   = @target.css 'font-size'
      height = @target.css 'line-height'

      weight = switch weight
        when 100, '100' then 'Extra Light'
        when 200, '200' then 'Light'
        when 300, '300' then 'Book'
        when 400, '400' then 'Regular'
        when 500, '500' then 'Medium'
        when 600, '600' then 'Semibold'
        when 700, '700' then 'Bold'
        when 800, '800' then 'Black'
        when 900, '900' then 'Extra Black'

      weight + ' ' + size + '/' + height

  old = $.fn.typed

  $.fn.typed = ->
    @each ->
      $this = $(this)
      data  = $this.data 'styled.typed'

      $this.data 'styled.typed', data = new Typed(this) unless data

  $.fn.typed.Constructor = Typed

  $.fn.typed.noConflict = ->
    $.fn.typed = old
    return this
