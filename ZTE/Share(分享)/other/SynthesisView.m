//
//  SynthesisView.m
//  直销通2.8.0
//
//  Created by jun on 16/3/28.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "SynthesisView.h"
#define IconWH 48*layoutBy6()

@interface SynthesisView()
@property (nonatomic,strong) UIImageView *iconImagV;
@property (nonatomic,strong) UILabel *tipLbl;
@property (nonatomic,assign) CGFloat fixWidth;
@property (nonatomic,assign) CGFloat tipFontSize;
@property (nonatomic,strong) UIColor *tipStrColor;
@end

@implementation SynthesisView

- (instancetype)initWitIconName:(NSString *)iconName tipStr:(NSString *)tipStr fixWidth:(CGFloat)fixWidth fontSize:(CGFloat)fontSize tipStrColor:(UIColor *)tipStrColor
{
    self = [super init];
    if (self) {
        _fixWidth = fixWidth;
        _tipFontSize = fontSize;
        _tipStrColor = tipStrColor;
        
        [self addSubview:self.iconImagV];
        [self addSubview:self.tipLbl];
        _iconImagV.image = [UIImage imageNamed:iconName];
        _tipLbl.text = tipStr;
        UITapGestureRecognizer *tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSelf)];
        [self addGestureRecognizer:tap];
        [self addConstraint];
        
    }
    return self;
}

- (void)tapSelf
{
    self.tapSelfBlock(_tapType);
}

- (UIImageView *)iconImagV
{
    if (!_iconImagV) {
        _iconImagV = [[UIImageView alloc]init];
        _iconImagV.backgroundColor = [UIColor clearColor];
    }
    return _iconImagV;
}

- (UILabel *)tipLbl
{
    if (!_tipLbl) {
        _tipLbl = [[UILabel alloc]init];
        _tipLbl.backgroundColor = [UIColor clearColor];
        _tipLbl.font = [UIFont systemFontOfSize:_tipFontSize];
        _tipLbl.textColor = _tipStrColor;
        _tipLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLbl;
}

 - (void)addConstraint
{
    CGFloat iconWH = _fixWidth/2;
    CGFloat iconX = (_fixWidth- iconWH)/2;
  [_iconImagV mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self).offset(iconX);
      make.top.mas_equalTo(self);
      make.width.mas_equalTo(iconWH);
      make.height.mas_equalTo(iconWH);
  }];
    
  [_tipLbl mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(self);
      make.top.mas_equalTo(_iconImagV.bottom).offset(4*layoutBy6());
      make.width.mas_equalTo(self);
      make.height.mas_equalTo(_tipFontSize);
  }];
  
}

@end
