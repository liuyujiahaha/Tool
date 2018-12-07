//
//  NewNetworkTool.h
//  小移云店
//
//  Created by vivian on 2017/5/5.
//  Copyright © 2017年 vivian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NetApiDefine.h"
/**
 *  网络请求基类
 */
@interface NewNetworkTool : NSObject<UIAlertViewDelegate>

//所有的Block声明
typedef void (^ModelBlock)(NSString *resultCode,id model);

+(instancetype)defaultNetwork;

@property (nonatomic ,strong) MBProgressHUD *HUD;;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
  * 接口参数修改 170609 by vivian
 */
- (void)BaseNetworkPostWithURL:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)hudShow currentVC:(BaseVC*)currentVC success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
