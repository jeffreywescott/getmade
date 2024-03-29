newrelic = require("newrelic") if process.env.NODE_ENV is "production"
path = require("path")
express = require("express")

port = process.env.PORT || 10080
development = process.env.NODE_ENV isnt "production"


api = express().get("/users/:username", (req, res) ->
  username = req.params.username
  res.send
    username: username
    name: username.charAt(0).toUpperCase() + username.slice(1)
)

app = express()

# in development, serve-up the bundle.js directly so we get source maps
if development
  browserify  = require("connect-browserify")
  nodejsx     = require("node-cjsx").transform()
  app.get "/js/bundle.js", browserify(
    entry: path.join(__dirname, "client/app.coffee")
    debug: true
    watch: true
    transforms: ["coffee-reactify"]
    extensions: [".cjsx", ".coffee", ".js", ".json"]
  )

app
  .use("/", express.static(path.join(__dirname, "public")))
  .use("/api", api)
  .listen port, ->
    console.log "Listening on port #{port}"
