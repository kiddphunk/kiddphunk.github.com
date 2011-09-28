(function($) {
    $.fn.imageslicer = function(options) {

        options = $.extend({}, $.fn.imageslicer.defaults, options);

        return this.each(function() {
            $(this).append('<div id="sliceWrapper"></div>');
            $('#sliceWrapper').css({'height' : options.height, 'width' : options.width});
            $('#sliceWrapper').addClass(options.backgroundClass);
            if (!options.sliceWidths)
                options.sliceWidth = options.width / options.numSlices;            
            $(document).oneTime(options.startTime, function() {        
                addSlice($('#sliceWrapper'), options, 0, options.numSlices);
            });
        });
    }
    function addSlice(wrapper, options, offset, count) {
        if (!count) {
            if (options.callback) 
                options.callback.call();
            return;
        }
        var id="sliceWrapper"+count;
        wrapper.append('<div id="'+id+'"></div>');
        if (!options.sliceWidths)
            w = options.sliceWidth;
        else
            w = options.sliceWidths[options.numSlices-count];
        $('#'+id).width(w);
        $('#'+id).height(1);
        $('#'+id).addClass(options.sourceClass);
        $('#'+id).css({'background-position' : '-'+offset+'px 100px'});
        $('#'+id).animate({'height' : '100px','margin-top' : '0','background-position' : '-'+offset+'px 100px'}, 1000);
        $('#'+id).css({'float' : 'left'});
        offset += w; 
        $(document).oneTime(options.stepTime, function() {        
            addSlice($('#sliceWrapper'), options, offset, count-1);
        });
    }
    $.fn.imageslicer.defaults = {
        sourceClass: 'imageslicer-fg',
        backgroundClass: 'imageslicer-bg',
        height:100,
        width:100,
        startTime:1000,
        stepTime:1000,
        numSlices:10,
        callback:null,
        sliceWidth:10,
        sliceWidths:[10,10]
    };
})(jQuery);


