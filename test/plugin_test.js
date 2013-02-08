Handlebars = require('handlebars')
Emblem = require('emblem')

describe('Plugin', function() {
  var plugin;

  beforeEach(function() {
    plugin = new Plugin({});
  });

  it('should be an object', function() {
    expect(plugin).to.be.ok;
  });

  it('should has #compile method', function() {
    expect(plugin.compile).to.be.an.instanceof(Function);
  });

  it('should compile and produce valid result', function(done) {
    var content = "p = fun";
    var expected = '<p>naw</p>';

    plugin.compile(content, 'template.handlebars', function(error, data) {
      expect(error).not.to.be.ok;
      expect(eval(data)({fun: 'naw'})).to.equal(expected);
      done();
    });
  });
});
