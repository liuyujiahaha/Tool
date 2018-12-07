//
//  RankingCustomBtn.m
//  直销通2.8.0
//
//  Created by blues on 16/3/21.
//  Copyright © 2016年 jun. All rights reserved.
//

#import "TopBCustomBtn.h"


@implementation TopBCustomBtn

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    return self.titFrame;
}

-(void)setContentFrame:(CGRect)frame{
    self.titFrame = frame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return self.imgFrame;
}

-(void)setImageFrame:(CGRect)frame{
    self.imgFrame = frame;
}


@end
