//
//  ZTListCommonBottomView.m
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import "ZTListCommonBottomView.h"
@interface ZTListCommonBottomView()
@property (nonatomic, strong) UIButton *refuseBtn;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, copy) NSString *leftName;
@property (nonatomic, copy) NSString *rightName;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation ZTListCommonBottomView

-(instancetype)initWithLeftName:(NSString *)leftName rightName:(NSString *)rightName{
    self.leftName = leftName;
    self.rightName = rightName;
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.refuseBtn];
        [self addSubview:self.agreeBtn];
        [self addSubview:self.lineView];
        [self layoutPageSubViews];
    }
    return self;
}

-(void)refuseAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(BottomViewRefuseAction)]) {
        [self.delegate BottomViewRefuseAction];
    }
}

-(void)agreeAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(BottomViewAgreeAction)]) {
        [self.delegate BottomViewAgreeAction];
    }
}

-(void)layoutPageSubViews{
    [_refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(13);
        make.right.mas_equalTo(self.mas_centerX).mas_offset(-6.5);
        make.top.mas_equalTo(self).mas_offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
    [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).mas_offset(6.5);
        make.right.mas_equalTo(self).mas_offset(-13);
        make.top.mas_equalTo(self).mas_offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

-(UIButton *)refuseBtn{
    if (!_refuseBtn) {
        _refuseBtn = [[UIButton alloc]init];
        [_refuseBtn setTitle:self.leftName forState:UIControlStateNormal];
        _refuseBtn.backgroundColor = [UIColor whiteColor];
        [_refuseBtn setTitleColor:UIColorFromHexadecimalRGB(0x666666) forState:UIControlStateNormal];
        _refuseBtn.layer.cornerRadius = 2;
        _refuseBtn.layer.borderWidth = 0.5;
        _refuseBtn.layer.borderColor = UIColorFromHexadecimalRGB(0x666666).CGColor;
        _refuseBtn.layer.masksToBounds = YES;
        [_refuseBtn addTarget:self action:@selector(refuseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refuseBtn;
}

-(UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [[UIButton alloc]init];
        [_agreeBtn setTitle:self.rightName forState:UIControlStateNormal];
        _agreeBtn.backgroundColor = UIColorFromHexadecimalRGB(0xDF3548);
        _agreeBtn.layer.cornerRadius = 2;
        _agreeBtn.layer.masksToBounds = YES;
        [_agreeBtn addTarget:self action:@selector(agreeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = UIColorFromHexadecimalRGB(0xD8D8D8);
    }
    return _lineView;
}

@end
