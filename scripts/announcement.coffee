# Description:
#   Announcement
#
# Commands:
#   None
#
# Author:
#   m-nakada

fs = require 'fs'
holiday = require 'holiday-jp'
cronJob = require('cron').CronJob

MESSAGES = [
  ':loudspeaker: 今日はライブセッションを中心にお届けします',
  ':loudspeaker: 今日は Mix 音源を中心にお届けします',
  ':loudspeaker: 今日は Halloween にちなんだ曲を（こじつけ感たっぷりに）お届けします :jack_o_lantern: :smiling_imp: :ghost:',
  ':loudspeaker: 今日は Star Wars にちなんだ曲をお届けします :yoda: '
]

sendMessage = (robot, message) ->
  unless process.env.HUBOT_SLACK_ROOM
    robot.logger.error "Missing HUBOT_SLACK_ROOM. `heroku config:set HUBOT_SLACK_ROOM=room name`"
    return

  return if holiday.isHoliday(new Date())
  room = {room: process.env.HUBOT_SLACK_ROOM}
  robot.send room, message

module.exports = (robot) ->
  new cronJob
    cronTime: "0 0 9 * * 4"
    onTick: ->
      sendMessage robot, MESSAGES[0]
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 0 9 * * 5"
    onTick: ->
      sendMessage robot, MESSAGES[3]
      return
    start: true
    timeZone: "Asia/Tokyo"
