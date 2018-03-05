//
//  LWTabBar.m
//  LW
//
//  Created by 刘威 on 2018/1/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWTabBar.h"

@interface LWTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation LWTabBar

//懒加载plusButton
-(UIButton *)plusButton{
    if (_plusButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [button sizeToFit];
        [self addSubview:button];
        _plusButton = button;
    }
    return _plusButton;
}

//重新布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //计算每个tabbarButton的宽度
    CGFloat butW = self.lw_width / (self.items.count + 1);
    CGFloat butH = self.lw_height;
    NSInteger i = 0;
    for (UIView *item in self.subviews) {
        if ([item isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //给plusButton预留空格
            if (i == 2) {
                i++;
            }
            CGFloat butX = i * butW;
            item.frame = CGRectMake(butX, 0, butW, butH);
            i++;
        }
    }
    //设置plusButton的Frame属性
    self.plusButton.center = CGPointMake(self.lw_width * 0.5, self.lw_height * 0.5);
}

@end
