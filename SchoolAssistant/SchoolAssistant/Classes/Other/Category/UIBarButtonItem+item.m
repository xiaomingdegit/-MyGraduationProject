//
//  UIBarButtonItem+item.m
//  LW
//
//  Created by 刘威 on 2018/1/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+(instancetype)itemWithImageName:(NSString *)imageName clickImageName:(NSString *)clickImageName addTarget:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:clickImageName] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(instancetype)itemWithImageName:(NSString *)imageName selectImageName:(NSString *)selectImageName addTarget:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(instancetype)backItemWithImageName:(NSString *)imageName clickImageName:(NSString *)clickImageName addTarge:(id)target action:(SEL)action title:(NSString *)title{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:clickImageName] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //button 内容向左移动20个像素
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
