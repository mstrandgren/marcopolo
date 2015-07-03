WebSocketServer = require('ws').Server

wss = new WebSocketServer(port: 8080)

console.log "Started websocket server on port 8080"

wss.on 'connection', (ws) ->
	console.log 'Connection!'
	ws.on 'message',  (message) ->
		ws.send 'Polo!'
		console.log "Sending polo"


connect = require('connect')
app = connect()

app.use (request, response) ->
	console.log 'Got http request'
	response.statusCode = 200
	response.end 'Polo!'

app.listen(8000)

console.log 'Started http server on port 8000'
