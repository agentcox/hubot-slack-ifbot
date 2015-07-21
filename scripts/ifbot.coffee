sleep = (ms) ->
  start = new Date().getTime()
  continue while new Date().getTime() - start < ms

module.exports = (robot) ->

   robot.error (err, res) ->
     robot.logger.error "DOES NOT COMPUTE"
  
     if res?
       res.reply "DOES NOT COMPUTE"
  
   robot.respond /(.*)/i, (response) ->
     mycommand = response.match[1]
#     response.send "Doing #{mycommand}"
     data = command: mycommand
     stringy = JSON.stringify data
#     response.send "#{stringy}"
     robot.http("http://localhost:8081")
     .header('Content-Type', 'application/json')
     .post(stringy) (err, res, body) ->
#       response.send "Command #{mycommand} done!"
#
#	do we need to delay?
#
       sleep 1000
       robot.http("http://localhost:8081")
       .header('Content-Type', 'application/json')
       .get() (err, res, body) ->
         data = JSON.parse body
         response.send "#{data.message}"