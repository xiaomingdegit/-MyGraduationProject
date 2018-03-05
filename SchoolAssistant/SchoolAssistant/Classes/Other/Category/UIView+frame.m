//
//  UIView+frame.m
//  LW
//
//  Created by 刘威 on 2018/1/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)

-(void)setLw_x:(CGFloat)lw_x{
    CGRect rect = self.frame;
    rect.origin.x = lw_x;
    self.frame = rect;
}

-(CGFloat)lw_x{
    return self.frame.origin.x;
}

-(void)setLw_y:(CGFloat)lw_y{
    CGRect rect = self.frame;
    rect.origin.y = lw_y;
    self.frame = rect;
}

-(CGFloat)lw_y{
    return self.frame.origin.y;
}

-(void)setLw_width:(CGFloat)lw_width{
    CGRect rect = self.frame;
    rect.size.width = lw_width;
    self.frame = rect;
}

-(CGFloat)lw_width{
    return self.frame.size.width;
}

-(void)setLw_height:(CGFloat)lw_height{
    CGRect rect = self.frame;
    rect.size.height = lw_height;
    self.frame = rect;
}

-(CGFloat)lw_height{
    return self.frame.size.height;
}

-(void)setLw_centerX:(CGFloat)lw_centerX{
    CGPoint center = self.center;
    center.x = lw_centerX;
    self.center = center;
}

-(CGFloat)lw_centerX{
    return self.center.x;
}

-(void)setLw_centerY:(CGFloat)lw_centerY{
    CGPoint center = self.center;
    center.y = lw_centerY;
    self.center = center;
}

-(CGFloat)lw_centerY{
    return self.center.y;
}


@end
