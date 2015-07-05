

# aws elb create-load-balancer-policy --profile private --load-balancer-name marco-polo-elb --policy-name websocket-ProxyProtocol-policy --policy-type-name ProxyProtocolPolicyType --policy-attributes AttributeName=ProxyProtocol,AttributeValue=true
# aws elb set-load-balancer-policies-for-backend-server --profile private --load-balancer-name marco-polo-elb --instance-port 80 --policy-names websocket-ProxyProtocol-policy

http = require('http')
proxiedHttp = require('proxywrap').proxy(http, strict: false)
connect = require('connect')
app = connect()

app.use (request, response) ->
	console.log 'Got http request'
	response.statusCode = 200
	response.end 'Polo!'

httpServer = proxiedHttp.createServer(app).listen(8000)

console.log 'Started http server on port 8000'



WebSocketServer = require('ws').Server

wss = new WebSocketServer({server: httpServer})


wss.on 'connection', (ws) ->
	console.log 'Connection!'
	ws.on 'message',  (message) ->
		ws.send 'Polo!'
		console.log "Sending polo"


