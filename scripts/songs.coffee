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
offday  = require './offday'
cronJob = require('cron').CronJob
SONGS = []
SONGS_FOLK = []
SONGS_LIVE = []
SONGS_MIX = []
SONGS_VA = []
SONGS_SW = []
song_index = 0

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

fs.readFile './scripts/contents/starwars.txt', 'utf8', (err, text) ->
  SONGS_SW = text.split "\n"

nextSong = (songs, random) ->
  if random
    song = songs[ Math.floor(Math.random() * songs.length) ]
  else
    song_index = 0 unless songs.length > song_index
    console.log song_index
    song = songs[song_index++]
  return song

sendSong = (robot, songs, random) ->
  unless process.env.HUBOT_SLACK_ROOM
    robot.logger.error "Missing HUBOT_SLACK_ROOM. `heroku config:set HUBOT_SLACK_ROOM=room name`"
    return

  date = new Date()
  return if offday.isOffday(date)
  return if holiday.isHoliday(date)

  room = {room: process.env.HUBOT_SLACK_ROOM}
  song = nextSong(songs, random)
  robot.send room, song

module.exports = (robot) ->
  new cronJob
    cronTime: "0 */20 9-20 * * 1"
    onTick: ->
      sendSong robot, SONGS_FOLK, true
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 */20 9-20 * * 2"
    onTick: ->
      sendSong robot, SONGS, true
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 */20 9-20 * * 3"
    onTick: ->
      sendSong robot, SONGS_VA, true
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 0,30 9-20 * * 4"
    onTick: ->
      sendSong robot, SONGS_LIVE, true
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
