
express = require 'express'
res = express.response

res.jerror = (code, message) ->
  if code instanceof Error
    message = code.message
    code = code.name
  this.send({status: 'error', code: code, message: message})
    
res.jsend = (result) ->
  this.send({status: 'success', data: result})


