var initOverlays;
initOverlays = function() {
  return $("a[rel]").overlay({
    mask: 'darkred',
    effect: 'apple',
    onBeforeLoad: function() {
      var wrap;
      wrap = this.getOverlay().find(".contentWrap");
      return wrap.load(this.getTrigger().attr("href"));
    }
  });
};