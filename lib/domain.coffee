###
The point of this file is the following...
try / catch blocks don't work in async programming, because async code runs across different stacks
node.js 0.8 introduced 'domains' which will bind a chunk of async code to a specific domain and thus allow you access things from that stack
notably the request and response object

So this is an express.js middleware which will catch an uncaught exception on the server and do the proper thing which is to 
propegate it back to the user (client browser) to let them know 'something went wrong'

###

domain = require 'domain'
createDomain = domain.create # add error handling for our routes by attaching a domain

module.exports = (req, res, next) ->
  domain = createDomain()
  domain.on 'error', (err) -> # catch an error from teh route in the domain
    next(err) # we just want to let another piece of express middleware handle errors
    #domain.dispose() # dont let the domain hang around in memory, we create a new domain on each request, so this is ok to kick it to the curb 
  domain.enter() # enter the domain
  next() # run the route
  