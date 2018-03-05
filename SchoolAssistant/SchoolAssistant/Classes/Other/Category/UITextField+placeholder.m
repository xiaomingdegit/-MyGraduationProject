//
//  UITextField+placeholder.m
//  LW
//
//  Created by 刘威 on 2018/1/31.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "UITextField+placeholder.h"
#import <objc/runtime.h>

@implementation UITextField (placeholder)

+(void)load{
    Method setPlaceHolder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method lw_setPlaceHolder = class_getInstanceMethod(self, @selector(lw_setPlaceholder:));
    method_exchangeImplementations(setPlaceHolder, lw_setPlaceHolder);
}

-(void)setPlaceholdColor:(UIColor *)placeholdColor{
    objc_setAssociatedObject(self, @"placeholdColor", placeholdColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholdColor;
}

-(UIColor *)placeholdColor{
    return objc_getAssociatedObject(self, @"placeholdColor");
}

-(void)lw_setPlaceholder:(NSString *)placeholder{
    [self lw_setPlaceholder:placeholder];
    self.placeholdColor = self.placeholdColor;
}

@end
