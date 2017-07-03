//
//  HXYAlertView.h
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/23.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理声明
@protocol HXYAlertViewDelegate <NSObject>
//代理方法
-(void)HXYAlertViewBtnClick:(UIButton *)btn;

@end

@interface HXYAlertView : UIView
//标题
@property (nonatomic, strong)NSString *titleStr;
//内容
@property (nonatomic, strong)NSString *contentStr;
//按键
@property (nonatomic, strong)NSArray *btnArr;
//代理
@property (nonatomic,strong)id<HXYAlertViewDelegate>delegate;
//背景
@property (nonatomic ,strong)UIView *backView;
//AlertView
@property (nonatomic ,strong)UIView *alertView;

//设置提示框的内容
- (void)setAlertViewTitleWithTitle:(NSString *)titleStr andContent:(NSString *)contentStr andBtnArr:(NSArray *)btnArr;

@end
