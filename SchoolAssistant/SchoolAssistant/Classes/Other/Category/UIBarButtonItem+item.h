//
//  UIBarButtonItem+item.h
//  LW
//
//  Created by 刘威 on 2018/1/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+(instancetype)itemWithImageName:(NSString *)imageName clickImageName:(NSString *)clickImageName addTarget:(id)target action:(SEL)action;

+(instancetype)itemWithImageName:(NSString *)imageName selectImageName:(NSString *)selImageName addTarget:(id)target action:(SEL)action;

+(instancetype)backItemWithImageName:(NSString *)imageName clickImageName:(NSString *)clickImageName addTarge:(id)target action:(SEL)action title:(NSString *)title;

@end
