//
//  ZTListCommonInfoCell.m
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import "ZTListCommonInfoCell.h"
#import "ZTListCommonInfoCellModel.h"

@interface ZTListCommonInfoCell()
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *contentLbl;
@end

@implementation ZTListCommonInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLbl];
        [self addSubview:self.contentLbl];
        [self layoutPageSubViews];
    }
    return self;
}

-(void)layoutPageSubViews{
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.top.bottom.mas_equalTo(self);
    }];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-19);
        make.top.bottom.mas_equalTo(self);
    }];
}


#pragma mark - setters and getters
-(void)setModel:(ZTListCommonInfoCellModel *)model{
    _model = model;
    _titleLbl.text = model.title;
    _contentLbl.text = model.content;
}


-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]init];
        _titleLbl.text = @"标题";
        _titleLbl.font = [UIFont systemFontOfSize:16];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.textColor = UIColorFromHexadecimalRGB(0x333333);
    }
    return _titleLbl;
}

-(UILabel *)contentLbl{
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc]init];
        _contentLbl.text = @"内容";
        _contentLbl.font = [UIFont systemFontOfSize:16];
        _contentLbl.textAlignment = NSTextAlignmentRight;
        _contentLbl.textColor = UIColorFromHexadecimalRGB(0x666666);
    }
    return _contentLbl;
}

@end
