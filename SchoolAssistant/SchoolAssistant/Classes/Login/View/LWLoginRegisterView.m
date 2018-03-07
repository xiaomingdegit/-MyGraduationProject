//
//  LWLoginRegisterView.m
//  LW
//
//  Created by 刘威 on 2018/1/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWLoginRegisterView.h"
@interface LWLoginRegisterView()

@property (weak, nonatomic) IBOutlet UIButton *loginRegisterButton;

@end

@implementation LWLoginRegisterView
//返回登陆view
+(instancetype)loginView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
//返回注册view
+(instancetype)registerView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //按钮图片拉伸
    UIImage *image = self.loginRegisterButton.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginRegisterButton setBackgroundImage:image forState:UIControlStateNormal];
}

@end
