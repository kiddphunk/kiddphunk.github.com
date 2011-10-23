# }
# 
# 
# function initScrollPanes(scope) {
#   if (!scope) {scope = '';} else {scope += ' ';}
#   $(scope+'.scroll-pane').jScrollPane({scrollbarWidth:(useNarrowScroll)?20:25, scrollbarMargin:10});
#   $(scope+'.jScrollPaneDrag').css("width", "5px");
#   $(scope+".jScrollPaneTrack").hoverIntent( {    
#      sensitivity: 3, // number = sensitivity threshold (must be 1 or higher)    
#      interval: 20,// number = milliseconds for onMouseOver polling interval    
#      over: scrollOver,
#      timeout: 50, // number = milliseconds delay before onMouseOut    
#      out: scrollOut 
#   });
# }
# 
# function unInitScrollPanes(scope) {
#   if (!scope) {scope = '';} else {scope += ' ';}
#   $(scope+'.scroll-pane').jScrollPaneRemove();
# }
# function resetScrollPanes(scope) {
#   if (!scope) {scope = '';} else {scope += ' ';}
#   $this = $(this);
#   this.scrollTo('.top');
# }
# 
# function scrollOver() {
#      $(this).parent().find(".jScrollPaneDrag").animate({ 
#         borderLeft: "0px",
#         borderRight: "0px",
#         marginLeft: "0px",
#         width: (useNarrowScroll) ? "20px" : "25px",
#         filter: "alpha(opacity=20)",
#         "-moz-opacity":".20",
#         opacity:".20"
#       }, 150 );
#    }
# 
# function scrollOut() {
#     $(this).parent().find(".jScrollPaneDrag").animate({ 
#        borderLeft: "0px",
#        borderRight: "0px",
#        marginLeft: "8px",
#        width: (useNarrowScroll) ? "5px" : "9px",
#        filter:"alpha(opacity=50)",
#        "-moz-opacity":".50",
#        opacity:".50"
#      }, 150 );
#    }




    
#     
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

        
        if ('createTouch' in document) 
            $container.delegate     '.elementWrapper', 'ontouchup', (e) ->
                $(e.target) .width   900
                $container.isotope  'reLayout'

        else 
            $container.delegate     '.elementWrapper', 'click', (e) ->
                $wrapper = $(e.target)
                $elt     = $wrapper.find('.element').first()
                                
                if $wrapper  .width() is 450
                    $wrapper .animate 
                        width:           225
                        height:          225, 
                        100, '',  -> 
                            $container.isotope 'reLayout'
                    $elt     .animate
                        width:           225 
                        height:          225
                else
                    $wrapper .animate 
                        height:          450 
                        width:           450,
                        100, '',  -> 
                            $container.isotope 'reLayout'
                    $elt     .animate
                        width:           450
                        height:          450

                
        
        addProjectElements containerName, data.projects
        
        
      # $container.infinitescroll({
      #   navSelector  : '#page_nav',    // selector for the paged navigation 
      #   nextSelector : '#page_nav a',  // selector for the NEXT link (to page 2)
      #   itemSelector : '.element',     // selector for all items you'll retrieve
      #   loading: {
      #       finishedMsg: 'No more pages to load.',
      #       img: 'http://i.imgur.com/qkKy8.gif'
      #     }
      #   },
      #   // call Isotope as a callback
      #   function( newElements ) {
      #     $container.isotope( 'appended', $( newElements ) ); 
      #   }
      # );

    







addProjectElements = (container, datas) ->
    newElements = []
    _(datas)            .each (data) ->   
        newElements     .push (createProjectElement data)

    _(newElements)      .each (elt) ->
        $elt = $(elt)
        $(container)    .isotope('insert', $elt)

    $('.element')       .each (i, elt) ->
        name = $(elt)   .attr 'data-name'
        console.log name
        switch name
            when 'self'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'

            when 'delicious'
                bp =    "0px 75px"
                bc =    "#0000ff"
                bs =    '100%'
                mbs =   '100%'
            
            when 'duke'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'cmu'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'tis'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'akamai'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'cmu-admin'
                bp =    "0px 0px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'iconomy'
                bp =    "0px 0px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'kp-v3-logo'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'tantriccircus'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'menlopark2'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'icaruslogo'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'mandalabrotlogo'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'galactivision'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'tribalpixel-logo'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'flashmobber'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'bpcl'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            when 'tribalpixel'
                bp =    "0px 75px"
                bc =    "#fff"
                bs =    '100%'
                mbs =   '100%'
            else
                bp =    "0px 75px"
                bc =    "#990000"
                bs =    '100%'
                mbs =   '100%'

        $(elt)          .css 
            'background-image':     "url(../projectimages/#{name}/page1.jpg)"
            'background-position':  bp
            'background-repeat':    "no-repeat"
            'background-color':     bc
            'background-size':      bs
            '-moz-background-size': mbs



    # "name":        "generic",
    # "title":       "title",  
    # "output":      "prototype",
    # "honors":      "honors",
    # "organization": "organization",
    # "description": [{"a":"b","c":"d"}],
    # "links":         [{"a":"b"}],
    # "category":    "beats|pixels|code|life",     
    # "sub-category":"work|education|art",         
    # "roles":       "roles",     
    # "date":        "date",     
    # "year":        "year",     
    # "location":    "location",     
    # "languages":   "languages",     
    # "tools":       "tools",
    # "duration":      "long|medium|short",
    # "tags":        "a,b,c"

createProjectElement = (data) ->
    classes = []
    datas   = []
    attrs   = []
    datavars = 
        name         : data?['name']
        title        : data?['title']
        output       : data?['output']
        honors       : data?['honors']
        organization : data?['organization']
        description  : data?['description'][0]
        links        : data?['links']
        category     : data?['category']
        subcategory  : data?['sub-category']
        roles        : data?['roles']
        date         : data?['date']
        year         : data?['year']
        location     : data?['location']
        languages    : data?['languages']
        tools        : data?['tools']
        duration     : data?['duration']
        tags         : data?['tags']

    if v = datavars.year        then classes .push "year_#{v}"
    if v = datavars.category    then classes .push "cat_#{v}"
    if v = datavars.subcategory then classes .push "subcat_#{v}"


    desc = ''
    _(datavars?.description) .each (val, key) ->
        desc += "#{key} / #{val} <p>"

    classes .push 'entry element', 
    _(datavars) .each (val, key) ->
        attrs .push "data-#{key}=\"#{val}\""

    classes = classes .join ' '
    attrs   = attrs   .join ' '

    html = "<div class='elementWrapper'><div class=\"#{classes}\" #{attrs}>\n
            </div><div class='infoWrapper'><h1>#{datavars.title}</h1></div></div>\n\n"            
    html
    





