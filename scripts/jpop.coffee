# Description:
#   J-POP Job with Cron
#
# Commands:
#   None
#
# Author:
#   m-nakada

holiday = require 'holiday-jp'
cronJob = require('cron').CronJob
ROOM_GENERAL = 'general'

SONGS = [
  "https://www.youtube.com/watch?v=lfETQNfBAD4", # cero / Summer Soul【OFFICIAL MUSIC VIDEO】
  "https://www.youtube.com/watch?v=c_SLGBJgDNE", # cero / Orphans【OFFICIAL MUSIC VIDEO】
  "https://www.youtube.com/watch?v=9W8mmhbXcII", # (((さらうんど))) / Siren Syrup (Audio Video)
  "https://www.youtube.com/watch?v=k474iuH0xr0", # (((さらうんど))) / きみは New Age (Music Video)
  "https://www.youtube.com/watch?v=aWaECOuSwOY", # ミツメ / Dico
  "https://www.youtube.com/watch?v=_gQ_SBXPk3s", # ミツメ / 煙突
  "https://www.youtube.com/watch?v=OzodjmJviVU", # Yogee New Waves / CLIMAX NIGHT (New Version)
  "https://www.youtube.com/watch?v=cnbeQ0YC7d0", # Yogee New Waves / Goodbye
  "https://www.youtube.com/watch?v=iZDJ7X3Q8UA", # Yogee New Waves / Hello Ethiopia (PV)
  "https://www.youtube.com/watch?v=CcmLLENh4jc", # SPECIAL OTHERS ACOUSTIC / LIGHT 【MUSIC VIDEO】
  "https://www.youtube.com/watch?v=PGOwu8fICjs", # 中山うり / 月曜日の夜に
  "https://www.youtube.com/watch?v=kGtOJaHpQAY", # 中山うり / 回転木馬に僕と猫
  "https://www.youtube.com/watch?v=ejq3HoHCIX8", # 旅をしませんか　要一起去旅行嗎　～台湾/平渓線・日本/江ノ電編～
  "https://soundcloud.com/headzpromo/kedama_sample_4", # 毛玉 - 新しい生活 from 1st album "新しい生活"
  "https://www.youtube.com/watch?v=OlqC1BBVk70", # Spangle call Lilli line 「azure」 (Official Music Video)
  "https://www.youtube.com/watch?v=qL8h-yhhRJE", # Spangle call Lilli line - E
  "https://soundcloud.com/shippai/the-sea",      # 失敗しない生き方 - 海を見に行こうよ
  "https://www.youtube.com/watch?v=wZ9sVKXgzbM", # 失敗しない生き方「クックブック」 at 三鷹おんがくのじかん
  "https://www.youtube.com/watch?v=qzmgAsjcLiQ", # まとめを読まないままにして　空気公団
  "https://www.youtube.com/watch?v=m5UiOcrixLk", # 阿部芙蓉美(Fuyumi Abe)「革命前夜」/ music video
  "https://vimeo.com/111519406",                 # 森は生きている - 煙夜の夢
]

sendSong = (robot, room_name, songs) ->
  unless process.env.HUBOT_ROOM_JPOP
    robot.logger.error "Missing HUBOT_ROOM_JPOP. `heroku config:set HUBOT_ROOM_JPOP=room name`"
    return

  return if holiday.isHoliday(new Date())
  room    = {room: process.env.HUBOT_ROOM_JPOP}
  song    = songs[ Math.floor(Math.random() * songs.length) ]
  robot.send room, song

module.exports = (robot) ->
  new cronJob
    # cronTime: "* * 10-19 * * 1-5"
    cronTime: "*/10 * 23 * * *"
    onTick: ->
      sendSong robot, ROOM_GENERAL, SONGS
      return
    start: true
    timeZone: "Asia/Tokyo"
