sysPath = require 'path'
fs = require 'fs'
jsdom = require 'jsdom'

module.exports = class EmblemCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'emblem'
  pattern: /\.(?:emblem)$/

  setup: (@config) ->
    @window = jsdom.jsdom().createWindow()
    paths = @config.files.templates.paths
    if paths.jquery
      @window.run fs.readFileSync paths.jquery, 'utf8'
    @window.run fs.readFileSync paths.handlebars, 'utf8'
    @window.run fs.readFileSync paths.emblem, 'utf8'
    if paths.ember
      @window.run fs.readFileSync paths.ember, 'utf8'
      @ember = true
    else
      @ember = false

  constructor: (@config) ->
    if @config.files.templates?.paths?
      @setup(@config)
    null

  compile: (data, path, callback) ->
    if not @window?
      return callback "files.templates.paths must be set in your config", {}
    try
      if @ember
        path = path
          .replace(new RegExp('\\\\', 'g'), '/')
          .replace(/^app\//, '')
          .replace(/^templates\//, '')
          .replace(/\.\w+$/, '')
        content = @window.Emblem.precompile @window.Ember.Handlebars, data
        result = "Ember.TEMPLATES[#{JSON.stringify(path)}] = Ember.Handlebars.template(#{content});module.exports = module.id;"
      else
        content = @window.Emblem.precompile @window.Handlebars, data
        result = "module.exports = Handlebars.template(#{content});"
    catch err
      error = err
    finally
      callback error, result
