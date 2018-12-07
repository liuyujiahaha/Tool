//
//  RankingCustomBtn.h
//  直销通2.8.0
//
//  Created by blues on 16/3/21.
//  Copyright © 2016年 jun. All rights reserved.
//

#import <UIKit/UIKit.h>

//已完成销售目标中自定义button
@interface TopBCustomBtn : UIButton
@property(nonatomic,assign)CGRect imgFrame;
@property(nonatomic,assign)CGRect titFrame;

-(void)setImageFrame:(CGRect)frame;
-(void)setContentFrame:(CGRect)frame;
@end
