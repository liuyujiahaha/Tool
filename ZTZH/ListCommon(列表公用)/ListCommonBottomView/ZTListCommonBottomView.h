//
//  ZTListCommonBottomView.h
//  ZTStaff
//
//  Created by yujia liu on 2018/11/21.
//  Copyright © 2018 智慧正通. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZTListCommonBottomViewDelegate <NSObject>

-(void)BottomViewRefuseAction;
-(void)BottomViewAgreeAction;

@end
@interface ZTListCommonBottomView : UIView
@property (nonatomic, weak) id<ZTListCommonBottomViewDelegate> delegate;

-(instancetype)initWithLeftName:(NSString *)leftName rightName:(NSString *)rightName;
@end

NS_ASSUME_NONNULL_END
