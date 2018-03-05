//
//  LWNavigationController.m
//  LW
//
//  Created by 刘威 on 2018/1/21.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWNavigationController.h"

@interface LWNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation LWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条属性
    [self setNavigationBar];
    //用全屏手势替换屏幕边缘手势
    [self setScreenBackGesture];
}

//    NSLog(@"%@",self.interactivePopGestureRecognizer);
//    /*
//     <UIScreenEdgePanGestureRecognizer: 0x7fc104421d70; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fc104410f40>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fc104421c30>)>>
//     */
-(void)setScreenBackGesture{
    //用全屏手势替换屏幕边缘手势 调用系统滑动返回方法
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
    panGestureRecognizer.delegate = self;
    //禁用系统之前手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    //防止左滑触发手势
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    //是否正在页面跳转
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    //防止在根控制器触发手势
    return self.childViewControllers.count == 1 ? NO : YES;
}

-(void)setNavigationBar{
    //设置navigationBar字体属性
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:20]}];
    //设置navigationBar背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   //当push的viewController不是根控制器时
    if (self.childViewControllers.count > 0) {
        //统一设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImageName:@"navigationButtonReturn" clickImageName:@"navigationButtonReturnClick" addTarge:self action:@selector(backClick) title:@"返回"];
        //隐藏底部导航条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//设置返回按钮点击触发的方法
-(void)backClick{
    [self popViewControllerAnimated:YES];
}

@end
