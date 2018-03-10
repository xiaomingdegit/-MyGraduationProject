//
//  LWTabBarController.m
//  LW
//
//  Created by 刘威 on 2018/1/19.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "LWTabBarController.h"
#import "LWChatsController.h"
#import "LWContactsController.h"
#import "LWStudyController.h"
#import "LWDiscoverController.h"
#import "LWMeController.h"

#import "UIImage+render.h"

#import "LWTabBar.h"
#import "LWNavigationController.h"

@interface LWTabBarController ()

@end

@implementation LWTabBarController

////load方法只掉用一次
//+(void)load{
//    //通过appearance设置tabBarItem属性
//    UITabBarItem *item = [UITabBarItem appearance];
//    //设置tabbarItem字体大小 只能在UIControlStateNormal状态下设置
//    [item setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
//    //设置tabBarItem字体选中状态下颜色
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //替换系统tabBar
    [self setTabBar];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    //设置子控制器
    [self setAllController];
}


- (void)setTabBar{
    LWTabBar *tabBar = [[LWTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)setAllController{
    //保存每个controller信息
    NSArray *infoArray = @[
  @{@"controllerName":@"LWChatsController",@"title":@"回话",@"imageName":@"tabBar_essence_icon",@"clickImageName":@"tabBar_essence_click_icon"},
  @{@"controllerName":@"LWContactsController",@"title":@"联系人",@"imageName":@"tabBar_friendTrends_icon",@"clickImageName":@"tabBar_friendTrends_click_icon"},
  @{@"controllerName":@"LWDiscoverController",@"title":@"发现",@"imageName":@"tabBar_new_click_icon",@"clickImageName":@"tabBar_new_click_icon"},
  @{@"controllerName":@"LWMeController",@"title":@"我",@"imageName":@"tabBar_me_icon",@"clickImageName":@"tabBar_me_click_icon"}
  ];
    //遍历infoArray 创建子控制器
    NSMutableArray *controllerArray = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSDictionary *info in infoArray) {
        UIViewController *viewController = [self controllerWithInfo:info];
        [controllerArray addObject:viewController];
    }
    //设置tabBarController的子控制器
    self.viewControllers = controllerArray;
}

//设置每一个Controller
- (UIViewController *)controllerWithInfo:(NSDictionary *)info{
    Class cls = NSClassFromString(info[@"controllerName"]);
    UIViewController *viewController = [[cls alloc] init];
   // viewController.tabBarItem.title = info[@"title"];
    viewController.title = info[@"title"];
    viewController.tabBarItem.image = [UIImage imageNamed:info[@"imageName"]];
    //设置tabBar选中图片
    viewController.tabBarItem.selectedImage = [UIImage imageOriginalNamed:info[@"clickImageName"]];
    //设置tabBarItem字体大小 只能在UIControlStateNormal状态下设置
    [viewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
    //设置tabBarItem字体颜色
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    return [[LWNavigationController alloc] initWithRootViewController:viewController];
}

@end
