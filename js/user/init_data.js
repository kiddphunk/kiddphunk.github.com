var initBPCL, _data;
_data = [];
initBPCL = function() {
  var processData;
  d3.json('/data/bpcl.json', function(data) {
    if (!data) {
      return d3.json('../data/bpcl.json', function(data) {
        return processData(data);
      });
    } else {
      return processData(data);
    }
  });
  return processData = function(data) {
    var $container, containerName;
    _data = data;
    containerName = "#container2";
    $container = $(containerName);
    return $container.isotope({
      itemSelector: '.elementWrapper',
      getSortData: {
        symbol: function($elem) {
          return $elem.attr('data-symbol');
        }
      },
      sortBy: 'symbol'
    });
  };
};