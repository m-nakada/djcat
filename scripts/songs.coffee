# Description:
#   DJ
#
# Commands:
#   None
#
# Author:
#   m-nakada

holiday = require 'holiday-jp'
cronJob = require('cron').CronJob

SONGS_JPOP = [
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

SONGS_INDIES = [
  "https://www.youtube.com/watch?v=8ty_g5U9-co", # CHVRCHES - The Mother We Share
  "https://www.youtube.com/watch?v=tpprOGsLWUo", # Elvis Costello - Pump it up
  "https://www.youtube.com/watch?v=i7qR1aOKgQ4", # Toro y Moi - Run Baby Run
  "https://www.youtube.com/watch?v=QlXiGj85rOA", # Angus & Julia Stone - Get Home
  "https://www.youtube.com/watch?v=p6xqb-8F4nQ", # Julio y Agosto - Correr para atras
  "https://www.youtube.com/watch?v=gZd-L1-Hi-4", # Ásgeir - Torrent (Official video)
  "https://www.youtube.com/watch?v=LudEZb8-S2c", # Generationals - Black Lemon (Official Lyric Video)
  "https://www.youtube.com/watch?v=W-ZT2Hgonwc", # Travis - Where You Stand
  "https://www.youtube.com/watch?v=UuihJInaeN4", # The 1975 - The City
  "https://www.youtube.com/watch?v=ULavCZGz0mY", # Kodaline - Brand New Day
  "https://www.youtube.com/watch?v=UYHjjk_9-zk", # Kowalski : Outdoors (Music Video)
  "https://www.youtube.com/watch?v=50iOSG8aZ14", # M83 - Year One, One UFO
  "https://www.youtube.com/watch?v=sjxYLFWxR6E", # The Pastels - Check My Heart (Official Video)
  "https://www.youtube.com/watch?v=1XuUIuGy18g", # The Spandettes - Sweet & Saccharine (Acoustic Live Version)
  "https://www.youtube.com/watch?v=2b1GgT07aes", # Vampire Weekend - Unbelievers (Live on SNL)
  "https://www.youtube.com/watch?v=Py2KOyrtq6o", # Yo La Tengo - Ohm (OFFICIAL VIDEO)
  "https://www.youtube.com/watch?v=gI2eO_mNM88", # The xx - VCR
  "https://www.youtube.com/watch?v=qpN5jX3wqq4", # Stars | Ageless Beauty (Official Video)
  "https://www.youtube.com/watch?v=KbPWi1gshzI", # Sigur Ros - Hoppipolla - HD Live from Heima
  "https://www.youtube.com/watch?v=uxTH8GZ4PC4", # Death Cab for Cutie - No Room In Frame
  "https://www.youtube.com/watch?v=sEwM6ERq0gc", # HAIM - Forever (Official Music Video)
  "https://www.youtube.com/watch?v=EoCulvhm8iY", # Jamaica - Two On Two
  "https://www.youtube.com/watch?v=VgaRm9j8SQI", # SOAK - Sea Creatures
  "https://www.youtube.com/watch?v=yt_juevz9Qg", # SOAK - B a noBody
  "https://www.youtube.com/watch?v=WjNssEVlB6M", # Jamie xx - Gosh (Official Music Video)
  "https://www.youtube.com/watch?v=TP9luRtEqjc", # Jamie xx - Loud Places (ft Romy)
  "https://www.youtube.com/watch?v=TD_Q9CxXTo4", # Wolf Alice - Bros
  "https://www.youtube.com/watch?v=f4dZbJHT7_4", # Volcano Choir - "Comrade"
  "https://www.youtube.com/watch?v=JI-G5Cd6OeU", # Stereolab - Wow and Flutter
]

SONGS_POST_CLASSICAL = [
  "https://www.youtube.com/watch?v=BeeHtJQ2cWw", # Haruka Nakamura - 夕べの祈り
  "https://www.youtube.com/watch?v=p-ca1ocriv0", # Ludovico Einaudi "Walk" (Official Video)
  "https://www.youtube.com/watch?v=G1WLy2Bm4Gw", # Ludovico Einaudi - Rose
  "https://www.youtube.com/watch?v=CB2wPf8ffIQ", # Balmorhea - Baleen Morning
  "https://www.youtube.com/watch?v=RSoXgL8dQ5g", # Balmorhea - Pilgrim
  "https://www.youtube.com/watch?v=y8I0-b1mzwA", # Dakota Suite - Hands Swollen With Grace
  "https://www.youtube.com/watch?v=r-Qu7WWE2VY", # Nils Frahm - You
  "https://www.youtube.com/watch?v=mYIfiQlfaas", # Ólafur Arnalds - Ljósið (Official Music Video)
  "https://www.youtube.com/watch?v=kiZBWhWqE84", # ten to sen - scene-2
  "https://www.youtube.com/watch?v=YmWH1hL5cd8", # Light dance / Akira Kosemura
  "https://www.youtube.com/watch?v=UQ4dAUNU2yg", # Quentin Sirjacq - memory 2
]

SONGS_SOUL = [
  "https://www.youtube.com/watch?v=_I2nk1qs2hQ", # Jazmine Sullivan - Good Enough
  "https://www.youtube.com/watch?v=X63EkrpHywE", # macy gray-what i gotta do
  "https://www.youtube.com/watch?v=MDv74VPHW1Q", # José James - Come To My Door
  "https://www.youtube.com/watch?v=bMJkddvJ4L4", # Jessie Ware - Wildest Moments
  "https://www.youtube.com/watch?v=Wo2QB2kqG_w", # Jessie Ware - You & I (Forever)
  "https://www.youtube.com/watch?v=Vk-9tu5V2Hw", # Power - Groovin'
  "https://www.youtube.com/watch?v=ZCkzeD_1-qA", # G C Cameron - Give Me Your Love
  "https://www.youtube.com/watch?v=JacdLT4QdrQ", # More Today Than Yesterday - Patti Austin
  "https://www.youtube.com/watch?v=gJeWaBbowsY", # Faith Evans - Dumb
  "https://www.youtube.com/watch?v=RehgZXGEsxQ", # Daley - Game Over / Lyrics
  "https://www.youtube.com/watch?v=Y6jC9bWjMHU", # Jill-Scott - Lovely Day <= No Link
  "https://www.youtube.com/watch?v=by8-4UKwcKU", # Vince Andrews Love, Oh Love
  "https://www.youtube.com/watch?v=OiwiNA3-GyA", # SOUL GENERATION-ray of hope
  "https://www.youtube.com/watch?v=EJY5se7G-7Q", # Sabrina Starke - Just The Two Of Us (Official Audio)
  "https://www.youtube.com/watch?v=9HvpIgHBSdo", # Gregory Porter - Be Good (Lion's Song) Official Video
  "https://www.youtube.com/watch?v=3ZP3UQ0ESLc", # The Spinners - It's A Shame (Slayd5000)
  "https://www.youtube.com/watch?v=ZB4IPXHElds", # The Chi Lites When Temptation Comes
  "https://www.youtube.com/watch?v=tjE-sbU7Wwc", # The Brand New Heavies - One More For The Road
  "https://www.youtube.com/watch?v=SkIwZsqMtUs", # Saskwatch - Only One
  "https://www.youtube.com/watch?v=HH3ruuml-R4", # Stephen Stills - Love The One You're With
  "https://www.youtube.com/watch?v=KOTOnFKKx7M", # Clean Up Woman - Betty Wright (1971)
  "https://www.youtube.com/watch?v=lbLMABnJ7Vc", # Brigitte - A bouche que veux-tu
  "https://www.youtube.com/watch?v=SR0Mx0OazBU", # Tété - La bande son de ta vie (Clip Officiel)
  "https://www.youtube.com/watch?v=r5eDYt1dIsM", # António Zambujo - "Valsa do Vai Não Vás"
  "https://www.youtube.com/watch?v=bjjc59FgUpg", # Cinematic Orchestra - To Build A Home (feat. Patrick Watson)
]

sendSong = (robot, songs) ->
  unless process.env.HUBOT_ROOM_JPOP
    robot.logger.error "Missing HUBOT_ROOM_JPOP. `heroku config:set HUBOT_ROOM_JPOP=room name`"
    return

  return if holiday.isHoliday(new Date())
  room    = {room: process.env.HUBOT_ROOM_JPOP}
  song    = songs[ Math.floor(Math.random() * songs.length) ]
  robot.send room, song

module.exports = (robot) ->
  # J-POP
  new cronJob
    cronTime: "* * 10-19 * * 1,5"
    onTick: ->
      sendSong robot, SONGS_JPOP
      return
    start: true
    timeZone: "Asia/Tokyo"

# Indies Rock
new cronJob
  cronTime: "* * 10-19 * * 2"
  onTick: ->
    sendSong robot, SONGS_JPOP
    return
  start: true
  timeZone: "Asia/Tokyo"

# Post Classical
new cronJob
  cronTime: "* * 10-19 * * 3"
  onTick: ->
    sendSong robot, SONGS_POST_CLASSICAL
    return
  start: true
  timeZone: "Asia/Tokyo"

# Soul
new cronJob
  cronTime: "* * 10-19 * * 4"
  onTick: ->
    sendSong robot, SONGS_SOUL
    return
  start: true
  timeZone: "Asia/Tokyo"
