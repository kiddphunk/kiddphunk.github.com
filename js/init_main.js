var down, fixEditorials, indexSizeDown, indexSizeUp, top, up;
var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
$(document).ready(function() {
  $('.genericimg').each(function(i, elt) {
    var h, v;
    h = Math.floor(Math.random() * -240);
    v = Math.floor(Math.random() * -350);
    return $(elt).css({
      'background-position': "" + h + "px " + v + "px"
    });
  });
  return initHeader();
});
indexSizeUp = function() {
  $('.indeximg').hide();
  $('.genericimg').hide();
  $('.post').css({
    'margin-bottom': '0px'
  });
  return $('.postinfo').addClass('indexSizeUp');
};
indexSizeDown = function() {
  $('.indeximg').show();
  $('.genericimg').show();
  $('.post').css({
    'margin-bottom': '-42px'
  });
  $('.postinfo').removeClass('indexSizeUp');
  $('.post img').each(function(i, elt) {});
  return initHeader();
};
fixEditorials = function(e) {
  $(e.target).height(125);
  $(e.target).find('.postinfo').css({
    'top': '78px'
  });
  return $(e.target).find('.postcontent').css({
    'top': '125px'
  });
};
top = function(target) {
  window.target = target;
  return $('#wrap').scrollTo($(target), 800, __bind(function() {}, this));
};
up = function(target) {
  var $target1, $target2;
  if (target == null) {
    target = '';
  }
  if (target) {
    $target1 = target;
    $target2 = target.find('.postcontent').first();
  } else {
    $target1 = $('.post');
    $target2 = $('.postcontent');
  }
  return $target2.animate({
    'height': '1px'
  }, 0, function() {});
};
down = function(target) {
  var $target1, $target2;
  if (target == null) {
    target = '';
  }
  if (target) {
    $target1 = target;
    $target2 = target.find('.postcontent').first();
  } else {
    $target1 = $('.post');
    $target2 = $('.postcontent');
  }
  return $target2.animate({
    'height': '100%'
  }, 0, function() {});
};
$(window).resize(function() {});