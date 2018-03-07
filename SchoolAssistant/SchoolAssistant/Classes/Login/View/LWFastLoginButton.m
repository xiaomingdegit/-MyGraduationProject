//
//  LWFastLoginButton.m
//  LW
//
//  Created by 刘威 on 2018/1/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWFastLoginButton.h"

@implementation LWFastLoginButton

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.lw_y = 0;
    self.imageView.lw_centerX = self.lw_width * 0.5;
    [self.titleLabel sizeToFit];
    self.titleLabel.lw_y = self.lw_height - self.titleLabel.lw_height;
    self.titleLabel.lw_centerX = self.lw_width * 0.5;
}

@end
