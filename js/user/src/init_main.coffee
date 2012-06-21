$(document) .ready ->    
    # Offset the image on any generic letter images.
    $('.genericimg') .each (i, elt) ->
        h = Math.floor Math.random() * -240
        v = Math.floor Math.random() * -350
        $(elt) .css 'background-position':"#{h}px #{v}px"

    initHeader()
    
    $('.galleryimage') .each (i, elt) ->
        $(elt) .css
            'cursor': 'pointer'

    
    # Scroll to top of article.
    # if $('#indexpage').length is 0
    #     $(window).scrollTo('.postinfo', {duration:1000})




indexSizeUp = ->
    $('.indeximg') .hide()
    $('.genericimg') .hide()
    $('.post') .css 'margin-bottom':'0px'
    $('.postinfo') .addClass 'indexSizeUp'
#    $('.shoutout p') .css 'font-weight':'normal'


indexSizeDown = ->
    $('.indeximg') .show()
    $('.genericimg') .show()
    $('.post') .css 'margin-bottom':'-42px'
    $('.postinfo') .removeClass 'indexSizeUp'
#    $('.shoutout p') .css 'font-weight':'bold'

    

    # $('.post') .live 'touchend', (e) ->
    #     $(e.target) .toggleClass 'notExpanded'
    #     if $(e.target) .hasClass 'notExpanded'
    #         down $(e.currentTarget)
    #     else
    #         up $(e.currentTarget)
    $('.post img') .each (i, elt) ->
#        return yes
#        down $(elt)
#        up   $(elt)

#            return fixEditorials(e)
        # $(elt) .Touchable() .bind 'tap', (e, touch) ->
        #     focus = $(e.target) .parents '.post'
        #     $(focus) .toggleClass 'isExpanded'
        #     if $(focus) .hasClass 'isExpanded'
        #         down $(focus)
        #     else
        #         up $(focus)
        #     top focus

    # 
    # $('.post') .live 'click', (e) ->
    #     $(e.target) .toggleClass 'notExpanded'
    #     if $(e.target) .hasClass 'notExpanded'
    #         down $(e.currentTarget)
    #     else
    #         up $(e.currentTarget)
    initHeader()
#    initOverlays()
#    initIsotope()
#    updateIsotopeLayout '.isoContent', 'straightDown'
#    updateIsotopeLayout '.isoContent', 'straightAcross'

#    document.addEventListener 'touchmove', ((e) -> e.preventDefault()), false


#    initScrolls()


fixEditorials = (e) ->
    $(e.target) .height(125)        
    $(e.target) .find('.postinfo')    .css 'top':'78px'
    $(e.target) .find('.postcontent') .css 'top':'125px'



top = (target) ->
    window.target  = target
    $('#wrap') .scrollTo $(target), 800, => 



up = (target='') ->
    if target 
        $target1 = target
        $target2 = target .find('.postcontent') .first()
    else
        $target1 = $('.post')
        $target2 = $('.postcontent')

    $target2 .animate {'height':'1px'}, 0, -> 


down = (target='') ->
    if target 
        $target1 = target
        $target2 = target .find('.postcontent') .first()
    else
        $target1 = $('.post')
        $target2 = $('.postcontent')

    $target2 .animate {'height':'100%'}, 0, -> 


$(window) .resize -> 
    # resizeHeader()    
    # resizeScrolls()
    # resizeIsotope()
