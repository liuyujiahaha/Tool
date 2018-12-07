//
//  PriceAdjustmentView.h
//  lnyp
//
//  Created by MacBookPro on 16/1/9.
//  Copyright © 2016年 VP. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PriceAdjustmentDelegate <NSObject>

-(void)didChangePrice:(double)rebate;

@end

@interface PriceAdjustmentView : UIView
@property (nonatomic,assign) id<PriceAdjustmentDelegate> delegate;

@property (nonatomic,assign) BOOL flag;//点击显示隐藏调价视图

- (id)initWithDictionary:(NSDictionary*)dict;

- (void)show;
@end
