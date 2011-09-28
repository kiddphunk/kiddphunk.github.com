initOverlays = ->
    $("a[rel]").overlay
        mask:   'darkred'
        effect: 'apple'
        onBeforeLoad: ->
            wrap = @getOverlay().find(".contentWrap")
            wrap.load(@getTrigger().attr("href"))
