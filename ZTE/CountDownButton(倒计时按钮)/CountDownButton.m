//
//  CountDownButton.m
//  微品国际
//
//  Created by jia on 2017/10/26.
//  Copyright © 2017年 vpclub. All rights reserved.
//

#import "CountDownButton.h"

#define CountDownIndex 120

@interface CountDownButton ()
@property (nonatomic, weak) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger countDownIndex;
@property (nonatomic, copy) NSString *countDownOldTitle;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@end

@implementation CountDownButton

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initData];
        _animationOffset = 0;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        self.titleLabel.font = [UIFont systemFontOfSize:14*layoutBy6()];
        [self setTitleColor:hexStringToColor(@"0086E6") forState:UIControlStateNormal];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return self;
}

-(void)initData
{
    self.countDownIndex = CountDownIndex;
    self.countDownOldTitle = @"";
}

-(void)startRequestAnimation
{
    self.enabled = NO;
    [self addSubview:self.activityView];
    [self.activityView startAnimating];
    _countDownOldTitle = self.titleLabel.text;
    [self setTitle:@"" forState:UIControlStateNormal];
}

-(void)stopRequestAnimation
{
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
}

//停止倒计时
-(void)stopCountDown
{
    if ([self.countDownTimer isValid]) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
    [self stopRequestAnimation];
    self.enabled = YES;
    self.countDownOldTitle = @"";
}

//开始倒计时
-(void)startCountDown
{
    [self stopRequestAnimation];
    if (![self.countDownTimer isValid]) {
        [self setTitle:[NSString stringWithFormat:@"倒计时(%ld)", self.countDownIndex] forState:UIControlStateNormal];
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
}

//重置倒计时
-(void)resetCountDown
{
    self.countDownIndex = CountDownIndex;
    if (_countDownOldTitle.length) {
        [self setTitle:_countDownOldTitle forState:UIControlStateNormal];
    }
    [self stopCountDown];
}

#pragma mark - timer

-(void)timerAction
{
    self.countDownIndex--;
    
    if (self.countDownIndex > 0) {
        [self setTitle:[NSString stringWithFormat:@"倒计时(%ld)", self.countDownIndex] forState:UIControlStateNormal];
    }else{
        [self resetCountDown];
    }
}

#pragma mark - setter and getter

-(UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        float height = self.frame.size.height * 0.5;
        float width = self.frame.size.width;
        _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((width - height)/2 + _animationOffset, height/2, height, height)];
        _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _activityView.hidesWhenStopped = YES;
    }
    return _activityView;
}

@end



@interface abc()

@end


@implementation abc
@end
