## emblem-brunch

Adds [Emblem](http://emblemjs.com/) support to [brunch](http://brunch.io).

## Installation

Add `"emblem-brunch": "x.y.z"` to `package.json` of your brunch app.

Pick a plugin version that corresponds to your minor (y) brunch version.

If you want to use git version of plugin, add
`"emblem-brunch": "git+https://github.com/machty/emblem-brunch.git"`.

Download [Emblem](http://emblemjs.com) and [Handlebars](http://handlebarsjs.com).

## Usage

```coffeescript
exports.config =
  files:
    # ...
    templates:
      precompile: true
      root: 'templates'
      defaultExtension: 'emblem'
      joinTo: 'javascripts/app.js'
      paths:
        # If you don't specify jquery and ember there,
        # raw (non-Emberized) Handlebars templates will be compiled.
        jquery: 'vendor/scripts/jquery-1.9.0.min.js'
        ember: 'vendor/scripts/ember-latest.js'
        handlebars: 'handlebars.js'
        emblem: 'emblem.js'
```

### With Ember

Require templates in your main script.

```coffeescript
require 'templates/application'
require 'templates/index'
```

This will configure `Ember.TEMPLATES` automatically.

### Without Ember

Require templates where you need them.

```coffeescript
index_template = require 'templates/index'
```

## Credits

Based on [handlebars-brunch](https://github.com/brunch/handlebars-brunch) and
[ember-precompiler-brunch](https://github.com/chrixian/ember-precompiler-brunch).
