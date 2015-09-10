http = require('http')

# Proxywrap is used to work with AWS ELB's ProxyProtocol, which is needed to make websockets work
proxiedHttp = require('proxywrap').proxy(http, strict: false)
connect = require('connect')

AWS = require('aws-sdk')

try
	awsConfig = require('./eaws.json')

	AWS.config =
		accessKeyId: awsConfig.key
		secretAccessKey: awsConfig.secret
		region: awsConfig.region
		sslEnabled: true
		# logger: process.stdout
catch e
	console.log "No aws.json, assuming we're in prod"

s3 = new AWS.S3()

app = connect()

app.use (request, response) ->
	console.log 'Got http request'
	s3.getObject {Bucket: 'mf-stack', Key: 'environment.json'}, (err, data) ->
		response.statusCode = 200
		if err?
			return response.end err + '\n' + err.stack

		response.end data.Body



httpServer = proxiedHttp.createServer(app).listen(8000)

console.log 'Started http server on port 8000'

WebSocketServer = require('ws').Server

wss = new WebSocketServer({server: httpServer})


wss.on 'connection', (ws) ->
	console.log 'Connection!'
	ws.on 'message',  (message) ->
		ws.send 'Polo!'
		console.log "Sending polo"


