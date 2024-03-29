
express = require 'express'
module.exports = app = express() # module.exports allows this app to work in a cluster with other apps

jsend = require __dirname + '/lib/jsend' # attach jsend to express response object
cors = require __dirname + '/lib/cors' # allow cross domain json requests
domain = require __dirname + '/lib/domain' # setup a domain to catch exceptions

app.use(domain) # for some reason, we need to add domain threading here

app.configure () ->
  app.use(express.logger({format: 'tiny'})) # log express routing things (includes profiling)
  app.use(express.compress()) # gzip support
  app.use(express.bodyParser()) # express will parse http POST, etc for us
  app.use(express.cookieParser()) # 'souper saucey secrets'
  app.use(express.session({secret: "nseedy nodeappy"})) # let express maintain session thread tracking for us
  app.use(cors) # enable cross domain requests
  app.use(app.router)
  app.use(express.static(__dirname + '/public')) # if a static file is requested (i.e. error.html) look in this folder
  app.use(express.errorHandler({dumpExceptions: true, showStack: true}))

require __dirname + '/routes' # register routes with express

app.listen(process.env.PORT or 3000) # start server
console.log "Express server listening on port #{process.env.PORT or 3000} in #{app.settings.env} mode"