//
//  HomeViewController.m
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/21.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import "HomeViewController.h"
#import "HXYAlertView.h"

@interface HomeViewController ()<HXYAlertViewDelegate>
@property (nonatomic ,strong)UITableView *tableview;
@end

@implementation HomeViewController
- (instancetype)init{
    self = [super init];
    if(self)
    {
        //导航栏右侧按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarRightBtnClick)];
        //导航栏左侧按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"xiaoxitixing"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarLeftBtnClick)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
   
}

#pragma mark - 懒加载
- (UITableView *)tableview{

    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScrW, ScrH - 64) style:UITableViewStylePlain];
        
    }
    return _tableview;
}

#pragma mark - 点击事件
- (void)navigationBarRightBtnClick {
    
    HXYAlertView *alertView = [[HXYAlertView alloc]initWithFrame:CGRectMake(0, 0, ScrW, ScrH)];
    alertView.delegate =self;
    NSArray *btnArr = @[@"忽略",@"确定",@"取消"];
    [alertView setAlertViewTitleWithTitle:@"提示" andContent:@"1231234123412341234234645767867986796578567899870967787564645867967895874" andBtnArr:btnArr];
    [self.view addSubview:alertView];
}
- (void)navigationBarLeftBtnClick{

    NSLog(@"navigationBarLeftBtnClick");
}
#pragma mark - HXYAlertViewDelegate代理方法
- (void)HXYAlertViewBtnClick:(UIButton *)btn{

    switch (btn.tag) {
        case 10:{
            NSLog(@"代理事件");
            break;
        }
        case 11:{
            NSLog(@"代理事件");
            break;
        }
            
            
        default:
            break;
    }
    
}
@end
