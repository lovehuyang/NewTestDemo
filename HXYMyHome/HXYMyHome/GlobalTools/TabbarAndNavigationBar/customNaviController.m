//
//  customNaviController.m
//  HappyDoctorDoctor
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 胡小羊. All rights reserved.
//

#import "customNaviController.h"
#import "UIImage+LYZ.h"

@interface customNaviController ()

@end

@implementation customNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置导航栏按钮主题
 */
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *item = [UIBarButtonItem appearance]; 

    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16.0f];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
    // 自定义系统返回按钮的图片
    UIImage *backButtonImage = [[UIImage imageNamed:@"title_bar_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    [item setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

/**
 *  设置导航栏主题
 */
+ (void)setupNavBarTheme
{
    //设置导航栏文字的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //设置导航栏背景颜色
    [[UINavigationBar appearance] setBackgroundImage:[UIImage createImageWithColor:MAIN_COLOR] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18.0f], NSFontAttributeName, nil]];
    //设置导航栏的颜色
    [[UINavigationBar appearance] setBackgroundColor:MAIN_COLOR];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count>0)
    {
        // 隐藏底部操作栏
        viewController.hidesBottomBarWhenPushed = YES;
    }

    // 修改系统自带返回按钮的文字内容
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    viewController.navigationItem.backBarButtonItem = back;
    
    [super pushViewController:viewController animated:animated];
}

@end
