class Bootstrap

  _fs = require 'fs'
  _exec = require 'sync-exec'
  _path = require 'path'
  _ncp = require 'ncp'
  _cheerio = require 'cheerio'
  _mkdirp = require 'mkdirp'
  _turndownService = require 'turndown'
  _turndownPluginGfm = require 'joplin-turndown-plugin-gfm'
  _confluenceTurndownPluginGfm = require 'turndown-plugin-confluence-to-gfm'

  Utils = require './Utils'
  Logger = require './Logger'
  Formatter = require './Formatter'
  App = require './App'
  PageFactory = require './PageFactory'


  ###*
  # @param {string} pathResource Directory with HTML files or one file. Can be nested.
  # @param {string|void} pathResult Directory where MD files will be generated to. Current dir will be used if none given.
  ###
  run: (pathResource, pathResult = '') ->
    pathResource = _path.resolve pathResource
    pathResult = _path.resolve pathResult

    logger = new Logger Logger.INFO
    utils = new Utils _fs, _path, _ncp, logger
    formatter = new Formatter _cheerio, utils, logger
    pageFactory = new PageFactory formatter, utils
    app = new App _fs, _exec, _path, _mkdirp, utils, formatter, pageFactory, logger, _turndownService, _turndownPluginGfm, _confluenceTurndownPluginGfm


    console.log('\n--------------------')
    logger.info 'Using source: ' + pathResource
    logger.info 'Using destination: ' + pathResult
    console.log('--------------------\n')

    app.convert pathResource, pathResult


module.exports = Bootstrap