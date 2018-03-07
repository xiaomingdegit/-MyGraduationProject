//
//  LWLoginRegisterField.m
//  LW
//
//  Created by 刘威 on 2018/1/31.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWLoginRegisterField.h"
#import "UITextField+placeholder.h"

@implementation LWLoginRegisterField

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tintColor = [UIColor whiteColor];
    [self addTarget:self action:@selector(editingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(editingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
}

-(void)editingDidBegin{
    self.placeholdColor = [UIColor whiteColor];
}

-(void)editingDidEnd{
    self.placeholdColor = [UIColor grayColor];
}

@end
