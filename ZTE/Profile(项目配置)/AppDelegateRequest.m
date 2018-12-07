//
//  AppDelegateRequest.m
//  小移云店
//
//  Created by 中兴微品 on 16/6/15.
//  Copyright © 2016年 vivian. All rights reserved.
//

#import "AppDelegateRequest.h"
#import "NewNetworkTool.h"

@implementation AppDelegateRequest

/********
 
 检查Ios_APP版本,type:1,iOS;
 sysFlage:sysFlage:1大众版,2校园版,3企业版、4 AppStore版
 version:int类型的
 *******/
-(void)SetUpUpgrade:(NSDictionary*)dict andBaseVC:(UIWindow*)basevc andSuccese:(upgradeBlock)dictBlock{
    NSString *url = [NSString stringWithFormat:@"%@",UPGRADE_VERSION];

    [[NewNetworkTool defaultNetwork] BaseNetworkPostWithURL:url params:dict isShowHud:YES currentVC:nil success:^(id json) {
        int isPass = [[json objectForKey:@"returnCode"] intValue];
        if (isPass != 1000 && isPass != 1002) {
            AlertWithMessage([json objectForKey:@"message"] );
            return ;
        }
        id obj = [json objectForKey:@"dataInfo"];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDictionary = (NSDictionary*)obj;
            //最新版本
            NSString *status=[NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"version"]];
            status = [status stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSInteger strCurrentStatus = [status intValue];
            
            //当前版本
            NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            appVersion=[appVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSInteger strCurrentVersion = [appVersion intValue];
            
            NSString *isForceUpdate=[NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"forceUpgrade"]];
            NSString *json = [dataDictionary objectForKey:@"appFile"];
            NSArray *appFile = jsonToClass(json);
            if (appFile.count == 0) {
                return;
            }
            
            NSDictionary *dict = appFile[0];
            self.m_appUrl= validateString([dict objectForKey:@"url"]);
            
            if (strCurrentStatus > strCurrentVersion) {
                if ([isForceUpdate isEqualToString:@"2"])
                {
                    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
                    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
                    
                    NSString *strNextCanUpdate=[[NSUserDefaults standardUserDefaults]objectForKey:@"NEXT_CAN_UPDATE"];
                    
                    double dNext=[strNextCanUpdate doubleValue];
                    double dNow=[currentTime doubleValue];
                    //test
//                    if (dNow>=dNext||dNext<1.0){
                        dictBlock(dataDictionary,NO);
                        
                        //设置下次调用“检查更新”接口的时间
                        NSDateFormatter *aformatter =[[NSDateFormatter alloc] init];
                        [aformatter setDateFormat:@"yyyyMMddHHmmss"];
                        //1*24*60*60 每一天调用一次
                        NSDate *dNextDate=[[NSDate alloc]initWithTimeInterval:(1*24*60*60) sinceDate:[NSDate date]];
                        NSString *strNextDate=[aformatter stringFromDate:dNextDate];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:strNextDate forKey:@"NEXT_CAN_UPDATE"];
                        [[NSUserDefaults standardUserDefaults]synchronize];
//                    }
                }
                else if([isForceUpdate isEqualToString:@"1"])
                {
                    dictBlock(dataDictionary,YES);
                }
            }
        }
    } failure:^(NSError *error) {
    }];
}

@end
