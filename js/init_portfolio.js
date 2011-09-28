var addProjectElements, createProjectElement, initBPCL, _data;
var __indexOf = Array.prototype.indexOf || function(item) {
  for (var i = 0, l = this.length; i < l; i++) {
    if (this[i] === item) return i;
  }
  return -1;
};
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
    $container.isotope({
      itemSelector: '.elementWrapper',
      getSortData: {
        symbol: function($elem) {
          return $elem.attr('data-symbol');
        }
      },
      sortBy: 'symbol'
    });
    if ((__indexOf.call(document, 'createTouch') >= 0)) {
      $container.delegate('.elementWrapper', 'ontouchup', function(e) {
        $(e.target).width(900);
        return $container.isotope('reLayout');
      });
    } else {
      $container.delegate('.elementWrapper', 'click', function(e) {
        var $elt, $wrapper;
        $wrapper = $(e.target);
        $elt = $wrapper.find('.element').first();
        if ($wrapper.width() === 450) {
          $wrapper.animate({
            width: 225,
            height: 225
          }, 100, '', function() {
            return $container.isotope('reLayout');
          });
          return $elt.animate({
            width: 225,
            height: 225
          });
        } else {
          $wrapper.animate({
            height: 450,
            width: 450
          }, 100, '', function() {
            return $container.isotope('reLayout');
          });
          return $elt.animate({
            width: 450,
            height: 450
          });
        }
      });
    }
    return addProjectElements(containerName, data.projects);
  };
};
addProjectElements = function(container, datas) {
  var newElements;
  newElements = [];
  _(datas).each(function(data) {
    return newElements.push(createProjectElement(data));
  });
  _(newElements).each(function(elt) {
    var $elt;
    $elt = $(elt);
    return $(container).isotope('insert', $elt);
  });
  return $('.element').each(function(i, elt) {
    var bc, bp, bs, mbs, name;
    name = $(elt).attr('data-name');
    console.log(name);
    switch (name) {
      case 'self':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'delicious':
        bp = "0px 75px";
        bc = "#0000ff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'duke':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'cmu':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'tis':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'akamai':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'cmu-admin':
        bp = "0px 0px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'iconomy':
        bp = "0px 0px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'kp-v3-logo':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'tantriccircus':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'menlopark2':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'icaruslogo':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'mandalabrotlogo':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'galactivision':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'tribalpixel-logo':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'flashmobber':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'bpcl':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      case 'tribalpixel':
        bp = "0px 75px";
        bc = "#fff";
        bs = '100%';
        mbs = '100%';
        break;
      default:
        bp = "0px 75px";
        bc = "#990000";
        bs = '100%';
        mbs = '100%';
    }
    return $(elt).css({
      'background-image': "url(../projectimages/" + name + "/page1.jpg)",
      'background-position': bp,
      'background-repeat': "no-repeat",
      'background-color': bc,
      'background-size': bs,
      '-moz-background-size': mbs
    });
  });
};
createProjectElement = function(data) {
  var attrs, classes, datas, datavars, desc, html, v;
  classes = [];
  datas = [];
  attrs = [];
  datavars = {
    name: data != null ? data['name'] : void 0,
    title: data != null ? data['title'] : void 0,
    output: data != null ? data['output'] : void 0,
    honors: data != null ? data['honors'] : void 0,
    organization: data != null ? data['organization'] : void 0,
    description: data != null ? data['description'][0] : void 0,
    links: data != null ? data['links'] : void 0,
    category: data != null ? data['category'] : void 0,
    subcategory: data != null ? data['sub-category'] : void 0,
    roles: data != null ? data['roles'] : void 0,
    date: data != null ? data['date'] : void 0,
    year: data != null ? data['year'] : void 0,
    location: data != null ? data['location'] : void 0,
    languages: data != null ? data['languages'] : void 0,
    tools: data != null ? data['tools'] : void 0,
    duration: data != null ? data['duration'] : void 0,
    tags: data != null ? data['tags'] : void 0
  };
  if (v = datavars.year) {
    classes.push("year_" + v);
  }
  if (v = datavars.category) {
    classes.push("cat_" + v);
  }
  if (v = datavars.subcategory) {
    classes.push("subcat_" + v);
  }
  desc = '';
  _(datavars != null ? datavars.description : void 0).each(function(val, key) {
    return desc += "" + key + " / " + val + " <p>";
  });
  classes.push('entry element', _(datavars).each(function(val, key) {
    return attrs.push("data-" + key + "=\"" + val + "\"");
  }));
  classes = classes.join(' ');
  attrs = attrs.join(' ');
  html = "<div class='elementWrapper'><div class=\"" + classes + "\" " + attrs + ">\n            </div><div class='infoWrapper'><h1>" + datavars.title + "</h1></div></div>\n\n";
  return html;
};