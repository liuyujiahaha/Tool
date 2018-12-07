//
//  BaseNetworkTool.h
//  直销通2.8.0
//
//  Created by mzh on 16/3/14.
//  Copyright © 2016年 jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/**
 *  网络请求基类
 */
@interface BaseNetworkTool : NSObject<UIAlertViewDelegate>

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
 */
- (void)BaseNetworkPostWithURL:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)hudShow currentVC:(BaseVC*)currentVC success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

- (void)loginNetworkPostWithURL:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)hudShow currentVC:(BaseVC*)currentVC success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
