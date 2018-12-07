//
//  NetworkingMacros.h
//  PlayCarParadise
//
//  Created by lius on 2017/10/10.
//  Copyright © 2017年 CarFun. All rights reserved.
//

#ifndef NetworkingMacros_h
#define NetworkingMacros_h

#ifndef ISTORE_ENVIRONMENT

#define ISTORE_ENVIRONMENT  0 // 0:开发环境  1:正式环境  2:测试环境


#if ISTORE_ENVIRONMENT == 0
//开发接口地址
#define Host UDTakeData(@"HOST_IN_TEST")?UDTakeData(@"HOST_IN_TEST"):@"http://10.10.20.168:8081/"
#define JSHost @"http://shop.test.buyerapi.istore8.cn/"//JavaShop接口地址
//IM头像地址
#define IM_Header_Host UDTakeData(@"HOST_IN_TEST_IM_Header")?UDTakeData(@"HOST_IN_TEST_IM_Header"):@"http://img.istore8.cn/"
//H5地址
#define H5_Host UDTakeData(@"HOST_IN_TEST_H5")?UDTakeData(@"HOST_IN_TEST_H5"):@"http://10.10.20.22/"

#elif ISTORE_ENVIRONMENT == 1
#define Host @"http://app.istore8.cn/"                  //正式接口地址
//#define JSHost @"http://shop.buyerapi.istore8.cn/"    //JavaShop接口地址  *注意：正式环境下的JavaShop的地址还没有给出
#define IM_Header_Host @"http://img.istore8.cn/"        //IM头像地址
#define H5_Host @"http://h5.istore8.cn/"                //H5地址

#elif ISTORE_ENVIRONMENT == 2
//测试接口地址
//#define Host UDTakeData(@"HOST_IN_TEST")?UDTakeData(@"HOST_IN_TEST"):@"http://app.test.istore8.cn/"
#define Host UDTakeData(@"HOST_IN_TEST")?UDTakeData(@"HOST_IN_TEST"):@"https://app-test.istore8.cn/"
#define JSHost @"http://shop.test.buyerapi.istore8.cn/"//JavaShop接口地址

//IM头像地址
#define IM_Header_Host UDTakeData(@"HOST_IN_TEST_IM_Header")?UDTakeData(@"HOST_IN_TEST_IM_Header"):@"http://img.test.istore8.cn/"
//H5地址
//#define H5_Host UDTakeData(@"HOST_IN_TEST_H5")?UDTakeData(@"HOST_IN_TEST_H5"):@"http://h5.test.istore8.cn/"
#define H5_Host UDTakeData(@"HOST_IN_TEST_H5")?UDTakeData(@"HOST_IN_TEST_H5"):@"https://h5-test.istore8.cn/"


#endif
#endif

#define HostAppKey @"wcly@alphaidea"
/// 聊天室头像URL
#define IM_Header_URLStr_Key @"im_header_urlStr_key"
#define IM_RedAndTransSetting_Key @"im_redAndTransSetting_key"

///获取时间戳
#define LS_TimeStamp            [Host stringByAppendingString:@"common/getTimestamp"]
///获取注册接口验证码
#define LS_GetIdentifying       [Host stringByAppendingString:@"register/code"]
///获取国家列表
#define LS_GetRegisterCountryInfo       [Host stringByAppendingString:@"register/country-info"]

///获取注册接口邮箱验证码
#define LS_GetRegisterMailCode     [Host stringByAppendingString:@"multi/country/send-mail"]
///注册接口
#define LS_LocalRegister      [Host stringByAppendingString:@"register"]
///注册用户校验（新）
#define LS_RegisterCheckMobile      [Host stringByAppendingString:@"register/check-mobile"]
///注册邮箱用户校验（新）
#define LS_RegisterCheckEmail      [Host stringByAppendingString:@"register/check-email"]

///通过邮箱注册接口
#define LS_LocalMailRegister    [Host stringByAppendingString:@"register/register-email"]
/////登录接口
//#define LS_LocalLogin      [Host stringByAppendingString:@"login"]
///登录接口
#define LS_LocalLogin      [Host stringByAppendingString:@"login/new"]
///邮箱登录接口
#define LS_LocalMailLogin      [Host stringByAppendingString:@"login/mail-login"]
///修改密码
#define LS_ModifyPwd     [Host stringByAppendingString:@"user/modifyPwd"]
///忘记密码验证码
#define LS_IdentifyingPwd      [Host stringByAppendingString:@"forgot/password/code"]
///获取验证码（新）
#define LS_RegisterNewCode      [Host stringByAppendingString:@"register/newcode"]

///忘记密码
#define LS_ForgetPwd    [Host stringByAppendingString:@"forgot/password"]
///忘记密码（邮箱账号）
#define LS_MailForgetPwd    [Host stringByAppendingString:@"multi/country/modify-password"]
///上传头像
#define LS_UploadImg   [Host stringByAppendingString:@"user/uploadImg"]
///退出登录
#define LS_Logout   [Host stringByAppendingString:@"logout"]
///反馈意见
#define LS_Feedback   [Host stringByAppendingString:@"user/feedback"]
///我的钱包
#define LS_RedBalance      [Host stringByAppendingString:@"red/balance"]
//聊天室模糊搜索
#define LS_ChatSearch      [Host stringByAppendingString:@"user/page/keyword"]
//聊天室创建群
#define LS_ChatGroupCreate      [Host stringByAppendingString:@"chat/group/create"]
//解散群
#define LS_ChatGroupDelete      [Host stringByAppendingString:@"chat/group/delete"]

///绑定银行卡
#define LS_BingRemittance      [Host stringByAppendingString:@"remittance/account/bind"]
///红包历史
#define LS_RedBagRecords     [Host stringByAppendingString:@"red/records"]
///提现
#define LS_RedBagDraw    [Host stringByAppendingString:@"user/draw"]
//修改用户资料
#define WSX_UpdateUserInfo     [Host stringByAppendingString:@"user/updateUserInfo"]
//用户注册（新）
#define WSX_RegisterNew     [Host stringByAppendingString:@"register/new"]


//获取用户资料
#define WSX_GetUserInfo  [Host stringByAppendingString:@"user/getUser"]
//获取用户积分记录
#define WSX_GetIntegralList  [Host stringByAppendingString:@"user/getIntegralList"]
//获取用户金币记录
#define WSX_GetGoldRecordList  [Host stringByAppendingString:@"user/getGoldRecordList"]
//获取关注列表
#define WSX_GetAttentionList  [Host stringByAppendingString:@"user/getAttentionList"]
//获取粉丝列表
#define WSX_GetFansList  [Host stringByAppendingString:@"user/getFansList"]
//获取用户发出打赏
#define WSX_SendUserReward  [Host stringByAppendingString:@"user/sendUserReward"]
//获取用户收到打赏
#define WSX_GetUserReward  [Host stringByAppendingString:@"user/getUserReward"]
//添加关注
#define WSX_AddAttention  [Host stringByAppendingString:@"user/addAttention"]
//取消关注
#define WSX_DelAttention  [Host stringByAppendingString:@"user/delAttention"]
//收到的评论
#define WSX_GetCriticisedList  [Host stringByAppendingString:@"user/getMyReceiveCommentList"]
//发出的评论
#define WSX_GetCommentList  [Host stringByAppendingString:@"user/getMySenCommentList"]
//获取宣传活动(登入广告)
#define WSX_GetActivity  [Host stringByAppendingString:@"common/getActivity"]
//获取用户私信列表
#define WSX_GetInboxList  [Host stringByAppendingString:@"user/getInboxList"]
//获取私信对话详情
#define WSX_GetInboxDetaiList  [Host stringByAppendingString:@"user/getInboxDetaiList"]
//发送私信
#define WSX_SendInboxDetail  [Host stringByAppendingString:@"user/sendInboxDetail"]
//获取我的帖子（包括精华）
#define WSX_GetMyPostList  [Host stringByAppendingString:@"user/getMyAndShePostList"]
//获取我的微说
#define WSX_GetMyTalkList  [Host stringByAppendingString:@"user/getMyAndSheTalkList"]
//获取关注动态（帖子）
#define WSX_GetAttentionPostList  [Host stringByAppendingString:@"user/getAttentionPostList"]
//获取关注动态（微说）
#define WSX_GetAttentionTalkList  [Host stringByAppendingString:@"user/getAttentionTalkList"]
//获取收藏的帖子
#define WSX_GetPostCollectList  [Host stringByAppendingString:@"user/postCollectList"]
//获取收藏的微说
#define WSX_GetTalkCollectList  [Host stringByAppendingString:@"user/talkCollectList"]
//首页顶部轮播图
#define WSX_GetBannerList  [Host stringByAppendingString:@"common/getBannerList"]
//首页帖子
#define WSX_GetPostList  [Host stringByAppendingString:@"common/getPostList"]
//用户卡包
#define WSX_GetCardBagAndNum  [Host stringByAppendingString:@"user/card/CardBagAndNum"]
//分页获取优惠券数据集合
#define WSX_GetCarBagList  [Host stringByAppendingString:@"user/card/getCarBagList"]
//获取优惠券详情
#define WSX_GetCardBagDetails  [Host stringByAppendingString:@"user/card/CardBagDetails"]
//获取玩车圈首页
#define WSX_GetCarClubList  [Host stringByAppendingString:@"car/club/getCarClubList"]
//分页获取玩车圈>车友会(推荐车友会)
#define WSX_GetQueryCarClubList  [Host stringByAppendingString:@"common/car/queryRecommendList"]
//获取玩车圈>车友会(首页推荐帖子图片)
#define WSX_GetPostImg  [Host stringByAppendingString:@"common/car/getPostImg"]
//获取首页微说
#define WSX_GetTalkList  [Host stringByAppendingString:@"common/getTalkList"]
//车友会创建
#define WSX_CreatCarClub  [Host stringByAppendingString:@"car/club/saveCarClub"]
//获取车友会>按品牌查找
#define WSX_GetCarLineList  [Host stringByAppendingString:@"common/car/getCarLineList"]
//获取车友会>按地区查找
#define WSX_GetCityList  [Host stringByAppendingString:@"common/car/getCityList"]
//获取车友会详情
#define WSX_GetCarClubDetails  [Host stringByAppendingString:@"common/car/getCarClubDedails"]
// 分页获取(车友会 车系圈 兴趣圈 城市) 详情帖子列表
#define WSX_GetCarClubPostList  [Host stringByAppendingString:@"common/car/getCarClubPostList"]
// 车友会详情>添加问题
#define WSX_SaveCarClubPostIssue  [Host stringByAppendingString:@"car/club/saveCarClubPostIssue"]
//车友会>申请加入车友会
#define WSX_JoinCarClub  [Host stringByAppendingString:@"car/club/joinCarClub"]
//车系>获取车系圈详情
#define WSX_GetCarLineDetail  [Host stringByAppendingString:@"common/car/getCarLineDetail"]
//地区>获取城市圈详情
#define WSX_GetCityCircleDetail  [Host stringByAppendingString:@"common/car/getCityCircleDetail"]
//获取车友会详情>公告
#define WSX_GetCarClubNotic  [Host stringByAppendingString:@"common/car/getCarClubNotic"]
//分页获取车友会成员列表
#define WSX_GetCarClubMemberList  [Host stringByAppendingString:@"common/car/getCarClubMemberList"]
//车友会设置>设置用户为成员,管理员,删除成员
#define WSX_SaveCarClubManager  [Host stringByAppendingString:@"car/club/saveCarClubManager"]
//分页获取车友会,车系圈,城市圈活动帖子列表
#define WSX_GetCarClubActivityPostList  [Host stringByAppendingString:@"common/car/getCarClubActivityPostList"]
//车系>获取车系列表
#define WSX_GetCarHondaList  [Host stringByAppendingString:@"common/car/getCarHondaList"]
//车系>添加用户关注或取消车系圈
#define WSX_SaveUserAttentionCar  [Host stringByAppendingString:@"car/line/saveUserAttentionCar"]
//地区>关注或取消城市圈
#define WSX_SaveUserAttentionCity  [Host stringByAppendingString:@"car/city/saveUserAttentionCity"]
//添加或者更新(车友会: 城市圈: 车系圈)的公告
#define WSX_SaveCircleNotice  [Host stringByAppendingString:@"car/club/saveCircleNotice"]
//首页>搜索帖子
#define WSX_FindPostAndTileList  [Host stringByAppendingString:@"common/post/findPostAndTileList"]
//搜索>获取搜索热词集合
#define WSX_GetSearchHotWordList  [Host stringByAppendingString:@"/common/post/getSearchHotWordList"]
//话题贴>分页获取话题帖子集合
#define WSX_GetTopicList  [Host stringByAppendingString:@"common/topic/getTopicList"]
//车友会>分页获取按品牌或地区的车友会列表
#define WSX_GetCarLineSonListById  [Host stringByAppendingString:@"common/car/getCarLineSonListById"]
//用户>用户发微说上传图片
#define WSX_TalkUploadImg  [Host stringByAppendingString:@"user/talk/uploadImg"]
//用户>发微说
#define WSX_SaveUserTalk  [Host stringByAppendingString:@"user/talk/saveUserTalk"]
//用户>微说上传视频
#define WSX_UploadVideo  [Host stringByAppendingString:@"user/talk/uploadVideo"]
//用户>发视频
#define WSX_SaveUserTalkVideo  [Host stringByAppendingString:@"user/talk/saveUserTalkVideo"]
//帖子>用户发帖子获取关注的车系,地区,车友会,兴趣圈集合
#define WSX_GetUserSenPostCircleList  [Host stringByAppendingString:@"car/club/getUserSenPostCircleList"]
//帖子>添加用户发普通帖子或者保存草稿箱
#define WSX_SaveUserPost  [Host stringByAppendingString:@"user/saveUserPost"]
//获取帖子草稿箱列表
#define WSX_GetMydraftsList  [Host stringByAppendingString:@"user/getMydraftsList"]
//帖子>获取用户编辑普通帖子,或草稿箱
#define WSX_getUserEnditPost  [Host stringByAppendingString:@"user/showUserEnditPost"]
//用户>获取我关注的车友会列表
#define WSX_GetMyCarClubList  [Host stringByAppendingString:@"car/club/getMyCarClubList"]
//用户>获取我关注的城市圈列表
#define WSX_GetMyCityList  [Host stringByAppendingString:@"car/city/getMyCityList"]
//用户>获取我关注的车系圈列表
#define WSX_GetMyCarList  [Host stringByAppendingString:@"car/line/getMyCarList"]
//用户>删除发布或草稿箱帖子
#define WSX_DeletePost  [Host stringByAppendingString:@"user/deletePost"]
//获取帖子详情（大接口）
#define WSX_getPostDetail  [Host stringByAppendingString:@"common/getGeneralPostDetail"]
//添加用户评论帖子或回复评论
#define WSX_SaveCommentPost  [Host stringByAppendingString:@"post/comment/saveCommentPost"]
//添加微说评论或者回复评论
#define WSX_SaveCommentTalk  [Host stringByAppendingString:@"user/talk/saveCommentTalk"]
//获取帖子详情评论
#define WSX_GetPostCommentList  [Host stringByAppendingString:@"common/getPostCommentList"]
//添加用户对评论点赞(A)
#define WSX_SaveCommentPraise  [Host stringByAppendingString:@"car/club/saveCommentPraise"]
//用户收藏帖子微说,或者取消收藏
#define WSX_SaveUserCollect [Host stringByAppendingString:@"user/saveUserCollect"]
//添加用户对帖子>点赞(A)
#define WSX_SavePostPraise [Host stringByAppendingString:@"car/club/savePostPraise"]
//添加用户对该帖子金币打赏
#define WSX_SavePostGold [Host stringByAppendingString:@"car/club/savePostGold"]
//添加用户对帖子进行红包打赏
#define WSX_SaveRewardRed [Host stringByAppendingString:@"car/club/saveRewardRed"]
//用户>获取他人更多详情数据
#define WSX_GetUserPronDetail [Host stringByAppendingString:@"user/getUserPronDetail"]
//用户>获取他人更多详情数据
#define WSX_Report [Host stringByAppendingString:@"user/report"]
//用户>获取他人发出的打赏
#define WSX_SendUserPronReward [Host stringByAppendingString:@"user/sendUserPronReward"]
//首页>分页搜索用户列表
#define WSX_GetUserList [Host stringByAppendingString:@"common/getUserList"]
//普通帖子热门评论列表
#define WSX_GetPostHotCommentList [Host stringByAppendingString:@"common/getPostHotCommentList"]
//获取微说详情大接口
#define WSX_getTalkDetailById  [Host stringByAppendingString:@"user/talk/getTalkDetailById"]
//获取微说详情大接口
#define WSX_deleteUserTalk  [Host stringByAppendingString:@"user/talk/deleteUserTalk"]
//分页获取微说详情评论列表
#define WSX_GetTalkCommentList  [Host stringByAppendingString:@"user/talk/getTalkCommentList"]
//添加微说评论点赞
#define WSX_SaveTalkCommentLike  [Host stringByAppendingString:@"user/talk/savTalkCommentLike"]
//微说>获取热门评论列表
#define WSX_GetTalkHotCommentList  [Host stringByAppendingString:@"user/talk/getTalkHotCommentList"]
//添加微说点赞
#define WSX_SaveTalkPraise  [Host stringByAppendingString:@"user/talk/saveTalkPraise"]
//添加用户对微说金币打赏
#define WSX_SaveTalkGold  [Host stringByAppendingString:@"user/talk/saveTalkGold"]
//用户添加拉黑名单或者取消黑名单
#define WSX_SaveOrDeleteUserBlack  [Host stringByAppendingString:@"user/saveOrDeleteUserBlack"]
//个人中心>分页获取系统消息的审核列表
#define WSX_GetUserAuditList  [Host stringByAppendingString:@"user/getUserAuditList"]
//个人中心>活动消息列表
#define WSX_GetActivityList  [Host stringByAppendingString:@"user/message/activity/list"]
//个人中心>分页获取系统消息列表
#define WSX_GetUserMessageList  [Host stringByAppendingString:@"user/message/list"]
//用户中心>系统消息>修改申请车友会的审核状态
#define WSX_UpdateApplStatus  [Host stringByAppendingString:@"user/updateApplStatus"]
//获取黑名单列表
#define WSX_GetUserBlackList  [Host stringByAppendingString:@"user/getUserBlackList"]
//我的钱包--->未领取的红包列表
#define WSX_Unreceived  [Host stringByAppendingString:@"red/unreceived"]
//领取红包
#define WSX_Receive  [Host stringByAppendingString:@"red/receive"]
//红包规则
#define WSX_RedRule  [H5_Host stringByAppendingString:@"help?type=11"]
//帮助中心接口
#define WSX_Help  [Host stringByAppendingString:@"help"]
//关于我们
#define WSX_AboutOur  [H5_Host stringByAppendingString:@"help?type=1"]
//帖子如何被选入精华
#define WSX_PostEssence  [H5_Host stringByAppendingString:@"help?type=2"]
//金币规则
#define WSX_Gold  [H5_Host stringByAppendingString:@"help?type=3"]
//积分规则
#define WSX_intergal  [H5_Host stringByAppendingString:@"help?type=4"]
//发帖教程
#define WSX_SendPost  [H5_Host stringByAppendingString:@"help?type=5"]
//用户协议
#define WSX_User  [H5_Host stringByAppendingString:@"help?type=6"]
//违章说明
#define WSX_ViolationDesc  [H5_Host stringByAppendingString:@"help?type=7"]
//钱包操作手册
#define WSX_PurseOperation  [H5_Host stringByAppendingString:@"help?type=10"]
//车友会规则
#define WSX_carClue  [Host stringByAppendingString:@"help?type=8"]
//获取车友会,车系圈,城市>详情置顶帖子
#define WSX_GetCarClubStick  [Host stringByAppendingString:@"common/car/getCarClubStick"]
//添加车友会,车系圈,城市圈>帖子取消或添加内置顶(A)
#define WSX_PostCircleStick  [Host stringByAppendingString:@"user/postCircleStick"]
//车友会,车系圈,城市圈>帖子设置设置为精华
#define WSX_UpdateActivityPostEssence  [Host stringByAppendingString:@"car/club/updateActivityPostEssence"]
//车友会,车系圈,城市圈>移除出动帖子
#define WSX_RemoveActivityPost  [Host stringByAppendingString:@"car/club/removeActivityPost"]
//获取精华首页获取兴趣圈列表
#define WSX_GetEssenceCircleList  [Host stringByAppendingString:@"user/getEssenceCircleList"]
//首页>兴趣帖子>获取管理员兴趣圈页面数据
#define WSX_GetManageCircleList  [Host stringByAppendingString:@"user/getManageCircleListIOS"]
//添加车友会 ,车系圈, 城市 活动帖子>报名(A)
#define WSX_SaveCarActivityEnroll  [Host stringByAppendingString:@"car/club/saveCarActivityEnroll"]
//首页>兴趣帖子>用户添加或删除兴趣圈
#define WSX_SaveDeSleteInterestCircle  [Host stringByAppendingString:@"user/saveDeleteInterestCircle"]
//微信账号登陆
#define WSX_WeixinLogin  [Host stringByAppendingString:@"weixin/login"]
//微信账号绑定获取验证码
#define WSX_WeixinBindCode  [Host stringByAppendingString:@"weixin/account/bind/code"]
//微信账号绑定
#define WSX_WeixinBindAndLogin  [Host stringByAppendingString:@"weixin/account/bind"]
//获取活动帖子详情
#define WSX_GetCarActivityPostDetail  [Host stringByAppendingString:@"post/activity/getCarActivityPostDetail"]
//验证手机是否已经存在
#define WSX_CheckAccount  [Host stringByAppendingString:@"weixin/account/check/mobile"]
//验证忘记密码的验证码是否正确
#define iStore_CheckForgotPasswordCode  [Host stringByAppendingString:@"forgot/password/check/code"]

//个人中心>用户删除自己发出的评论
#define WSX_DeleteCommentById  [Host stringByAppendingString:@"user/talk/deleteCommentById"]
//开关
//#define WSX_GetRedBagOpen  [Host stringByAppendingString:@"common/getRedBagOpen"]
#define WSX_GetRedBagOpen  [Host stringByAppendingString:@"common/getFunctionOpen"]
//用户操作分享获取红包
#define WSX_ShareRed  [Host stringByAppendingString:@"share/gain/red"]
//获取宣传活动(登入广告)
#define WSX_GetActivity  [Host stringByAppendingString:@"common/getActivity"]
//帮助中心列表数据 获取1级2级集合
#define ShopMineSetting_HelpList  [Host stringByAppendingString:@"mall/faq/list"]
//检测版本
#define WSX_GetVersion  [Host stringByAppendingString:@"common/getAndroidVersion"]
//检测版本（新）
#define WSX_GetVersionNew  [Host stringByAppendingString:@"/common/getAppVersion"]


// 创建红包订单(@@@ 替换)
#define CY_CreateRedpacketOrderURL  [Host stringByAppendingString:@"chat/order/create"]
// 抢红包
#define CY_RobRedpacketURL  [Host stringByAppendingString:@"chat/red/rob"]
// 判断红包是否被领取
#define CY_JudgeRedpacketRobURL  [Host stringByAppendingString:@"chat/red/isRob"]
// 多国登录：查询客户端的所在地,返回location字段  接口提供人：马家勇  日期：2018年5月4日
#define QueryClientLocaleURL  [Host stringByAppendingString:@"/multi/country/query-client-locale"]

// 红包、转账参数配置
#define IM_settingOfRedOrTransferURL  [Host stringByAppendingString:@"/chat/red/setting"]

// 创建个人红包、群红包
#define IM_SendRedpacketURL  [Host stringByAppendingString:@"/chat/send/red"]

// 获取红包,判断是否还有红包
#define IM_gainStatusOfRedpacketURL  [Host stringByAppendingString:@"/chat/red/gain"]

// 领取个人红包、转账、群红包
#define IM_receiveRedpacketURL  [Host stringByAppendingString:@"/chat/red/receive"]

// 红包领取列表，群红包查看大家手气
#define IM_receiveListOfRedpacketURL  [Host stringByAppendingString:@"/chat/red/receive-list"]

// 红包转账
#define IM_transferAccountsURL  [Host stringByAppendingString:@"/chat/red/transfer-accounts"]

// 发出的红包记录列表
#define IM_outRedpacketURL  [Host stringByAppendingString:@"/chat/red/getGiveOutRedList"]

// 收到的红包记录列表
#define IM_inRedpacketURL  [Host stringByAppendingString:@"/chat/red/getReceiveRedList"]

// 收藏列表
#define IM_collectionListURL  [Host stringByAppendingString:@"/chat/collect/list"]

// 添加收藏
#define IM_addCollectURL  [Host stringByAppendingString:@"/chat/collect/add"]

// 删除收藏
#define IM_deleteCollectURL  [Host stringByAppendingString:@"/chat/collect/delete"]

// 添加提醒
#define IM_addRemindURL  [Host stringByAppendingString:@"/chat/remind/add"]

// 翻译
#define IM_translateURL  [Host stringByAppendingString:@"/chat/trans"]

// 获取后台图片域名(头像图片地址和分享图片地址)
#define IM_imageDomainOfHeadAndShare  [Host stringByAppendingString:@"/common/image/url"]

// 获取支付钱包开关列表
//#define IM_payList  [Host stringByAppendingString:@"/common/pay/wallet/list"]
#define IM_payList  [Host stringByAppendingString:@"/common/on/off/list"]

// 修改支付密码
#define IM_updatePayPswURL [Host stringByAppendingString:@"/wallet/home/update/password"]
#pragma mark------------------------------------JavaShop 商城接口---------------------------------------------------------------------
/// page-data-buyer-controller 楼层相关API
#define JavaShop_pages [JSHost stringByAppendingString:@"pages/WAP/INDEX"]
/// 查询导航栏列表
#define JavaShop_siteNavigations [JSHost stringByAppendingString:@"pages/site-navigations"]
/// 查询焦点图列表
#define JavaShop_focusPicturesBanner [JSHost stringByAppendingString:@"focus-pictures"]


#pragma mark------------------------------------商城接口---------------------------------------------------------------------


/// 发现搜索接口
#define CY_SearchGoodsURL [Host stringByAppendingString:@"mall/goods/search"]
/// 首页搜索接口 /返回的数据带有热搜词
#define CY_Search_Home_URL [Host stringByAppendingString:@"mall/goods/recommend-list"]
#define CY_Search_Scan_URL [Host stringByAppendingString:@"mall/goods/sku/code"]
#define CY_GoodDetailURL [Host stringByAppendingString:@"mall/goods/detail"]
#define CY_AddToShoppingcartURL [Host stringByAppendingString:@"mall/cart/add"]
#define CY_GoodBuyNow   [Host stringByAppendingString:@"mall/ready/goods/detail"]

//购物车接口
#define CY_GetShoppingcartNumURL [Host stringByAppendingString:@"mall/cart/cart/count"]
#define CY_MyShopCarList   [Host stringByAppendingString:@"mall/cart/list"]
#define CY_MyShopCarListUpdate   [Host stringByAppendingString:@"mall/cart/update"]
#define CY_MyShopCarListDelete   [Host stringByAppendingString:@"mall/cart/delete"]
#define CY_MyShopCarSettlement   [Host stringByAppendingString:@"mall/ready/cart/list"]
#define CY_MyShopCarSaveInvoice   [Host stringByAppendingString:@"mall/invoice/save"]
#define CY_MyShopCarSaveOrder   [Host stringByAppendingString:@"mall/order/cart/save"]
#define CY_MyShopCarSaveBuyNowOrder   [Host stringByAppendingString:@"mall/order/save"]
#define CY_MyShopCarPaySuccess   [Host stringByAppendingString:@"mall/pay/ok/detail"]

//优惠券接口
#define CY_GoodCommentList    [Host stringByAppendingString:@"mall/comment/list"]
#define CY_CouponsCenterList  [Host stringByAppendingString:@"mall/discount/list"]
#define CY_CouponsTake  [Host stringByAppendingString:@"mall/discount/user/add"]
#define CY_CouponsMine  [Host stringByAppendingString:@"mall/discount/user/my/list"]
#define CY_CouponsShopCart  [Host stringByAppendingString:@"mall/discount/cart/discount"]
#define CY_CouponsBuyNow  [Host stringByAppendingString:@"mall/discount/goods/discount"]

//收藏接口
#define CY_CollectSaveUser    [Host stringByAppendingString:@"user/saveUserCollect"]
#define CY_CollectGoodsList    [Host stringByAppendingString:@"user/goods/list"]
#define CY_CollectShopList    [Host stringByAppendingString:@"user/shop/list"]
#define CY_CollectCommunityList    [Host stringByAppendingString:@"user/collectPostTalkList"]
#define CY_CollectDelete    [Host stringByAppendingString:@"user/delete"]

//收货地址接口
#define LS_AddressListURL [Host stringByAppendingString:@"mall/address/list"]
#define LS_AddressSaveURL [Host stringByAppendingString:@"mall/address/save"]
#define LS_AddressUpdateURL [Host stringByAppendingString:@"mall/address/update"]
#define LS_AddressDeleteURL [Host stringByAppendingString:@"mall/address/delete"]
#define LS_OrderListURL [Host stringByAppendingString:@"mall/my/order/list"]
#define LS_OrderDetailURL [Host stringByAppendingString:@"mall/my/order/detail"]
#define LS_OrderSureGoodsURL [Host stringByAppendingString:@"mall/my/order/update-order"]

//共用的接口
#define CY_GoodHtml   [H5_Host stringByAppendingString:@"mdse_details_data"]
#define CY_invoiceHtml   [H5_Host stringByAppendingString:@"invoice"]
#define CY_specialHtml   [H5_Host stringByAppendingString:@"special_statement"]
#define CY_aboutHtml   [Host stringByAppendingString:@"common/we"]
#define CY_privacyPolicyHtml   @"http://h5.istore8.cn/privacy.html"

//解析二维码地址
#define CY_QrCodeUrl   [Host stringByAppendingString:@"userFace/qrCodeUrl"]
//修改用户人脸设置
#define CY_UpdateUserFace   [Host stringByAppendingString:@"userFace/updateUserFaceStatus"]
//新增或更新人脸信息
#define CY_AddUserFace   [Host stringByAppendingString:@"userFace/addUserFace"]
//PayPal支付回调更新订单信息
#define CY_updatePayPal   [Host stringByAppendingString:@"paypal/editShopOrder"]

//退款订单集合
#define OrderAfterSaleListURL [Host stringByAppendingString:@"mall/my/order/return/list"]
//查看物流详情
#define OrderShowExpress [Host stringByAppendingString:@"mall/my/order/show/express"]

//首页获取商品分类模块数据集合
#define WS_homeGoodsList [Host stringByAppendingString:@"mall/home/all-list"]
//商品分类一级分类
#define WS_categoryList [Host stringByAppendingString:@"mall/category/one/list"]
//商品分类二级分类
#define WS_categorySecondList [Host stringByAppendingString:@"mall/category/two/list"]


/*商城订单管理接口*/
//未支付订单创建总订单
#define ShopMall_OrderSave [Host stringByAppendingString:@"mall/order/save/sum"]
//余额支付
#define ShopMall_PayBalance [Host stringByAppendingString:@"mall/pay/balance"]
//获取微信-支付宝参数
#define ShopMall_PayWxAli [Host stringByAppendingString:@"mall/pay/ali/wx"]
//取消订单
#define ShopMall_OrderClose [Host stringByAppendingString:@"mall/my/order/close"]
//用户确认订单收货
#define ShopMall_OrderReceiveExpress [Host stringByAppendingString:@"mall/my/order/updateOrderOK"]
//用户提醒商家发货
#define ShopMall_OrderRemindSend [Host stringByAppendingString:@"mall/my/order/remind/send"]
//删除订单
#define ShopMall_OrderDelete [Host stringByAppendingString:@"mall/my/order/delete"]
//添加商品评论
#define ShopMall_OrderSaveComment [Host stringByAppendingString:@"mall/comment/save"]
//评论上传图片
#define ShopMall_OrderCommentUpload [Host stringByAppendingString:@"mall/comment/upload"]
//回显准备评价商品数据
#define ShopMall_OrderCommentShow [Host stringByAppendingString:@"mall/comment/show/comment"]

//退款上传图片
#define ShopMall_OrderRefundUpload  [Host stringByAppendingString:@"mall/my/order/return/upload"]
//申请退款
#define ShopMall_OrderRefundApply [Host stringByAppendingString:@"mall/my/order/return"]
///编辑提交申请退款
#define ShopMall_OrderRefundUpdateApply [Host stringByAppendingString:@"mall/my/order/update/return"]
//获取退款详情
#define ShopMall_RefundOrderDetail [Host stringByAppendingString:@"mall/my/order/return/detail"]
//退款填写单号
#define ShopMall_RefundSendPostNumber [Host stringByAppendingString:@"mall/my/order/send/number"]
//用户取消退款申请
#define ShopMall_RefundCloseOrder [Host stringByAppendingString:@"mall/my/order/return/close"]



#pragma mark------------------------------------钱包接口---------------------------------------------------------------------
#define CY_GetWalletHomeConfigURL [Host stringByAppendingString:@"wallet/home/index"]
#define CY_SetPayPswURL [Host stringByAppendingString:@"wallet/home/wallet-user-base"]
#define CY_RechargeURL [Host stringByAppendingString:@"wallet/pay/create"]

//重置支付密码
#define CY_updatePayPswURL [Host stringByAppendingString:@"/wallet/home/update/password"]

#define CY_WithdrawInfoURL [Host stringByAppendingString:@"wallet/withdraw/index"]

#define CY_BillInfoURL [Host stringByAppendingString:@"/wallet/transaction/index-new"]
//校验支付密码
#define CY_checkPayPswURL [Host stringByAppendingString:@"user/pay/check/password"]


/*万项钱包*/
//用户绑定XTECHS钱包接口
#define XTECHS_Bind [Host stringByAppendingString:@"/wallet/xtechs/bind"]
//获取用户WTECHS钱包接口
#define XTECHS_GetXtechs [Host stringByAppendingString:@"/wallet/xtechs/getXtechs"]
//用户取消绑定WTECHS钱包接口
#define XTECHS_Unbind [Host stringByAppendingString:@"/wallet/xtechs/unbind"]
//获取用户XTECHS钱包是否绑定接口
#define XTECHS_GetBind [Host stringByAppendingString:@"/wallet/xtechs/getBind"]
//WTECHS钱包付款接口
#define XTECHS_Payment [Host stringByAppendingString:@"wallet/xtechs/payment"]
//用户WTECHS钱包账单列表接口
#define XTECHS_Order [Host stringByAppendingString:@"/wallet/xtechs/order"]
//获取头像和分享的时候的图片域名
#define Common_img_url [Host stringByAppendingString:@"/common/image/url"]

/// 银行卡首页已绑定银行卡
#define CY_Bank_HomeURL [Host stringByAppendingString:@"wallet/bank/index"]
#define CY_BankListURL [Host stringByAppendingString:@"wallet/bank/bank-list"]
#define CY_BindBankURL [Host stringByAppendingString:@"wallet/bank/bind-card"]
#define CY_Wallet_GetCodeURL [Host stringByAppendingString:@"wallet/bank/verification-code"]
#define CY_DeleteCardURL [Host stringByAppendingString:@"wallet/bank/remove-card"]
#define CY_verifyBeforeInputPswURL [Host stringByAppendingString:@"wallet/withdraw/withdraw-verify"]
#define CY_verifyPayPswURL [Host stringByAppendingString:@"wallet/withdraw/verifi-pwd"]
//#define CY_userDelegateURL [Host stringByAppendingString:@"wallet/home/user-agreement"]
#define CY_userDelegateURL [H5_Host stringByAppendingString:@"help?type=9"]
#define CY_verifyAuthCodeURL [Host stringByAppendingString:@"wallet/forget/verify-code"]
#define CY_openAccountNotificationURL [Host stringByAppendingString:@"wallet/home/enable-withdraw-advice"]


#endif /* NetworkingMacros_h */
