//
//  ZTListCommonComfirmBottomView.m
//  ZTStaff
//
//  Created by yujia liu on 2018/11/22.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import "ZTListCommonComfirmBottomView.h"
@interface ZTListCommonComfirmBottomView()
@property (nonatomic, strong) UIButton *comfirmBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) comfirmBlock comfirmBlock;
@end

@implementation ZTListCommonComfirmBottomView

+(instancetype)initWithTitle:(NSString *)title block:(nonnull comfirmBlock)block{
    
    return [[self alloc]initWithTitle:title block:block];
}

-(instancetype)initWithTitle:(NSString *)title block:(comfirmBlock)block{
    self = [super init];
    if (self) {
        self.title = title;
        self.comfirmBlock = block;
        [self addSubview:self.comfirmBtn];
        [self addSubview:self.lineView];
        [self layoutPageSubviews];
    }
    return self;
}

#pragma mark - response methods
-(void)comfirmAction{
    if (self.comfirmBlock) {
        self.comfirmBlock();
    }
}

#pragma mark - private methods
-(void)layoutPageSubviews{
    [_comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(13);
        make.right.mas_equalTo(self).mas_offset(-13);
        make.top.mas_equalTo(self).mas_offset(10);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - setters and getters
-(UIButton *)comfirmBtn{
    if (!_comfirmBtn) {
        _comfirmBtn = [UIButton new];
        _comfirmBtn.backgroundColor = UIColorFromHexadecimalRGB(0xDF3548);
        [_comfirmBtn setTitle:self.title forState:UIControlStateNormal];
        _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_comfirmBtn addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
        _comfirmBtn.layer.cornerRadius = 2;
        _comfirmBtn.layer.masksToBounds = YES;
    }
    return _comfirmBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = UIColorFromHexadecimalRGB(0xD8D8D8);
    }
    return _lineView;
}
@end
