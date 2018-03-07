//
//  LWFastView.m
//  LW
//
//  Created by 刘威 on 2018/1/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWFastLoginView.h"

@implementation LWFastLoginView

+(instancetype)fastLoginView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
