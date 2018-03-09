//
//  ZSKLoginButton.h
//  SchoolAssistant
//
//  Created by  庄少坤 on 2018/3/9.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import <UIKit/UIKit.h>

//
typedef void(^finishBlock)(void);

@interface ZSKLoginButton : UIView

@property (nonatomic,copy) finishBlock translateBlock;

@end
