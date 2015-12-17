# Description:
#   DJ
#
# Commands:
#   None
#
# Author:
#   m-nakada

fs = require 'fs'
holiday = require 'holiday-jp'
cronJob = require('cron').CronJob
SONGS = []
SONGS_FOLK = []
SONGS_LIVE = []
SONGS_MIX = []
SONGS_VA = []
SONGS_SW = []

fs.readFile './scripts/contents/songs.txt', 'utf8', (err, text) ->
  SONGS = text.split "\n"

fs.readFile './scripts/contents/folk.txt', 'utf8', (err, text) ->
  SONGS_FOLK = text.split "\n"

fs.readFile './scripts/contents/live.txt', 'utf8', (err, text) ->
  SONGS_LIVE = text.split "\n"

fs.readFile './scripts/contents/mix.txt', 'utf8', (err, text) ->
  SONGS_MIX = text.split "\n"

fs.readFile './scripts/contents/songs_va.txt', 'utf8', (err, text) ->
  SONGS_VA = text.split "\n"

sendSong = (robot, songs) ->
fs.readFile './scripts/contents/starwars.txt', 'utf8', (err, text) ->
  SONGS_SW = text.split "\n"

  unless process.env.HUBOT_SLACK_ROOM
    robot.logger.error "Missing HUBOT_SLACK_ROOM. `heroku config:set HUBOT_SLACK_ROOM=room name`"
    return

  return if holiday.isHoliday(new Date())
  room = {room: process.env.HUBOT_SLACK_ROOM}
  song = songs[ Math.floor(Math.random() * songs.length) ]
  robot.send room, song

module.exports = (robot) ->
  new cronJob
    cronTime: "0 */20 9-20 * * 1"
    onTick: ->
      sendSong robot, SONGS_FOLK
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 */20 9-20 * * 2"
    onTick: ->
      sendSong robot, SONGS
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 */20 9-20 * * 3"
    onTick: ->
      sendSong robot, SONGS_VA
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 0,30 9-20 * * 4"
    onTick: ->
      sendSong robot, SONGS_LIVE
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 0 9-20 * * 5"
    onTick: ->
      sendSong robot, SONGS_MIX
      return
    start: true
    timeZone: "Asia/Tokyo"
