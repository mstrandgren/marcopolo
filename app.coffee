connect = require('connect')
app = connect()

app.use (request, response) ->
	console.log 'Got http request'
	response.statusCode = 200
	response.end 'Polo!'

httpServer = app.listen(8000)

console.log 'Started http server on port 8000'



WebSocketServer = require('ws').Server

wss = new WebSocketServer({server: httpServer})


wss.on 'connection', (ws) ->
	console.log 'Connection!'
	ws.on 'message',  (message) ->
		ws.send 'Polo!'
		console.log "Sending polo"


