//
//  RootViewController.h
//  HappyDoctorDoctor
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 胡小羊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController

/**
 *  菊花过渡动画
 *
 *  @param str  过渡动画的文字
 *  @param view 显示位置
 */
- (void)upLoadPersonalInfoWith:(NSString *)str;
/**
 *  黑底提示信息
 *
 *  @param message 显示的提示信息
 *  @param view    显示位置
 */
- (void)toast:(NSString*)message;

/**
 *  创建alertView，展示提示信息
 */
- (void)disPlayAlertViewWithString:(NSString *)str;

/**
 *  判断网络连接状态
 */
- (NSString *)getNetWorkStates;

@end
