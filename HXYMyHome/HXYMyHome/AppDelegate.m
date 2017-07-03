//
//  AppDelegate.m
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/21.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import "AppDelegate.h"
#import "customNaviController.h"
#import "systemTabbar.h"
#import "LanchViewManger.h"
#import "LanchModel.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    
    if(ScrH > 480){ // 这里以(iPhone4S)为准
        myDelegate.autoSizeScaleX = ScrW/320;
        myDelegate.autoSizeScaleY = ScrH/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self addMainView];
    [self loadLanchView];
    return YES;
}
- (void)addMainView{

    BOOL isLogIn = [[GlobalTools sharedInstance]isInLogIn];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = isLogIn? [[systemTabbar alloc]init]:[[LoginViewController alloc]init ];
    [self.window makeKeyAndVisible];
}

//加载启动页
- (void)loadLanchView{
    
    LanchModel *adModel = [[LanchModel alloc]init];
    adModel.adImgUrl = @"http://d.hiphotos.baidu.com/image/pic/item/f7246b600c3387444834846f580fd9f9d72aa034.jpg";
    adModel.adContentUrl = @"http://www.baidu.com";
    LanchViewManger *lvc = [LanchViewManger lanchViewController];
    lvc.adModel = adModel;
    
    //获取窗口的根视图
    UIViewController *vc = [self.window rootViewController];
    //把启动页加载到根视图上
    [lvc showLanchViewToView:vc.view];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

CG_INLINE CGRect
TS_CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}
@end
