function runBPCLAnim(c){var b=[12,5,6,2,12,11,8,4,12,3,0,12,12,7,4,8,12,9,11,3];var a=[".bpclanimb",".bpclanimp",".bpclanimc",".bpclaniml",100,100];c.append('<div id="bpclanim"></div>');$("#bpclanim").css({width:"100px",height:"100px"});for(i=0;i<5;i++){for(j=0;j<4;j++){var d="bpclanim"+i+""+j;$("#bpclanim").append('<div id="'+d+'"></div>');$("#"+d).css({width:"10px",margin:"2px",height:"10px","float":"left","background-color":"#fff"});if(b[i*4+j]&8){$("#"+d).addClass("bpclanimb")}if(b[i*4+j]&4){$("#"+d).addClass("bpclanimp")}if(b[i*4+j]&2){$("#"+d).addClass("bpclanimc")}if(b[i*4+j]&1){$("#"+d).addClass("bpclaniml")}if(j==0){$("#"+d).css({clear:"both"})}}}$(document).oneTime(a[4],function(){$(a[0]).css({"background-color":"#ff3d00"});$(document).oneTime(a[5],function(){$(a[0]).css({"background-color":"#ddd"});$(document).oneTime(a[4],function(){$(a[1]).css({"background-color":"#ff006e"});$(document).oneTime(a[5],function(){$(a[1]).css({"background-color":"#ddd"});$(document).oneTime(a[4],function(){$(a[2]).css({"background-color":"#009bea"});$(document).oneTime(a[5],function(){$(a[2]).css({"background-color":"#ddd"});$(document).oneTime(a[4],function(){$(a[3]).css({"background-color":"#00f300"});$(document).oneTime(a[5],function(){$(a[3]).css({"background-color":"#ddd"})})})})})})})})})};
var initHeader, resizeHeader;
initHeader = function() {
  $('.bpcl_logo').removeClass('bpcl_logo').removeClass('new_bpcl_header_left').addClass('bpcl_header_left');
  $('.new_bpcl_header_right').removeClass('new_bpcl_header_right').addClass('bpcl_header_right');
  resizeHeader();
  return $(document).oneTime(500, function() {
    return $('.bpcl_header_left').imageslicer({
      width: 132,
      startTime: 100,
      stepTime: 800,
      numSlices: 6,
      sliceWidths: [27, 23, 2, 18, 22, 24],
      callback: function() {
        return runBPCLAnim($('#bpcl_animation'));
      }
    });
  });
};
resizeHeader = function() {
  var w;
  w = $(window).width();
  if (w < 838) {
    w = 838;
  }
  return $('#container').width(w - 405);
};