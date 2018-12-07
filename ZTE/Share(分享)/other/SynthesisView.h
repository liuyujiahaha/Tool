//
//  SynthesisView.h
//  直销通2.8.0
//
//  Created by jun on 16/3/28.
//  Copyright © 2016年 jun. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SynthesisView : UIView
@property(nonatomic,copy) void(^tapSelfBlock)(NSInteger tapType);
@property (nonatomic,assign) NSInteger tapType;


- (instancetype)initWitIconName:(NSString *)iconName tipStr:(NSString *)tipStr fixWidth:(CGFloat)fixWidth fontSize:(CGFloat)fontSize tipStrColor:(UIColor *)tipStrColor;
@end
