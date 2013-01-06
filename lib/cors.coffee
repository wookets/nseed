
module.exports = (req, res, next) ->
  res.header("Access-Control-Allow-Origin", "*")
  res.header("Access-Control-Allow-Methods", "PUT, GET, POST, DELETE, OPTIONS")
  res.header("Access-Control-Allow-Headers", "X-Requested-With")
  next()
