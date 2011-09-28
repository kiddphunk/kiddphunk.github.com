var destroyScrolls, initScrolls, refreshScrolls, resizeScrolls;
initScrolls = function() {
  return window.contentScroll = new iScroll('scrollContent', {
    useTransition: true
  });
};
({
  snap: 'li'
});
resizeScrolls = function() {
  return refreshScrolls();
};
refreshScrolls = function() {
  return setTimeout((function() {
    return typeof window !== "undefined" && window !== null ? window.contentScroll.refresh() : void 0;
  }), 0);
};
destroyScrolls = function() {
  if (typeof window !== "undefined" && window !== null) {
    window.contentScroll.destroy();
  }
  return typeof window !== "undefined" && window !== null ? window.contentScroll = null : void 0;
};