# Description:
#   "Travis CI alert hook"
#
# Configuration:
#   None
#
# Commands:
#   POST /hubot/travis [data]
#
# Authors:
#   ajacksified

querystring = require('querystring')
querystring = require('querystring')

module.exports = (robot) ->
  robot.router.post "/hubot/travis", (req, res) ->
    query = querystring.parse url.parse(req.url).query
    res.end JSON.stringify {
       received: true #some client have problems with and empty response
    }

    user = {}
    user.room = query.room if query.room
    user.type = query.type if query.type

    data = JSON.parse req.body.payload

    message = "
    -----------------\n
    #{data.status_message.toUpperCase()} <#{data.repository.name}> [#{data.commit}]\n
    Compare: #{data.compare_url}\n
    Committed by #{data.committer_name} at #{data.committed_at}\n
    -----------------"

    user = {}
    user.room = query.room if query.room
    user.type = query.type if query.type

    robot.send(user, message)

    res.end "Said #{query.message}"
