//
//  HGImageShowViewController.h
//  HighGoApp
//  图片查看 视图控制器
//  Created by zhongxing on 16/4/2.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGImageShowViewController : UIViewController


//显示图片下标的Lable
@property (nonatomic, strong) UILabel *indexLabel;

//装日志图片的数组
@property (nonatomic, strong) NSMutableArray *imageArray;

//点击第几张图片
@property (nonatomic, assign) NSInteger index;

//占位图片
@property (nonatomic, strong) UIImage *placeholderImage;

@end


