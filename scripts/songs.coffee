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
SONGS_MIX = []
SONGS_VA = []
SONGS_FOLK = []

fs.readFile './scripts/contents/mix.txt', 'utf8', (err, text) ->
  SONGS_MIX = text.split "\n"

fs.readFile './scripts/contents/songs.txt', 'utf8', (err, text) ->
  SONGS_VA = text.split "\n"

fs.readFile './scripts/contents/folk.txt', 'utf8', (err, text) ->
  SONGS_FOLK = text.split "\n"

SONGS = [
  "https://www.youtube.com/watch?v=lfETQNfBAD4", # cero / Summer Soul【OFFICIAL MUSIC VIDEO】
  "https://www.youtube.com/watch?v=c_SLGBJgDNE", # cero / Orphans【OFFICIAL MUSIC VIDEO】
  "https://www.youtube.com/watch?v=9W8mmhbXcII", # (((さらうんど))) / Siren Syrup (Audio Video)
  "https://www.youtube.com/watch?v=k474iuH0xr0", # (((さらうんど))) / きみは New Age (Music Video)
  "https://www.youtube.com/watch?v=aWaECOuSwOY", # ミツメ / Dico
  "https://www.youtube.com/watch?v=p9ZKu1y6Jmg", # ミツメ / 停滞夜
  "https://www.youtube.com/watch?v=_gQ_SBXPk3s", # ミツメ / 煙突
  "https://www.youtube.com/watch?v=OzodjmJviVU", # Yogee New Waves / CLIMAX NIGHT (New Version)
  "https://www.youtube.com/watch?v=cnbeQ0YC7d0", # Yogee New Waves / Goodbye
  "https://www.youtube.com/watch?v=iZDJ7X3Q8UA", # Yogee New Waves / Hello Ethiopia (PV)
  "https://www.youtube.com/watch?v=CcmLLENh4jc", # SPECIAL OTHERS ACOUSTIC / LIGHT 【MUSIC VIDEO】
  "https://www.youtube.com/watch?v=PGOwu8fICjs", # 中山うり / 月曜日の夜に
  "https://www.youtube.com/watch?v=kGtOJaHpQAY", # 中山うり / 回転木馬に僕と猫
  "https://soundcloud.com/headzpromo/kedama_sample_4", # 毛玉 / 新しい生活 from 1st album "新しい生活"
  "https://www.youtube.com/watch?v=OlqC1BBVk70", # Spangle call Lilli line / azure  (Official Music Video)
  "https://www.youtube.com/watch?v=qL8h-yhhRJE", # Spangle call Lilli line / E
  "https://www.youtube.com/watch?v=h2FxhiY7qGg", # Spangle call Lilli line / feel uneasy feat. moto kawabe from mitsume (Official Music Video)
  "https://soundcloud.com/shippai/the-sea",      # 失敗しない生き方 / 海を見に行こうよ
  "https://www.youtube.com/watch?v=wZ9sVKXgzbM", # 失敗しない生き方 / クックブック  at 三鷹おんがくのじかん
  "https://www.youtube.com/watch?v=qzmgAsjcLiQ", # 空気公団 / まとめを読まないままにして
  "https://www.youtube.com/watch?v=ejq3HoHCIX8", # 空気公団 / 旅をしませんか　要一起去旅行嗎　～台湾/平渓線・日本/江ノ電編～
  "https://www.youtube.com/watch?v=m5UiOcrixLk", # 阿部芙蓉美 / 革命前夜
  "https://vimeo.com/111519406",                 # 森は生きている / 煙夜の夢
  "https://www.youtube.com/watch?v=WuS80BsFjr4", # Alfred Beach Sandal / モノポリー
  "https://www.youtube.com/watch?v=P_Oi4GMkWkU", # RF / Right here
  "https://www.youtube.com/watch?v=XRvrsLDrjEk", # RF / I'll still love you (King James Version)
  "https://www.youtube.com/watch?v=ClAUw3t4lAA", # RF / High & dry (Radiohead cover)
  "https://www.youtube.com/watch?v=bcBY4zNEcUk", # RF / You gotta be (Des'ree cover)
  "https://www.youtube.com/watch?v=ij_-rRkBeU0", # Homecomings / LEMON SOUNDS（Official Music Video）
  "https://www.youtube.com/watch?v=Gy4Mw43qDYo", # Homecomings / I Want You Back
  "https://www.youtube.com/watch?v=p-ca1ocriv0", # Ludovico Einaudi / Walk (Official Video)
  "https://www.youtube.com/watch?v=G1WLy2Bm4Gw", # Ludovico Einaudi / Rose
  "https://www.youtube.com/watch?v=CB2wPf8ffIQ", # Balmorhea / Baleen Morning
  "https://www.youtube.com/watch?v=RSoXgL8dQ5g", # Balmorhea / Pilgrim
  "https://www.youtube.com/watch?v=r-Qu7WWE2VY", # Nils Frahm / You
  "https://www.youtube.com/watch?v=mYIfiQlfaas", # Ólafur Arnalds / Ljósið (Official Music Video)
  "https://www.youtube.com/watch?v=kiZBWhWqE84", # ten to sen / scene-2
  "https://www.youtube.com/watch?v=UQ4dAUNU2yg", # Quentin Sirjacq / memory 2
  "https://www.youtube.com/watch?v=_I2nk1qs2hQ", # Jazmine Sullivan / Good Enough
  "https://www.youtube.com/watch?v=X63EkrpHywE", # macy gray-what i gotta do
  "https://www.youtube.com/watch?v=MDv74VPHW1Q", # José James / Come To My Door
  "https://www.youtube.com/watch?v=bMJkddvJ4L4", # Jessie Ware / Wildest Moments
  "https://www.youtube.com/watch?v=Wo2QB2kqG_w", # Jessie Ware / You & I (Forever)
  "https://www.youtube.com/watch?v=Vk-9tu5V2Hw", # Power / Groovin'
  "https://www.youtube.com/watch?v=ZCkzeD_1-qA", # G C Cameron / Give Me Your Love
  "https://www.youtube.com/watch?v=JacdLT4QdrQ", # More Today Than Yesterday / Patti Austin
  "https://www.youtube.com/watch?v=gJeWaBbowsY", # Faith Evans / Dumb
  "https://www.youtube.com/watch?v=RehgZXGEsxQ", # Daley / Game Over
  "https://www.youtube.com/watch?v=by8-4UKwcKU", # Vince Andrews / Love, Oh Love
  "https://www.youtube.com/watch?v=EJY5se7G-7Q", # Sabrina Starke / Just The Two Of Us (Official Audio)
  "https://www.youtube.com/watch?v=9HvpIgHBSdo", # Gregory Porter / Be Good (Lion's Song) Official Video
  "https://www.youtube.com/watch?v=3ZP3UQ0ESLc", # The Spinners / It's A Shame (Slayd5000)
  "https://www.youtube.com/watch?v=ZB4IPXHElds", # The Chi Lites When Temptation Comes
  "https://www.youtube.com/watch?v=tjE-sbU7Wwc", # The Brand New Heavies / One More For The Road
  "https://www.youtube.com/watch?v=SkIwZsqMtUs", # Saskwatch / Only One
  "https://www.youtube.com/watch?v=HH3ruuml-R4", # Stephen Stills / Love The One You're With
  "https://www.youtube.com/watch?v=KOTOnFKKx7M", # Clean Up Woman / Betty Wright (1971)
  "https://www.youtube.com/watch?v=lbLMABnJ7Vc", # Brigitte / A bouche que veux-tu
  "https://www.youtube.com/watch?v=SR0Mx0OazBU", # Tété / La bande son de ta vie (Clip Officiel)
  "https://www.youtube.com/watch?v=r5eDYt1dIsM", # António Zambujo / Valsa do Vai Não Vás
  "https://www.youtube.com/watch?v=bjjc59FgUpg", # The Cinematic Orchestra / To Build A Home (feat. Patrick Watson)
  "https://www.youtube.com/watch?v=8ty_g5U9-co", # CHVRCHES / The Mother We Share
  "https://www.youtube.com/watch?v=QpFXXPruuqU", # CHVRCHES / Clearest Blue (lyric video)
  "https://www.youtube.com/watch?v=tpprOGsLWUo", # Elvis Costello / Pump it up
  "https://www.youtube.com/watch?v=i7qR1aOKgQ4", # Toro y Moi / Run Baby Run
  "https://www.youtube.com/watch?v=QlXiGj85rOA", # Angus & Julia Stone / Get Home
  "https://www.youtube.com/watch?v=p6xqb-8F4nQ", # Julio y Agosto / Correr para atras
  "https://www.youtube.com/watch?v=gZd-L1-Hi-4", # Ásgeir / Torrent (Official video)
  "https://www.youtube.com/watch?v=LudEZb8-S2c", # Generationals / Black Lemon (Official Lyric Video)
  "https://www.youtube.com/watch?v=W-ZT2Hgonwc", # Travis / Where You Stand
  "https://www.youtube.com/watch?v=UuihJInaeN4", # The 1975 / The City
  "https://www.youtube.com/watch?v=ULavCZGz0mY", # Kodaline / Brand New Day
  "https://www.youtube.com/watch?v=UYHjjk_9-zk", # Kowalski / Outdoors (Music Video)
  "https://www.youtube.com/watch?v=50iOSG8aZ14", # M83 / Year One, One UFO
  "https://www.youtube.com/watch?v=sjxYLFWxR6E", # The Pastels / Check My Heart (Official Video)
  "https://www.youtube.com/watch?v=1XuUIuGy18g", # The Spandettes / Sweet & Saccharine (Acoustic Live Version)
  "https://www.youtube.com/watch?v=2b1GgT07aes", # Vampire Weekend / Unbelievers (Live on SNL)
  "https://www.youtube.com/watch?v=Py2KOyrtq6o", # Yo La Tengo / Ohm (OFFICIAL VIDEO)
  "https://www.youtube.com/watch?v=gI2eO_mNM88", # The xx / VCR
  "https://www.youtube.com/watch?v=qpN5jX3wqq4", # Stars / Ageless Beauty (Official Video)
  "https://www.youtube.com/watch?v=acVn47i9bdU", # Stars / Elevator Love Letter (Live on KEXP)
  "https://www.youtube.com/watch?v=r5Or6-HOveg", # Stars / Your Ex-Lover is Dead
  "https://www.youtube.com/watch?v=NwxdvZKHxio", # Stars / This is The Last Time
  "https://www.youtube.com/watch?v=KbPWi1gshzI", # Sigur Ros / Hoppipolla (HD Live from Heima)
  "https://www.youtube.com/watch?v=uxTH8GZ4PC4", # Death Cab for Cutie / No Room In Frame
  "https://www.youtube.com/watch?v=sEwM6ERq0gc", # HAIM / Forever (Official Music Video)
  "https://www.youtube.com/watch?v=EoCulvhm8iY", # Jamaica / Two On Two
  "https://www.youtube.com/watch?v=VgaRm9j8SQI", # SOAK / Sea Creatures
  "https://www.youtube.com/watch?v=yt_juevz9Qg", # SOAK / B a noBody
  "https://www.youtube.com/watch?v=WjNssEVlB6M", # Jamie xx / Gosh (Official Music Video)
  "https://www.youtube.com/watch?v=TP9luRtEqjc", # Jamie xx / Loud Places (ft Romy)
  "https://www.youtube.com/watch?v=TD_Q9CxXTo4", # Wolf Alice / Bros
  "https://www.youtube.com/watch?v=ZpomZoueWa0", # Wolf Alice / You're A Germ (Official Video)
  "https://www.youtube.com/watch?v=vUw6XtiYWww", # Wolf Alice / Your Love's Whore (Live on KEXP)
  "https://www.youtube.com/watch?v=scuuvcZGlUU", # Wolf Alice / Full Performance (Live on KEXP)
  "https://www.youtube.com/watch?v=f4dZbJHT7_4", # Volcano Choir / "Comrade"
  "https://www.youtube.com/watch?v=JI-G5Cd6OeU", # Stereolab / Wow and Flutter
  "https://www.youtube.com/watch?v=a8Kd6cgBatg", # Anika / Terry
  "https://www.youtube.com/watch?v=n5kpLXfwVTc", # BEACH HOUSE / "SPARKS" (OFFICIAL AUDIO STREAM)
  "https://www.youtube.com/watch?v=vOhLbA-B-bE", # Best Coast / Feeling Ok
  "https://www.youtube.com/watch?v=wLgHKHw2ZnY", # Best Coast / Heaven Sent
  "https://www.youtube.com/watch?v=YaenB-_crmE", # Boy / This is the Beginning
  "https://www.youtube.com/watch?v=WD4-jCn7Svc", # Boy / waitress (HD)
  "https://www.youtube.com/watch?v=oZ70q4_GTpQ", # Cold War Kids / Nights & Weekends (Official Video)
  "https://www.youtube.com/watch?v=SZzJ78FWjl8", # Cold War Kids / First
  "https://www.youtube.com/watch?v=pa1uup8n0OQ", # Courtney Barnett / Elevator Operator - 3/17/2015
  "https://www.youtube.com/watch?v=o-nr1nNC3ds", # Pedestrian At Best / Courtney Barnett
  "https://www.youtube.com/watch?v=Njb3JTZ1ibY", # Dead Fox / Courtney Barnett
  "https://www.youtube.com/watch?v=2ZOGlFdReMM", # Courtney Barnett / Nobody Really Cares If You Don't Go To The Party
  "https://www.youtube.com/watch?v=cOftOXAaBuo", # Craft Spells / After The Moment
  "https://www.youtube.com/watch?v=z_kL3pbtwEM", # Craft Spells / Nausea
  "https://www.youtube.com/watch?v=R_AYZaXz-8g", # Emily King / Good Friend
  "https://www.youtube.com/watch?v=6th29WxOJ-s", # Emily King / The Animals
  "https://www.youtube.com/watch?v=EbmQp6LMdxs", # Emily King / Off Center
  "https://www.youtube.com/watch?v=mKTfugNaQpk", # Florence + The Machine / Only If For A Night (Live Royal Albert Hall)
  "https://www.youtube.com/watch?v=WbN0nX61rIs", # Florence + The Machine / Shake It Out
  "https://www.youtube.com/watch?v=eiH2UHYfZZM", # Florence + The Machine / What Kind Of Man - Later… with Jools Holland - BBC Two
  "https://www.youtube.com/watch?v=KdceK2E-w_8", # Florence + The Machine / Delilah - Live at Glastonbury 2015
  "https://www.youtube.com/watch?v=VwLRFCAQi7E", # HNNY / Sunday
  "https://www.youtube.com/watch?v=KTdXS8NspmQ", # HNNY / You Feeling Alright
  "https://vimeo.com/21248057",                  # James Blake / Unluck
  "https://www.youtube.com/watch?v=isIABK-0ohQ", # James Blake / The Wilhelm Scream
  "https://www.youtube.com/watch?v=_WsOS8QvR74", # James Blake / We Might Feel Unsound
  "https://www.youtube.com/watch?v=6p6PcFFUm5I", # James Blake / Retrograde
  "https://www.youtube.com/watch?v=D2kr9udP6Zo", # James Blake / CMYK - Pitchfork Music Festival 2011
  "https://www.youtube.com/watch?v=48ctczjFdQE", # James Blake / The Sound Of Silence
  "https://www.youtube.com/watch?v=rh7qikFginI", # The Japanese House / Clean
  "https://www.youtube.com/watch?v=jeupYam8JT8", # The Japanese House / Cool Blue
  "https://www.youtube.com/watch?v=Qw0ibCzAa9w", # Júníus Meyvant / Hailslide (Live on KEXP)
  "https://www.youtube.com/watch?v=LBxtxMZNW0o", # Júníus Meyvant / Color Decay
  "https://www.youtube.com/watch?v=xCiBFCfN2NU", # Júníus Meyvant / Gold Laces (Live on KEXP)
  "https://www.youtube.com/watch?v=eUGE3tcHMbY", # Júníus Meyvant / Signals
  "https://www.youtube.com/watch?v=FNwgOkl5nRY", # Kaleo / All The Pretty Girls (Official Video)
  "https://www.youtube.com/watch?v=9WIU5NN1Q0g", # Kaleo / "Way Down We Go" (LIVE in a volcano)
  "https://www.youtube.com/watch?v=sng_CdAAw8M", # Rhye / Open
  "https://www.youtube.com/watch?v=JJS5ywEIsA4", # Rhye / The Fall
  'https://www.youtube.com/watch?v=90luQzm_Pdo', # Flight Facilities / Merimbula
  'https://www.youtube.com/watch?v=l_EIE5f2t6M', # FOALS / Mountain At My Gates [Official Music Video]
  'https://www.youtube.com/watch?v=vbTVQ9bjERo', # FOALS / Albatross [CCTV]
  'https://www.youtube.com/watch?v=gb2__Jkyxs4', # How To Dress Well / What You Wanted (Official Audio)
  'https://www.youtube.com/watch?v=Q_nQd7Z8WEw', # Lord Huron / Love Like Ghosts
  'https://www.youtube.com/watch?v=Exksvl89CfM', # Lord Huron / Until The Night Turns (Audio)
  'https://www.youtube.com/watch?v=9JrEo0hJHYw', # Lord Huron / Dead Man's Hand (Live on KEXP)
  'https://www.youtube.com/watch?v=LNd-1WEkrXU', # Carousels / Sweet Honey
  'https://soundcloud.com/deadlypeople/all-i-could-do?', # Carousels / ALL I COULD DO
  'https://www.youtube.com/watch?v=W5d3Md1BARA', # CHARLIE WINSTON / I Love Your Smile (Official Video)
  'https://www.youtube.com/watch?v=_nl3Oo4-IQ4', # Cat Power / Ruin ("SUN" ANNOUNCEMENT VIDEO)
  'https://www.youtube.com/watch?v=ybjpIt9oPuo', # Cat Power / Manhattan
  'https://www.youtube.com/watch?v=imMMrGeiGDU', # Ayo / Fire
  'https://www.youtube.com/watch?v=_R_pepwMnRs', # Aymé / Make Up
  'https://www.youtube.com/watch?v=O3CkfvYMCWM', # Camera Obscura / French Navy (Official Video)
  'https://www.youtube.com/watch?v=UCVWrqxyt3Y', # Deerhunter / Breaker
  'https://www.youtube.com/watch?v=slQJq1OUXyo', # SOHN / Lessons
  'https://www.youtube.com/watch?v=5jv4lgFrL7U', # St. Vincent / 4AD Session
  'https://www.youtube.com/watch?v=AZW9NYX6JZA', # St. Vincent / Actor Out Of Work (Official Video)
  'https://www.youtube.com/watch?v=Itt0rALeHE8', # St. Vincent / Cruel (Official Video)
  'https://www.youtube.com/watch?v=mVAxUMuhz98', # St. Vincent / Digital Witness
  'https://www.youtube.com/watch?v=vVj3rTWfVVw', # Efterklang / Modern Drift (Official Video)
  'https://www.youtube.com/watch?v=Efg1h0EzLeE', # The National / Terrible Love (Alternate Version)
  'https://www.youtube.com/watch?v=Jpz_gUyImhw', # The National / Graceless
  'https://www.youtube.com/watch?v=zmVdK_PM3dc', # inc. / Black Wings
  'https://www.youtube.com/watch?v=lMDYDE3Ya28', # inc. / Angel
  'https://www.youtube.com/watch?v=KVmNaMy_CLA', # inc. / the place
  'https://www.youtube.com/watch?v=P800UWoE9xs', # A Tribe Called Quest / Award Tour
  'https://www.youtube.com/watch?v=71ubKHzujy8', # A Tribe Called Quest / Can I Kick It?
  'https://www.youtube.com/watch?v=JXBFG2vsyCM', # Nas / Memory Lane
  'https://www.youtube.com/watch?v=e5PnuIRnJW8', # Nas / The World Is Yours (Official Music Video)
  'https://www.youtube.com/watch?v=cyzmmz6hPyE', # Visioneers / The World Is Yours
  'https://www.youtube.com/watch?v=Pj0v1LT_zyc', # Flyphonic / The Truth Is (Feat. Phonteik & Remedeeh)
  'https://www.youtube.com/watch?v=4wNknGIKkoA', # Lou Reed / Walk on the Wild Side
  'https://www.youtube.com/watch?v=eQck_JOB3LY', # The Pains Of Being Pure At Heart / Beautiful You (Official Audio)
  'https://www.youtube.com/watch?v=IBdbbBDOwv4', # The Pains Of Being Pure At Heart / Until The Sun Explodes (OFFICIAL VIDEO)
  'https://www.youtube.com/watch?v=T2syY0U-eY0', # The Pains of Being Pure at Heart / "Heart in Your Heartbreak"
  'https://www.youtube.com/watch?v=i2vvAck6z5c', # The Pains of Being Pure at Heart / "The Body"
  'https://www.youtube.com/watch?v=dz_vKDw1D40', # Clap Your Hands Say Yeah / "Maniac" (Music Video)
  'https://www.youtube.com/watch?v=U8NsSlWBSvM', # Determinations / Gold Star
  'https://www.youtube.com/watch?v=SKVku0mOwdQ', # Determinations / UNDER MY SKIN
  'https://www.youtube.com/watch?v=NXrKDHcH8-s', # Determinations / Ying & Yang
  'https://www.youtube.com/watch?v=B9EWeqo0KfM', # Rumer / Dangerous (Official Video)
  'https://www.youtube.com/watch?v=tqnTf9etEYg', # Rumer / You Just Don't Know People
  'https://www.youtube.com/watch?v=bpqdhgG7DS8', # Rumer / Play Your Guitar
  'https://www.youtube.com/watch?v=S_A2QEH-3KQ', # Rumer / Pizza and Pinball
  'https://www.youtube.com/watch?v=PuzfF4D55qI', # Rumer / P.F. Sloan [Live At Rivoli Ballroom]
  'https://www.youtube.com/watch?v=wh7y--Mc7kk', # Rumer / Sara Smile [Official Video]
  'https://www.youtube.com/watch?v=6RwqPPwHZ_M', # Rumer / Be Nice To Me
]

sendSong = (robot, songs) ->
  unless process.env.HUBOT_SLACK_ROOM
    robot.logger.error "Missing HUBOT_SLACK_ROOM. `heroku config:set HUBOT_SLACK_ROOM=room name`"
    return

  return if holiday.isHoliday(new Date())
  room = {room: process.env.HUBOT_SLACK_ROOM}
  song = songs[ Math.floor(Math.random() * songs.length) ]
  robot.send room, song

module.exports = (robot) ->
  new cronJob
    cronTime: "0 */20 10-19 * * 1"
    onTick: ->
      sendSong robot, SONGS_FOLK
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 */20 10-19 * * 2,3"
    onTick: ->
      sendSong robot, SONGS
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 */20 10-19 * * 4"
    onTick: ->
      sendSong robot, SONGS_VA
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "0 0 10-19 * * 5"
    onTick: ->
      sendSong robot, SONGS_MIX
      return
    start: true
    timeZone: "Asia/Tokyo"
