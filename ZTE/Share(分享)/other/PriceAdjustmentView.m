//
//  PriceAdjustmentView.m
//  lnyp
//
//  Created by MacBookPro on 16/1/9.
//  Copyright © 2016年 VP. All rights reserved.
//

#import "PriceAdjustmentView.h"
#import "IQKeyboardManager.h"

@interface PriceAdjustmentView()<UITextFieldDelegate>
{
    double price;
    double maxRebate;
    double rebateValue;
    
    UILabel *rebateLabel;
    UILabel *realPayLabel;
    UITextField *inputTextTield;
    
    NSDictionary *_dict;
    
    BOOL isDouble;
}
@property (nonatomic, strong) UIView *backgroundView;
@end

@implementation PriceAdjustmentView

- (void)dealloc
{
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    _dict = dict;
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self initSubviews:_dict];
    }
    return self;
}

-(UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = self.bounds;
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.3;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBtnClick)];
        [_backgroundView addGestureRecognizer:tap];
    }
    return _backgroundView;
}

- (void)initSubviews:(NSDictionary*)dict
{
    [self addSubview:self.backgroundView];
    isDouble = NO;
    
    price=[validateString([dict objectForKey:@"productPrice"]) doubleValue];
    maxRebate=[validateString([dict objectForKey:@"rebates"]) doubleValue];
    rebateValue=0.0f;
    
    CGFloat kMargin = 42.5*layoutBy6();
    CGFloat mainWidth = self.frame.size.width-kMargin*2;
    CGFloat mainHeight = 271*layoutBy6();
    CGFloat margin = 20*layoutBy6();
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(kMargin, (self.frame.size.height-mainHeight)/2, mainWidth, mainHeight)];
    mainView.backgroundColor=[UIColor whiteColor];
    mainView.layer.cornerRadius=2;
    [self addSubview:mainView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 50*layoutBy6())];
    titleLabel.backgroundColor=hexStringToColor(@"E52951");
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font=[UIFont systemFontOfSize:18];
    titleLabel.text=@"调价发给好友";
    [mainView addSubview:titleLabel];
    
    UIImageView *productIV=[[UIImageView alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(titleLabel.frame)+25*layoutBy6(), 70*layoutBy6(), 70*layoutBy6())];
    [productIV sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"productImage_300_300"]] placeholderImage:[UIImage imageNamed:@"DefaultImage"]];
    productIV.layer.cornerRadius=2;
    productIV.backgroundColor=hexStringToColor(@"D8D8D8");
    [mainView addSubview:productIV];
    
    UILabel *productTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(productIV.frame)+10*layoutBy6(), CGRectGetMinY(productIV.frame), mainWidth-70*layoutBy6()-margin*2-10*layoutBy6(), 35*layoutBy6())];
    productTitleLabel.numberOfLines=0;
    productTitleLabel.text=validateString([dict objectForKey:@"productName"]);
    productTitleLabel.font=[UIFont systemFontOfSize:14*layoutBy6()];
    productTitleLabel.textColor=hexStringToColor(@"222222");
    [mainView addSubview:productTitleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(productTitleLabel.frame), CGRectGetMaxY(productTitleLabel.frame), CGRectGetWidth(productTitleLabel.frame)-70*layoutBy6(), 17.5*layoutBy6())];
    priceLabel.text=[NSString stringWithFormat:@"¥%.2f",price];
    priceLabel.font=[UIFont systemFontOfSize:14*layoutBy6()];
    priceLabel.textColor=hexStringToColor(@"222222");
    [mainView addSubview:priceLabel];
    
    rebateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(productTitleLabel.frame), CGRectGetMaxY(priceLabel.frame), CGRectGetWidth(priceLabel.frame), CGRectGetHeight(priceLabel.frame))];
    rebateLabel.text=[NSString stringWithFormat:@"返利:%.2f元",maxRebate];
    rebateLabel.font=[UIFont systemFontOfSize:14*layoutBy6()];
    rebateLabel.textColor=hexStringToColor(@"222222");
    [mainView addSubview:rebateLabel];
    
    inputTextTield = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame), CGRectGetMinY(priceLabel.frame), 70*layoutBy6(), 35*layoutBy6())];
    inputTextTield.font=[UIFont systemFontOfSize:14*layoutBy6()];
    inputTextTield.textColor=hexStringToColor(@"222222");
    inputTextTield.layer.borderColor=hexStringToColor(@"222222").CGColor;
    inputTextTield.keyboardType =  UIKeyboardTypeDecimalPad;
    inputTextTield.textAlignment = NSTextAlignmentCenter;
    inputTextTield.layer.borderWidth=0.5;
    inputTextTield.layer.cornerRadius=2;
    inputTextTield.delegate=self;
    inputTextTield.placeholder=@"0.00";
    [mainView addSubview:inputTextTield];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickDoneAction) name:UITextFieldTextDidChangeNotification object:nil];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(inputTextTield.frame)+margin/2, mainWidth-margin*2, 0.5)];
    line.backgroundColor=hexStringToColor(@"dddddd");
    [mainView addSubview:line];
    
    realPayLabel.textColor=hexStringToColor(@"222222");
    realPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(line.frame)+margin/2, mainWidth-margin*2, 20*layoutBy6())];
    realPayLabel.textAlignment=NSTextAlignmentRight;
    realPayLabel.font=[UIFont systemFontOfSize:14*layoutBy6()];
    [mainView addSubview:realPayLabel];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"买家实付:%.2f元",price]];
    [str addAttribute:NSForegroundColorAttributeName value:hexStringToColor(@"E52951") range:NSMakeRange(5,str.length-5)];
    realPayLabel.attributedText = str;
    
    UILabel *descrLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(realPayLabel.frame), mainWidth-margin*2, 20*layoutBy6())];
    descrLabel.text=[NSString stringWithFormat:@"该商品可调价0-%.2f",maxRebate];
    descrLabel.textAlignment=NSTextAlignmentRight;
    descrLabel.font=[UIFont systemFontOfSize:12*layoutBy6()];
    descrLabel.textColor=hexStringToColor(@"9B9B9B");
    [mainView addSubview:descrLabel];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame=CGRectMake(margin, CGRectGetMaxY(descrLabel.frame)+margin/2, (mainWidth-3*margin)/2, 40*layoutBy6());
    cancelBtn.backgroundColor=hexStringToColor(@"eeeeee");
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:18*layoutBy6()]];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:hexStringToColor(@"333333") forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius=2;
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.frame=CGRectMake(CGRectGetMaxX(cancelBtn.frame)+margin, CGRectGetMaxY(descrLabel.frame)+margin/2, (mainWidth-3*margin)/2, 40*layoutBy6());
    confirmBtn.backgroundColor=hexStringToColor(@"E52951");
    [confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:18*layoutBy6()]];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius=2;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:confirmBtn];
}

-(void)cancelBtnClick
{
    [self removeFromSuperview];
}

-(void)confirmBtnClick
{
    if (rebateValue > maxRebate) {
        AlertWithMessage([NSString stringWithFormat:@"最多只能优惠%.2f元",maxRebate]);
        return;
    }
    
    if(self.delegate!=nil &&[self.delegate respondsToSelector:@selector(didChangePrice:)])
    {
        [self.delegate didChangePrice:rebateValue];
    }
    
    [self removeFromSuperview];
}

//文本框委托代理
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame=CGRectMake(0, -100, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0)
    {
        if ([textField.text containsString:@"."]&&[textField.text componentsSeparatedByString:@"."][1].length==0)
        {
            isDouble=NO;
        }
        return YES;
    }
    
    if (isDouble&&[string isEqualToString:@"."]) {
        return NO;
    }
    if (isDouble&&[textField.text componentsSeparatedByString:@"."][1].length==2) {
        return NO;
    }
    
    if (![textField.text containsString:@"."]&&[string isEqualToString:@"."]) {
        if (textField.text.length==0) {
            textField.text=@"0";
        }
        isDouble = YES;
    }
    else if (![textField.text containsString:@"."])
    {
        isDouble = NO;
    }

    return YES;
}

-(void)clickDoneAction
{
    rebateValue=[inputTextTield.text doubleValue];
    
    if (rebateValue>maxRebate)
    {
        AlertWithMessage([NSString stringWithFormat:@"最多只能优惠%.2f元",maxRebate]);
        inputTextTield.text=[NSString stringWithFormat:@"%.2f", maxRebate];
        rebateValue=maxRebate;
    }
    if (rebateValue<0) {
        AlertWithMessage(@"不能调价为负数");
        inputTextTield.text=@"0.00";
        rebateValue=0;
    }
    
    rebateLabel.text = [NSString stringWithFormat:@"返利:%.2f元",maxRebate-rebateValue];
    
    //同一行字用不同的颜色表示
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"买家实付:%.2f元",price-rebateValue]];
    [str2 addAttribute:NSForegroundColorAttributeName value:hexStringToColor(@"F02804") range:NSMakeRange(5,str2.length-5)];
    realPayLabel.attributedText = str2;
}

- (void)show
{
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
}
@end
