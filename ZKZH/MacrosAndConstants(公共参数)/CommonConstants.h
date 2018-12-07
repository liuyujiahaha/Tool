//
//  CommonConstants.h
//  PlayCarParadise
//
//  Created by lius on 2017/10/10.
//  Copyright © 2017年 CarFun. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 请求时间戳失败通知
extern NSString *const RequestManagerTimeStampErrorNotification;
/// token过期或没登录弹出登录界面通知
extern NSString *const NeedLoginNotification;


extern NSString *const RedPacketMoney;//红包金额
extern NSString *const RedPacketType;//红包类型


extern NSString *const paySuccessNotification;
extern NSString *const payFailedNotification;
/** 添加购物车或者立即购买通知 */
UIKIT_EXTERN NSString *const SELECTCARTORBUY;
/** 商品SKU选择完立即购买通知 */
UIKIT_EXTERN NSString *const IMMEDIATELYBUY;
/** 收藏夹编辑完成状态 */
UIKIT_EXTERN NSString *const COLLECTIONEDITFINISH;
/** 商品SKU选择完毕属性传递通知 */
UIKIT_EXTERN NSString *const SKUSELECTED;
/** 添加到购物车通知 */
UIKIT_EXTERN NSString *const ADDTOSHOPCART ;
/** 点击了两次分类按钮 */
UIKIT_EXTERN NSString *const DIDCLICKCATOPAGETABBAR ;
/** 常量数 */
UIKIT_EXTERN CGFloat const DCMargin;



