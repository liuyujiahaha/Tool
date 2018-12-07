//
//  CountDownButton.h
//  微品国际
//
//  Created by jia on 2017/10/26.
//  Copyright © 2017年 vpclub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton
@property (nonatomic, assign) float animationOffset;        ///<菊花偏移位置，不设置则居中，默认为0

//开始请求动画
-(void)startRequestAnimation;

//开始倒计时
-(void)startCountDown;

//重置倒计时
-(void)resetCountDown;
@end

@interface abc : UIButton

@end
