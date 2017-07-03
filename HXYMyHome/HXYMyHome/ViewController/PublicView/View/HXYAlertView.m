//
//  HXYAlertView.m
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/23.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import "HXYAlertView.h"

#define MARGIN_X 40//提示框距屏幕边沿的宽度

@implementation HXYAlertView
- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScrW, ScrH)];
        backView.backgroundColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:0.50f];
        self.backView = backView;
        [self addSubview:self.backView];
        
        UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(MARGIN_X, 100, ScrW - MARGIN_X *2, 300)];
        alertView.backgroundColor = [UIColor redColor];
        alertView.layer.cornerRadius = 2;
        self.alertView = alertView;
        [self addSubview:alertView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissEvent)];
        [self.backView addGestureRecognizer:tap];
        
    }
    return  self;
}

- (void)layoutSubviews{

    [super layoutSubviews ];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.alertView.frame.size.width, 30)];
    titleLab.backgroundColor  = [UIColor purpleColor];
    titleLab.text = self.titleStr;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = [UIColor whiteColor];
    [self.alertView addSubview:titleLab];
    
    UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLab.frame), self.alertView.frame.size.width - 20 , 100)];
    contentLab.backgroundColor = [UIColor orangeColor];
    contentLab.text = self.contentStr;
    contentLab.numberOfLines = 0;
    contentLab.font = [UIFont systemFontOfSize:18];
    CGSize labSize = [self calculateSizeWithText:contentLab.text andMaxSizeWidth:contentLab.frame.size.width andFont:contentLab.font];
    contentLab.frame = CGRectMake(contentLab.frame.origin.x, contentLab.frame.origin.y, labSize.width, labSize.height);
    [self.alertView addSubview:contentLab];
    
    //按钮Y方向上与控件的间距
    CGFloat BTN_MARGIN_Y = 10;
    //按钮间X方向间距
    CGFloat BTN_MARGIN = 5;
    //按钮的宽度
    CGFloat BTN_W = (self.alertView.frame.size.width - BTN_MARGIN *(self.btnArr.count*2))/self.btnArr.count;
    //按钮的高度
    CGFloat BTN_H = 40;
    //循环创建按钮
    for (int i = 0; i <self.btnArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(BTN_MARGIN +(BTN_MARGIN *2 + BTN_W ) *i , CGRectGetMaxY(contentLab.frame) +BTN_MARGIN_Y, BTN_W, BTN_H);
        btn.tag = 10 +i;
        [btn setTitle:[self.btnArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [btn setBackgroundColor:[UIColor whiteColor]];
        }else{
            [btn setBackgroundColor:[UIColor greenColor]];
        }
        
        [self.alertView addSubview:btn];
    }
    
    //提示框底部边沿的边距
    CGFloat ALERT_Y = 10;
    CGFloat ALERT_H = CGRectGetMaxY(contentLab.frame) + BTN_MARGIN_Y + BTN_H +ALERT_Y ;
    self.alertView.frame = CGRectMake(self.alertView.frame.origin.x, ScrH/2 - ALERT_H/2  - 64, self.alertView.frame.size.width, ALERT_H);
}

- (void)setAlertViewTitleWithTitle:(NSString *)titleStr andContent:(NSString *)contentStr andBtnArr:(NSArray *)btnArr{

    self.titleStr = titleStr;
    self.contentStr = contentStr;
    self.btnArr = [NSArray arrayWithArray:btnArr];

}

//销毁该页面
- (void)dismissEvent{

    [UIView animateWithDuration:.3 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.backView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)btnClick:(UIButton *)btn{
    
    
    //让代理去执行事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(HXYAlertViewBtnClick:)]) {
        [self dismissEvent];
        [self.delegate HXYAlertViewBtnClick:btn];
    }
}

//计算lab的尺寸
- (CGSize)calculateSizeWithText:(NSString *)text andMaxSizeWidth:(CGFloat )maxWidth andFont:(UIFont *)font{

    CGSize Size = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return Size;
}

@end
