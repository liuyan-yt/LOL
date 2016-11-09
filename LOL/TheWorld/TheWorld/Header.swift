//
//  Header.swift
//  TheWorld
//
//  Created by lanou3g on 16/8/12.
//  Copyright © 2016年 柳焱. All rights reserved.
//

import Foundation

//资讯标签
let informationLabelUrl = "http://lol.zhangyoubao.com/apis/rest/CatalogsService/all?cattype=news&i_=CuQHNh0oBMtA%2BtpEKPaCtFDs3Eu6%2Bryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA%2BtpEKPaCtFDs3Eu6%2Bryl9J/IE7u9oRU=&t_=1470830376079&p_=20582&v_=400900&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=CatalogsService.all&time=1470830376&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=50112&secretSignature=qquNBK5JhepHNu0OF8WgvJQh%2Buw="
//顶部轮播图

let informationScrollUrl = "http://lol.zhangyoubao.com/apis/rest/ItemsService/ads?i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470879263132&p_=11741&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.ads&time=1470879263&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=146511&secretSignature=iK1YbHDkZVyH2amUFxGoutcNIyg="

//资讯最新列表
let informationLastListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?catid=10178&cattype=news&page="
let informationLastListUrl2 = "&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470833003070&p_=11555&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.lists&time=1470833003&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=487398&secretSignature=WbRSUoef1fPWoKoahcfdgC3RoaM="
//资讯最新详情（两处拼接）
let informationLastDetailUrl1 = "http://api.lol.zhangyoubao.com/mobiles/item/"
//中间拼接id 最后拼接 published
let informationLastDetailUrl2 = "?v_=400901&size=middle&t="
//夜间模式
let informationLastDetailUrlNight = "?v_=400901&model=night&size=middle&t="
//详情页轮播图
let informationDetailScrollUrl1 = "http://api.lol.zhangyoubao.com/mobiles/item/"
//中间拼接id
let informationDetailScrollUrl2 = "?v_=400901&size=middle&t=1470908237"
//夜间模式
let informationDetailScrollNight = "?v_=400901&model=night&size=middle&t=1472010213"



//资讯新闻列表
let informationNewsListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?catid=10000&cattype=news&page="
let informationNewsListUrl2 = "&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470833003070&p_=11555&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.lists&time=1470833003&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=487398&secretSignature=WbRSUoef1fPWoKoahcfdgC3RoaM="
//资讯赛事列表
let informationSportListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?catid=10006&cattype=news&page="
let informationSportListUrl2 = "&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470833003070&p_=11555&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.lists&time=1470833003&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=487398&secretSignature=WbRSUoef1fPWoKoahcfdgC3RoaM="

//资讯娱乐列表
let informationPlayListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?catid=10179&cattype=news&page="
let informationPlayListUrl2 = "&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470833003070&p_=11555&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.lists&time=1470833003&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=487398&secretSignature=WbRSUoef1fPWoKoahcfdgC3RoaM="


//视频娱乐、解说、赛事标签
let videoItemUrl = "http://lol.zhangyoubao.com/apis/rest/CatalogsService/all?cattype=video&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470879738885&p_=29000&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=CatalogsService.all&time=1470879738&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=298284&secretSignature=scH8OTzm7yDr3Oabl/1vExlBPm0="

//娱乐视频列表（）
let videoPlayListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/videos?catid=10174&catwordid="
//中间拼接id
let videoPlayListUrl2 = "&page="
let videoPlayListUrl3 = "&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470965510605&p_=4160&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.videos&time=1470965510&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=312235&secretSignature=QZa2lB2+mFemj80PN6o4NWXdUBQ="

let videoTalkListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/videos?catwordid="
let videoTalkListUrl2 = "&page="
let videoTalkListUrl3 = "&i_=KeK%2BB/Egjdvr%2BftuxjqPZQVqjeQo2/E5r6WuC1igLn%2BEVwYpeCvywJm1DzfUYSGpbBgXd0r8OhG0orCTlekOyjWypeW1ATccgCinabgc4oNTS7/bPUDJgfNiVHMrDuIV&t_=1471398166&p_=26843&v_=40090003&d_=ios&osv_=9.1&version=0&a_=lol&api=ItemsService.videos&game=lol&time=1471398166&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=326272&secretSignature=DPdSh9O1Y0TaYS8LNp95twlg8kM="

let videoSportListUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/videos?catwordid="
let videoSportListUrl2 = "&page="
let videoSportListUrl3 = "&i_=KeK%2BB/Egjdvr%2BftuxjqPZQVqjeQo2/E5r6WuC1igLn%2BEVwYpeCvywJm1DzfUYSGpbBgXd0r8OhG0orCTlekOyjWypeW1ATccgCinabgc4oNTS7/bPUDJgfNiVHMrDuIV&t_=1471399753&p_=31604&v_=40090003&d_=ios&osv_=9.1&version=0&a_=lol&api=ItemsService.videos&game=lol&time=1471399753&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=281374&secretSignature=r5Tthg6NyUmTwwLg4o9TT8Xnvwg="


//视频详情页


let videoDetailUrl1 = "http://lol.zhangyoubao.com/mobiles/item/"
let videoDetailUrl2 = "?user_id=&token=&i_=mG4iUTthnIdZyIJtD/hP0Or6lGeDHt4uhHllQRsqrSaOoOWeWuWUvpyR3rEmgBgOk/NYjvlwquiqMK6/FAd41KKyJfv0/SJ%2BgieMBJWaBb6OWNbAbvyODlOMBa7EQ9EB&t_=1472007476&p_=24773&v_=40090103&d_=ios&osv_=9.3.2&version=0&a_=lol&api=item.69975&game=lol&time=1472007476&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=989030&secretSignature=oLM3gwEZ5gQvMrAnVVIvrigr4tE=&size=middle"
let videoDetailNight = "v_=400901&model=night?user_id=&token=&i_=mG4iUTthnIdZyIJtD/hP0Or6lGeDHt4uhHllQRsqrSaOoOWeWuWUvpyR3rEmgBgOk/NYjvlwquiqMK6/FAd41KKyJfv0/SJ%2BgieMBJWaBb6OWNbAbvyODlOMBa7EQ9EB&t_=1472007476&p_=24773&v_=40090103&d_=ios&osv_=9.3.2&version=0&a_=lol&api=item.69975&game=lol&time=1472007476&secretVersion=v1.0&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&nonce=989030&secretSignature=oLM3gwEZ5gQvMrAnVVIvrigr4tE=&size=middle";

//视频详情页评论
let videoCommentUrl1 = "http://lol.zhangyoubao.com/apis/rest/ItemsService/commentsById?id="
//中间拼接id
let videoCommentUrl2 = "&page="
let videoCommentUrl3 = "&userid=&token=&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470981265620&p_=19205&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=ItemsService.commentsById&time="
//中间拼接published
let videoCommentUrl4 = "&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=390527&secretSignature=OdU68omUoIjiRSSmGfF2yS1nGfU="

//全部英雄
let allHeroUrl = "http://lolbox.duowan.com/phone/apiHeroes.php?type=all"

//英雄列表URL
let freeHeroUrl = "http://lolbox.duowan.com/phone/apiHeroes.php?type=free"

//英雄详情URL
let heroDetailUrl = "http://lolbox.duowan.com/phone/apiHeroDetail.php?heroName="
//英雄 —— 英雄图片 (PNG)
let heroPictureUrl1 = "http://img.lolbox.duowan.com/champions/"
let heroPictureUrl2 = "_120x120.jpg"




//英雄 —— 英雄技能图片 (PNG)
let KUnion_Ency_HeroSkillImageURL1 = "http://img.lolbox.duowan.com/abilities/"
let KUnion_Ency_HeroSkillImageURL2 = "_64x64.png";
//英雄详情-英雄出装列表URL
let kUnion_Ency_HeroDetails_EquipSelectURL = "http://db.duowan.com/lolcz/img/ku11/api/lolcz.php?v=108&OSType=iOS8.3&championName=%@&limit=7"
//英雄详情-英雄排行TOP10URL
let heroTopUrl = "http://lolbox.duowan.com/phone/heroTop10PlayersNew.php?hero="
//英雄详情-英雄皮肤URL
let heroSkinUrl = "http://box.dwstatic.com/apiHeroSkin.php?hero="
//英雄战略视频URL
let heroStrategyUrl1 = "http://box.dwstatic.com/apiVideoesNormalDuowan.php?v=117&action=l&p=1&tag="
let heroStrategyUrl2 = "&src=letv"


//装备分类列表URL
let equipsListUrl = "http://lolbox.duowan.com/phone/apiZBCategory.php"
//装备列表URL拼接tag
let equipsClassUrl = "http://lolbox.duowan.com/phone/apiZBItemList.php?tag="
//装备图片URL
let equipsClassImgUrl1 = "http://img.lolbox.duowan.com/zb/"
//中间拼接id
let equipsClassImgUrl2 = "_64x64.png"
//装备详情URL，后面拼接id
let equipsDetailUrl = "http://lolbox.duowan.com/phone/apiItemDetail.php?id="
//符文URL
let runesUrl = "http://lolbox.duowan.com/phone/apiRunes.php"
//符文图片URL//http://img.lolbox.duowan.com/runes/bl_2_3.png
//http://img.lolbox.duowan.com/runes/Img_等级.png
let runesImageUrl = "http://img.lolbox.duowan.com/runes/%@_%ld.png"

//战略视频url
let heroStrategyUrl = "http://box.dwstatic.com/apiVideoesNormalDuowan.php?action=f&vid="



//社区真人秀
let communityShowURl1 = "http://lol.zhangyoubao.com/apis/rest/UgcsService/getUserShows?area=&order_kind=0&sex=&page="
let communityShowURl2 = "&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470985037418&p_=24599&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=&modle_=MI%20NOTE%20LTE&api=UgcsService.getUserShows&time=1470985037&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=307294&secretSignature=2peqyk8gYeuvyEK0u9NyKSd54SA="
//真人秀详情
let communityShowDetailUrl1 = "http://lol.zhangyoubao.com/apis/rest/UgcsService/userShowComments?id="
let communityShowDetailUrl2 = "&page=1&userid=25265305&token=8936b869e74b95e91566f4845f24a828827&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1471426288577&p_=28076&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=25265305&modle_=MI%20NOTE%20LTE&api=UgcsService.userShowComments&time=1471426288&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=226607&secretSignature=7kJ92eBWcMUlIR+R/yYQx3ZRfH0="


//社区找战友
let communityFriendUrl = "http://lol.zhangyoubao.com/apis/rest/UgcsService/getCompanions?userid=25265305&i_=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&deviceId=CuQHNh0oBMtA+tpEKPaCtFDs3Eu6+ryl9J/IE7u9oRU=&t_=1470986069341&p_=30368&v_=400901&a_=lol&pkg_=com.anzogame.lol&d_=android&osv_=23&cha=xiaomiMartket&u_=25265305&modle_=MI%20NOTE%20LTE&api=UgcsService.getCompanions&time=1470986069&game=lol&secretId=AKIDz8krbsJ5yKBZQpn74WFkmLPx3gnPhESA&secretVersion=v1.0&nonce=7590&secretSignature=K6+PULSXJy978o/VkQk1VIMr6bI="










