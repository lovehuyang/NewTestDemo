//
//  RootViewController.m
//  HappyDoctorDoctor
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 胡小羊. All rights reserved.
//

#import "RootViewController.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    self.view.backgroundColor = BGCOLOR;
}

/**
 *  菊花过渡动画
 *
 *  @param str  过渡动画的文字
 *  @param view 显示位置
 */
- (void)upLoadPersonalInfoWith:(NSString *)str
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = str;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/**
 *  黑底提示信息
 *
 *  @param message 显示的提示信息
 *  @param view    显示位置
 */
- (void)toast:(NSString*)message
{
//    [MBProgressHUD hideHUDForView:self.view animated:YES];
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0];
}

/**
 *  创建alertView，展示提示信息
 */
- (void)disPlayAlertViewWithString:(NSString *)str
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

/**
 *  判断网络连接状态
 */
- (NSString *)getNetWorkStates
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                {
                    state =  @"wifi";
                    break;
                default:
                    break;
                }
            }
        }
        //根据状态选择
    }
    return state;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
