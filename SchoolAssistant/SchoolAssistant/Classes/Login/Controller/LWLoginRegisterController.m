//
//  LWLoginRegisterController.m
//  LW
//
//  Created by 刘威 on 2018/1/28.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWLoginRegisterController.h"
#import "LWLoginRegisterView.h"
#import "LWFastLoginView.h"

@interface LWLoginRegisterController ()
@property (weak, nonatomic) IBOutlet UIView *middelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middelViewConstraints;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation LWLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加登陆view
    LWLoginRegisterView *loginView = [LWLoginRegisterView loginView];
    [self.middelView addSubview:loginView];
    //添加注册view
    LWLoginRegisterView *registerView = [LWLoginRegisterView registerView];
    [self.middelView addSubview:registerView];
    //添加fastLoginView
    LWFastLoginView *fastLoginView = [LWFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
}

-(void)viewDidLayoutSubviews{
    //设置loginView的frame
    UIView *loginView = self.middelView.subviews.firstObject;
    loginView.frame = CGRectMake(0, 0, self.middelView.lw_width * 0.5, self.view.lw_height);
    //设置registerView的frame
    UIView *registerView = self.middelView.subviews.lastObject;
    registerView.frame = CGRectMake(self.middelView.lw_width * 0.5, 0, self.middelView.lw_width * 0.5, self.view.lw_height);
    //设置fastView的frame
    UIView *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = CGRectMake(0, 0, self.bottomView.lw_width, self.bottomView.lw_height);
}

- (IBAction)closeClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerClick:(UIButton *)sender {
    //修改按钮状态
    sender.selected = !sender.selected;
    //修改middelView的约束
    self.middelViewConstraints.constant = sender.selected ? -self.view.lw_width : 0;
    [UIView animateWithDuration:0.35 animations:^{
        //更具修改的约束重新布局
        [self.view layoutIfNeeded];
    }];
}

//设置白色状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
