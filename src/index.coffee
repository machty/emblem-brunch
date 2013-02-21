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
    @window.run fs.readFileSync @config.files.templates.paths.jquery, 'utf8'
    @window.run fs.readFileSync @config.files.templates.paths.ember, 'utf8'
    @window.run fs.readFileSync @config.files.templates.paths.handlebars, 'utf8'
    @window.run fs.readFileSync @config.files.templates.paths.emblem, 'utf8'

  constructor: (@config) ->
    if @config.files.templates?.paths?
      @setup(@config)
    null

  compile: (data, path, callback) ->
    if not @window?
      return callback "files.templates.paths must be set in your config", {}
    try
      content = @window.Emblem.precompile @window.Ember.Handlebars, data
      path = path
        .replace(new RegExp('\\\\', 'g'), '/')
        .replace(/^app\//, '')
        .replace(/^templates\//, '')
        .replace(/\.\w+$/, '')
      result = "Ember.TEMPLATES[#{JSON.stringify(path)}] = Ember.Handlebars.template(#{content});module.exports = module.id;"
    catch err
      error = err
    finally
      callback error, result
