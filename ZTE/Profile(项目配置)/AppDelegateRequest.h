//
//  AppDelegateRequest.h
//  小移云店
//
//  Created by 中兴微品 on 16/6/15.
//  Copyright © 2016年 vivian. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^upgradeBlock)(NSDictionary *dataDictionary, BOOL flag);
@interface AppDelegateRequest : NSObject<UIAlertViewDelegate>

@property (strong, nonatomic)NSString *m_appUrl;


//版本升级
-(void)SetUpUpgrade:(NSDictionary*)dict andBaseVC:(UIWindow*)basevc andSuccese:(upgradeBlock)dictBlock;
@end
