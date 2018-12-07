//
//  PosterVC.m
//  小移云店
//
//  Created by vivian on 2017/6/9.
//  Copyright © 2017年 vivian. All rights reserved.
//

#import "PosterVC.h"

#import "LoginShop.h"
//生成二维码,支持iOS7.0以上
#import <CoreImage/CoreImage.h>
#import "UIImage+LXDCreateBarcode.h"

@interface PosterVC ()
@property(nonatomic,strong) UIScrollView *myScroll;

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *titleLab;
@property(nonatomic,strong) UILabel *priceLab;
@property(nonatomic,strong) UIView *qrView;
@property(nonatomic,strong) UIImageView *qrImgV;
@property(nonatomic,strong) UILabel *qrLab;
@property(nonatomic,strong) UIView *iconView;
@property(nonatomic,strong) UIImageView *iconImgV;

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation PosterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"海报";
    [self createBody];
    
    [self showPosterData:self.model];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    self.model.shareImage = [self captureImageFromView:self.bgView];
    self.model.image300300 = nil;//要把图片url置为nil
    //    [[ShareSDKManager shareInstanceShareSDKManager] showSharePosterByModel:self.model];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [[ShareSDKManager shareInstanceShareSDKManager] hideOrShowPosterView];
}

#pragma mark - button click
- (void)shareBtnAction {
    [[ShareSDKManager shareInstanceShareSDKManager] showSharePosterByModel:self.model];
}

- (void)saveBtnAction {
    UIImage *image =  [self captureImageFromView:self.bgView];// [UIImage imageWithData:self.imgV.image]; // 取得图片
    
    
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        if (image) {
            [SGInfoAlert showInfo:@"保存成功"];
            
        }else {
            [SGInfoAlert showInfo:@"保存失败"];
            
        }
    }else{
        if (image) {
            [SGInfoAlert showInfo:@"用户无权限,保存失败" ];
        }
    }
}

//对某个view进行截图
-(UIImage *)captureImageFromView:(UIView *)view {
    CGRect screenRect = [view bounds];
    CGFloat scale = 1.0;
    if ([[UIScreen mainScreen]respondsToSelector:@selector(scale)]) {
        CGFloat tmp = [[UIScreen mainScreen]scale];
        if (tmp > 1.5) {
            scale = 2.0;
        }
        if (tmp > 2.5) {
            scale=3.0;
        }
    }
    if (scale > 1.5) {
        UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, scale);
    } else {
        UIGraphicsBeginImageContext(screenRect.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark --海报分享数据渲染
-(void)showPosterData:(ShareModel*)model{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.shareImageUrl]];
    self.titleLab.text = model.shareTitle;
    
    //生成二维码
    LoginShop *shop = [AppSingleton shareSingleton].loginData.shop;
    NSString *imgUrl = shop.logo;
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,35, 35)];
    
    [imgV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"180"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIImage * img = [UIImage imageOfQRFromURL:model.shareUrl codeSize: 1000 red: 0 green: 0 blue: 0 insertImage: image roundRadius: 5.0f];
        self.qrImgV.image = img;
    }];
    
    [self.view addSubview:imgV];
}

#pragma mark -- UI
-(void)createBody{
    
    self.view.backgroundColor = hexStringToColor(@"FFFFFF");
    [self.view addSubview:self.myScroll];
    [self.myScroll addSubview:self.bgView];
    [self.bgView addSubview:self.imgV];
    [self.bgView addSubview:self.titleLab];
//    [self.bgView addSubview:self.priceLab];
    [self.bgView addSubview:self.qrView];
    [self.qrView addSubview:self.qrImgV];
    [self.bgView addSubview:self.qrLab];
    [self.bgView addSubview:self.iconImgV];
//    [self.iconView addSubview:self.iconImgV];
    
    [self.myScroll addSubview:self.saveBtn];
    [self.myScroll addSubview:self.shareBtn];
    
    [_qrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_qrImgV);
        make.top.mas_equalTo(_qrImgV.bottom).mas_offset(10*layoutBy6());
        make.width.mas_equalTo(85*layoutBy6());
        make.height.mas_offset(10*layoutBy6());
    }];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-85*layoutBy6()-iPhoneX_Bottom);
        make.centerX.equalTo(self.view);
        make.height.equalTo(75*layoutBy6() / 2);
        make.width.equalTo(544*layoutBy6() / 2);
    }];
    
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_saveBtn.bottom).offset(15);
        make.centerX.equalTo(_saveBtn);
        make.height.width.equalTo(_saveBtn);
    }];
}

-(UIScrollView*)myScroll{
    if (!_myScroll) {
        _myScroll = [[UIScrollView alloc]init];
        _myScroll.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        _myScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 550*layoutBy6());
        _myScroll.backgroundColor = [UIColor clearColor];
    }
    return _myScroll;
}

-(UIView*)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(15*layoutBy6(), 15*layoutBy6(), SCREEN_WIDTH-30*layoutBy6(), 455*layoutBy6())];
        _bgView.backgroundColor = hexStringToColor(@"F1F1F1");
        _bgView.layer.cornerRadius = 8*layoutBy6();
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

-(UIImageView*)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc]init];
        CGFloat width = 320*layoutBy6();
        _imgV.frame = CGRectMake(0, 0, CGRectGetWidth(_bgView.frame), width);
//        _imgV.backgroundColor = hexStringToColor(@"123456");
    }
    return _imgV;
}

-(UILabel*)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20*layoutBy6(), CGRectGetMaxY(self.imgV.frame)+15*layoutBy6(), 198*layoutBy6(), 45*layoutBy6())];
        _titleLab.font = [UIFont systemFontOfSize:15*layoutBy6()];
        _titleLab.textColor = hexStringToColor(@"646464");
        _titleLab.numberOfLines = 2;
        _titleLab.text = @"";
    }
    return _titleLab;
}

-(UILabel*)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.imgV.frame), CGRectGetMaxY(self.titleLab.frame)+10*layoutBy6(), 198*layoutBy6(), 20*layoutBy6())];
        _priceLab.font = [UIFont systemFontOfSize:15*layoutBy6()];
        _priceLab.textColor = hexStringToColor(@"F57623");
        _priceLab.text = @"";
    }
    return _priceLab;
}

-(UIView*)qrView{
    if (!_qrView) {
        CGFloat width = 85*layoutBy6();
        _qrView = [[UIView alloc]initWithFrame:CGRectMake(240*layoutBy6(), CGRectGetMaxY(self.imgV.frame) + 15*layoutBy6(), width, width)];
        _qrView.backgroundColor = [UIColor whiteColor];
        _qrView.layer.shadowOffset = CGSizeMake(0, 1);
        _qrView.layer.shadowColor = hexStringToColor(@"8C8C8C").CGColor;
        _qrView.layer.shadowOpacity = 0.57;
    }
    return _qrView;
}

-(UIImageView*)qrImgV{
    if (!_qrImgV) {
        _qrImgV = [[UIImageView alloc]init];
        CGFloat width = 75*layoutBy6();
        _qrImgV.frame = CGRectMake(5*layoutBy6(), 5*layoutBy6(), width, width);
        _qrImgV.backgroundColor = [UIColor clearColor];
    }
    return _qrImgV;
}

-(UILabel*)qrLab{
    if (!_qrLab) {
        _qrLab = [[UILabel alloc]init];
        _qrLab.font = [UIFont systemFontOfSize:9*layoutBy6()];
        _qrLab.textColor = hexStringToColor(@"6F6F6F");
        _qrLab.text = @"长按或扫描直接办理";
        _qrLab.textAlignment = 1;
    }
    return _qrLab;
}

-(UIView*)iconView{
    if (!_iconView) {
        _iconView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bgView.frame)-50*layoutBy6(), CGRectGetWidth(self.bgView.frame), 50*layoutBy6())];
        _iconView.backgroundColor = hexStringToColor(@"f2f2f2");
    }
    return _iconView;
}


-(UIImageView*)iconImgV{
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc]init];
        _iconImgV.frame = CGRectMake(20*layoutBy6(), CGRectGetMaxY(self.imgV.frame) + 90*layoutBy6(), 140*layoutBy6(), 18*layoutBy6());
        _iconImgV.image = [UIImage imageNamed:@"poster_logo1"];
    }
    return _iconImgV;
}

#pragma mark - lazy load
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton new];
        _shareBtn.backgroundColor = [UIColor whiteColor];
        _shareBtn.layer.borderColor = hexStringToColor(@"0084CF").CGColor;
        _shareBtn.layer.borderWidth = 1;
        _shareBtn.layer.cornerRadius = 3;
        _shareBtn.layer.masksToBounds = YES;
        [_shareBtn setTitle:@"分享" forState:0];
        [_shareBtn setTitleColor:hexStringToColor(@"0084CF") forState:0];
        [_shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton new];
        _saveBtn.backgroundColor = hexStringToColor(@"0084CF");
        _saveBtn.layer.cornerRadius = 3;
        _saveBtn.layer.masksToBounds = YES;
        [_saveBtn setTitle:@"保存" forState:0];
        [_saveBtn setTitleColor:hexStringToColor(@"FFFFFF") forState:0];
        [_saveBtn addTarget:self action:@selector(saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

@end
