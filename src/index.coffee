Emblem = require 'emblem'
sysPath = require 'path'

module.exports = class EmblemCompiler
  brunchPlugin: yes
  type: 'template'
  extension: 'emblem'
  pattern: /\.(?:emblem)$/

  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
    try
      content = Emblem.precompile require('handlebars'), data
      result = "module.exports = Handlebars.template(#{content});"
    catch err
      error = err
    finally
      callback error, result

  include: [
    (sysPath.join __dirname, '..', 'vendor',
      'handlebars.runtime.js')
  ]
