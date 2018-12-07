//
//  NewNetworkTool.m
//  小移云店
//
//  Created by vivian on 2017/5/5.
//  Copyright © 2017年 vivian. All rights reserved.
//

#import "NewNetworkTool.h"
#import "MyMD5.h"
#import "AppDelegate.h"
#import "SecurityUtil.h"
#import "NSObject+SBJson.h"

#define NEW_APP_ID @"100000054"

@implementation NewNetworkTool

+(instancetype)defaultNetwork{
    static NewNetworkTool *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[[self class]alloc]init];
    });
    
    return instance;
}

- (void)BaseNetworkPostWithURL:(NSString *)url params:(NSDictionary *)params isShowHud:(BOOL)hudShow currentVC:(BaseVC*)currentVC success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    AppDelegate *delegate = [AppDelegate globalDelegate];
    if (currentVC) {
        [delegate checkNetWorkWithCurrentVc:currentVC];
    }
    __block BOOL blokc_hudShow = hudShow;
    if (hudShow) {
        [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_SHOW_NOTI object:nil];
    }
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];//json格式请求
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //请求头授权，vivian 2017-09-28
    NSString *jwtToken = [AppSingleton shareSingleton].loginData.jwtToken ? [AppSingleton shareSingleton].loginData.jwtToken:@"";
    if (jwtToken.length>0) {
        [mgr.requestSerializer setValue:jwtToken forHTTPHeaderField:@"Authorization"];
    }
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript", nil];
    // 2.拼接url
    
    if (params == nil) {
        params = [NSDictionary dictionary];
    }
    NSMutableDictionary *dicts = [NSMutableDictionary dictionaryWithDictionary:params];
    //拼接基础参数
    NSString *strId = [AppSingleton shareSingleton].loginData.internalBaseClassIdentifier?[AppSingleton shareSingleton].loginData.internalBaseClassIdentifier:@"";
    
    
    [dicts setObject:NEW_APP_ID forKey:@"appId"];
    [dicts setObject:strId forKey:@"userId"];
    
    //超时处理
    [self performSelector:@selector(Timeouthandling) withObject:[NSNumber numberWithBool:YES] afterDelay:30];
    
    url = [NSString stringWithFormat:@"%@%@",APP_URL,url];
    
    // 3.发送请求
    [mgr POST:url parameters:dicts progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(Timeouthandling) object:[NSNumber numberWithBool:YES]];//取消超时处理。
        
        if (blokc_hudShow) {
            [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
        }
        //解析的网络数据
        NSDictionary *jsonDict = (NSDictionary *)responseObject;
        
        int isPass = [validateString([jsonDict objectForKey:@"returnCode"]) intValue];
        NSString *messageStr =validateString([jsonDict objectForKey:@"message"]);
        
        //1000  正常成功请求数据
        if (isPass ==  (1000) || isPass == 1002) {
            if (success&&!([success isEqual:[NSNull null]]))
                success(responseObject);
            return ;
        }
        
        if (currentVC) {
            //              [currentVC requestErrUrl:url Data:responseObject];
        }
        //1009  登录失效
        if (isPass == 1009) {
            UDSaveData(@"0", @"isLogin");
            UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"登陆失效" message:@"尊敬的用户，您的本次登陆已经失效，需要您重新登录！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            alet.delegate = self;
            alet.tag = 1009;
            [alet show];
            return;
        }
        
        else if (isPass == 1004){
             [SGInfoAlert showInfo:@"服务器繁忙，请喝杯茶休息一会"];
            return;
        }
        //6033  0元支付成功
        else if (isPass == 6033) {
            success(responseObject);
        }
        //1005  账户不存在
        else   if ([messageStr isEqualToString:@"账户不存在"]) {
            UDSaveData(@"0", @"isLogin");
            UIAlertView *alet = [[UIAlertView alloc]initWithTitle:@"登陆失效" message:@"尊敬的用户，您的账户不存在，需要您重新登录！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
            alet.delegate = self;
            alet.tag = 1009;
            [alet show];
            return;
        }
        else  if (isPass != 1000) {
            //其他网络报错
            NSString *message = validateString([jsonDict objectForKey:@"message"]);
            if ([currentVC isKindOfClass:[BaseVC class]]) {
                for (UIView * hudView in [AppDelegate globalDelegate].window.subviews) {
                    if ([hudView isKindOfClass:[MBProgressHUD class]]) {
                        [hudView setHidden:YES];
                    }
                }
            }
            if (failure) {
                [SGInfoAlert showInfo:message inView:[AppDelegate globalDelegate].window vertical:0.4];
                failure(nil);
            }
            return;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(Timeouthandling) object:[NSNumber numberWithBool:YES]];//取消超时处理。
        [SGInfoAlert showInfo:@"服务器繁忙，请喝杯茶休息一会"];
        if (failure) {
            if (blokc_hudShow) {
                [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
            }
            failure(error);
        }
    }];
}
/**
 *  超时处理
 */
-(void)Timeouthandling{
    [[NSNotificationCenter defaultCenter] postNotificationName:L_HUD_HIDDEN_NOTI object:nil];
}

/**
 *获取当前的时间戳
 *@return Linux 标准时间戳 PS:1447140415
 */
-(NSString *)timeWithNowNSTimeInterval
{
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    long long int currentIntTime=(long long int)time;
    NSString *tempTime = [NSString stringWithFormat:@"%lld",currentIntTime];
    return tempTime;
}

/**
 *获取当前APP版本号
 *@return v 整形参数 PS:100
 */
-(NSString *)appNowVersion
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *strArr = [appVersion componentsSeparatedByString:@"."];
    NSMutableString *v=[[NSMutableString alloc]init];
    for (int i =0; i<strArr.count; i++) {
        [v appendString:strArr[i]];
    }
    return v;
}
#pragma  mark  - 代理
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1009:
        {
            [[AppDelegate globalDelegate] goLoginVC];
        }
            break;
            
        default:
            break;
    }
    
}

@end
