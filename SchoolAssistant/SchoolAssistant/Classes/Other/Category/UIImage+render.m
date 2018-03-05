//
//  UIImage+render.m
//  LW
//
//  Created by 刘威 on 2018/1/19.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "UIImage+render.h"

@implementation UIImage (render)
//返回不会被渲染的图片
+(instancetype)imageOriginalNamed:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
