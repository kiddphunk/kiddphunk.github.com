
# resizeWindow = -> 
#     w = $(window).width() 
#     if w < 838 then w = 838    
#     $('#container') .width w-405
# 

_data    = []
initBPCL = ->
    d3.json '/data/bpcl.json', (data) ->
        if not data 
            d3.json '../data/bpcl.json', (data) ->
                processData data
        else
            processData data
    
    
    processData = (data) ->
        _data = data
        containerName = "#container2"

        $container =                $(containerName)
        $container.isotope
            itemSelector:           '.elementWrapper'
            getSortData:
                symbol:             ($elem) ->
                                        $elem.attr('data-symbol')
            sortBy: 'symbol'

        