http = require('http')

# Proxywrap is used to work with AWS ELB's ProxyProtocol, which is needed to make websockets work
proxiedHttp = require('proxywrap').proxy(http, strict: false)
connect = require('connect')
app = connect()

app.use (request, response) ->
	console.log 'Got http request'
	response.statusCode = 200
	response.end 'Polo!!'

httpServer = proxiedHttp.createServer(app).listen(80)

console.log 'Started http server on port 80'

WebSocketServer = require('ws').Server

wss = new WebSocketServer({server: httpServer})


wss.on 'connection', (ws) ->
	console.log 'Connection!'
	ws.on 'message',  (message) ->
		ws.send 'Polo!'
		console.log "Sending polo"


