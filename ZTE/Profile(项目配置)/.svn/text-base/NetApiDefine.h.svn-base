//
//  NetApiDefine.h
//  小移云店
//
//  Created by vivian on 2017/8/9.
//  Copyright © 2017年 vivian. All rights reserved.
//

#ifndef NetApiDefine_h
#define NetApiDefine_h

#pragma mark -- 后台接口
/*
 注意：以下是后台接口名称
 */

/*店铺模块*/
//广告管理：罗正顺
#define AdvertPage @"/cmbs/advert/consumer/advertInfo/advertPage"
//专题：张斌-段金良
#define SelectUserSubject @"/moses/zoneconf/subject/selectAllUserSubject"
//编辑活动专区：段金良
#define AddUserSubjectList @"/moses/zoneconf/customSubject/addList"
//分享活动专区：段金良
#define ShareUserSubjectList @"/moses/zoneconf/subject/addShare"

/*订单统计模块*/
//订单业务办理列表：罗正顺
#define OrderPage @"/cmbs/order/count/consumer/businessOrder/webOrderPage"
//数据字典：张斌
#define AppDictionary @"/moses/app/dictionary/get"
//订单统计接口：尹熙成 20170808修改
#define OrderAndCommission @"/cmbs/order/count/consumer/businessOrder/getCountNumber"

/*我的模块/app端模块，包括我的个人信息和店铺信息*/
//查询店铺：钟航
#define QUARY_STOREINFO @"/moses/shop/app/shop/query"
//更新店铺：钟航
#define UPDATE_STOREINFO @"/moses/shop/app/shop/update"
//地址列表：张斌，钟航
#define ADDRESS_LIST @"/moses/app/disctricts/list"
//店铺用户查询：钟航
#define SHOP_USER @"/moses/shop/app/user/query"
//上传头像：钟航
#define UPLOAD_FILEPATH @"/moses/upload/file/upload"
//修改店铺信息：钟航
#define UPDATE_USER @"/moses/shop/app/user/update"
//店铺分享统计：钟航--王亮
//#define STAT_SHARE @"/moses/share/shareLog/add"
#define STAT_SHARE @"/moses/share/share/add"
//生成短链-王亮
#define SHORT_LINK @"/moses/share/shortLink/generateShortLinkXYYD"
//查询短链-王亮
#define QUARY_LINK @"/moses/share/shortLink/queryLink"

/*工作台消息端模块*/
//消息公告：王建
#define MESSAGEINFO @"/cmbs/message/consumer/messageInfo/frontEndPage"
//消息公告详情：王建
#define MESSAGEQUARY @"/cmbs/message/consumer/messageInfo/query"

/*账号管理模块*/
//登录：钟航
#define LOGIN_URL @"/moses/shop/app/user/login"
//发送短信：钟航
#define SEND_MSGCODE @"/moses/shop/app/user/sendMsgCode"
//验证短信验证码：钟航
#define CHECK_MSGCODE @"/moses/shop/app/user/checkValidateMsgCode"
//修改密码：钟航
#define UPDATE_USERPSW @"/moses/shop/app/user/updatePassword"
//升级更新：张斌
#define UPGRADE_VERSION @"/moses/app/appVersion/lastVersion"

/*市场模块*/
//市场商品列表，排序和筛选接口：阳新波
#define MARKET_PRODUCT_LIST @"/moses/search/consumer/product/search"
//店铺推荐商品列表：钟航
#define RECOMMAND_PRODUCT_LIST @"/moses/product/app/product/page"
//店铺推荐商品列表：钟航
#define RECOMMAND_PRODUCT_LIST @"/moses/product/app/product/page"
//自定义应用分类接口：卢松炯
#define CATEGOTY_LIST @"/moses/category/app/customAppCategory/page"
//品牌接口：卢松炯
#define BRAND_LIST @"/moses/brand/app/appBrand/page"
//推荐商品接口：钟航
#define RECOMMAND_PRODUCT @"/moses/product/app/productRecommend/recommend"
//供应商接口：钟航
#define SUPPLIER_LIST @"/moses/product/app/org/querySupplier"
//查询推荐字段：钟航
#define QUARY_RECOMMANDWORD @"/moses/product/app/product/queryRecommendProduct"

#pragma mark -- h5链接
/*注意：以下是h5的链接拼接*/

/*专区模块*/
//当前父专题 && 有子专题：盛闯
#define SUBJECT_PARENT_CHILD @"/mcs/cloud/store/#/home/zone/child?parentId="
//当前父专题 && 没有子专题：盛闯
#define SUBJECT_PARENT @"/mcs/cloud/store/#/home/zone/parent?parentId="
//当前子专区：盛闯
#define SUBJECT_CHILD @"/mcs/cloud/store/#/home/zone/child?"

/*业务模块*/
//流量、套餐、预存赠送,数字化服务
#define BUSINESS_NORMAL @"/mcs/cloud/store/#/home/business?childId="
//宽带新装：盛闯
#define BUSINESS_BROADBAND @"/mcs/cloud/store/#/home/broadband/install"
//充值缴费：盛闯
#define BUSINESS_RECHARGE @"/mcs/cloud/store/#/home/recharge/recharge"
//业务预约：盛闯
#define BUSINESS_BOOKLIST @"/mcs/cloud/store/#/home/bookView/bookList"

/*店铺模块*/
//店铺分享链接：盛闯
#define STORE_SHARE @"/mcs/cloud/store/#/home"
//店铺/市场-商品详情
#define STORE_PRODETAIL @"/mcs/cloud/store/#/market/detail"
//店铺/市场-搜索
#define STORE_SEARCH @"/mcs/cloud/store/#/market/search"

/*我的*/
//我的-我的订单
#define MY_ORDER @"/mcs/cloud/store/#/mine/mineOrderView/mineOrderList"

//我的-我的预约订单
#define MY_BOOKINGLIST @"/mcs/cloud/store/#/mine/booking/bookingList"

//我的-我的店员
#define MY_CLERKLIST @"/mcs/cloud/store/#/mine/mineClerkView/mineClerkList"

//我的-我的常客
#define MY_CUSTOMER @"/mcs/cloud/store/#/mine/mineCustomer"

//我的-我的收入
#define MY_PROFIT @"/mcs/cloud/store/#/mine/mineProfitView/mineProfit"

/*工作台*/
//工作台-客户信息
#define WORKSHOP_VALIDATE @"/mcs/cloud/store/#/home/userInfoView/validate"

#endif /* NetApiDefine_h */
