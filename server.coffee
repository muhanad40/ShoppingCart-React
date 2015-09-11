express = require('express')
path = require("path")
app = express()

app.use(express.static('public'))

app.get '*', (req, res) ->
  res.sendFile(path.join(__dirname, "index.html"))
  return

server = app.listen(3000, "127.0.0.1", ->
  host = server.address().address
  port = server.address().port
  console.log 'Example app listening at http://%s:%s', host, port
  return
)
