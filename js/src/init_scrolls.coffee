initScrolls = ->
    window.contentScroll = new iScroll 'scrollContent', {
        useTransition:  yes
#		hScrollbar:     false
#		vScrollbar:     false
		snap:           'li'
    }
 
 
resizeScrolls = -> refreshScrolls()
 
 
refreshScrolls = ->
	setTimeout ( -> window?.contentScroll.refresh() ), 0


destroyScrolls = ->
    window?.contentScroll.destroy()
    window?.contentScroll = null




    # $('#thelist .innerWrapper') .live 'click', (e) ->
    # 
    #     $('#thelist .innerWrapper') .each (i, v) =>
    #         if v isnt e.target then $(v) .parent() .fadeOut()
    # 
    #     $(e.target) .toggleClass 'fullscreen'
