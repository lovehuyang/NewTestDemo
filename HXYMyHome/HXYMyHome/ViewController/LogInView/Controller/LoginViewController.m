//
//  LoginViewController.m
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/21.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import "LoginViewController.h"
#import "UserModel.h"
#import "systemTabbar.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField * _userPhone;
    UITextField * _passWord;
    UIButton *_forgetPwdBtn;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
 
    self.title = @"登录";
    
    // 初始化界面子控件
    [self setupUI];
}

/**
 *  界面布局
 */
-(void)setupUI
{
    UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScrW, ScrH)];
    background.image = [UIImage imageNamed:@""];
    background.userInteractionEnabled = YES;
    [self.view addSubview:background];
    
    // 白色背景view的位置及宽高
    CGFloat backViewX = 50.0f;
    CGFloat backViewY = 213.0f;
    CGFloat backViewWidth = 375 - 2 * backViewX;
    CGFloat backViewHeight = 118.0f;
    
    // 白色背景view
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(backViewX, backViewY, backViewWidth, backViewHeight)];
    [background addSubview:backView];
    
    // 输入框左部图片数组及占位文本数组
    NSArray *placeHolder_Array = @[@"手机号码",@"密码"];
    
    // 输入框的位置及宽高
    CGFloat tfX = 0.0f;
    CGFloat tfHeight = backViewHeight * 0.5f;
    for(int i=0; i<2; i++)
    {
        CGFloat tfY = backViewHeight * 0.5f * i;
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(tfX, tfY, backViewWidth, tfHeight)];
        tf.placeholder = [placeHolder_Array objectAtIndex:i];

        if(i==0)
        {
            _userPhone = tf;
            _userPhone.keyboardType = UIKeyboardTypeNumberPad;
        }
        else
        {
            _passWord = tf;
            _passWord.secureTextEntry = YES;
            _passWord.rightView = [self addRightView];
            _passWord.rightViewMode = UITextFieldViewModeAlways;
            
        }
        [backView addSubview:tf];
    }
    
    
    // 创建"登录"按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame =CGRectMake(47 , 389 , ScrW - 94 , 43.0f );
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor redColor]];
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.adjustsImageWhenHighlighted = NO;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:loginBtn];
    
    // 创建“忘记密码”按钮
    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _forgetPwdBtn.frame = CGRectMake(269, 352, 57.0f, 20.0f);
    [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    _forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    _forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    // 标题颜色
    [_forgetPwdBtn setTitleColor:RGB(252,103,14) forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:_forgetPwdBtn];
    
    UIImageView * arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(152, 494, 71, 88 )];
//    arrowImageView.image = YZGetImage(@"VectorIntelligentObject");
    [background addSubview:arrowImageView];
    
    UIButton * registeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registeButton.frame = CGRectMake(137 , 590 , 101 , 20);
    [registeButton setTitle:@"还没账号？ 立即注册" forState:UIControlStateNormal];
    registeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [registeButton setTitleColor:RGB(172,172,172) forState:UIControlStateNormal];
    [registeButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:registeButton];
    
    UIView * lineView3 = [[UIView alloc]initWithFrame:CGRectMake(registeButton.frame.origin.x, CGRectGetMaxY(registeButton.frame) + 3 , CGRectGetWidth(registeButton.frame), 1)];
    lineView3.backgroundColor = RGB(172,172,172);
    [background addSubview:lineView3];
    
    
}
-(UIView *)addRightView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 33)];
    //    view.backgroundColor = [UIColor blueColor];
    view.userInteractionEnabled = YES;
    
    UIButton * seePasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    seePasswordButton.frame = CGRectMake(0 , 11 , 22 , 11 );
    [seePasswordButton setBackgroundImage:[UIImage imageNamed:@"yanjing"] forState:UIControlStateNormal];
    [seePasswordButton addTarget:self action:@selector(seePasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:seePasswordButton];
    return  view;
}
-(void)registerButtonClick
{
//    JYRegisterViewController * rvc = [[JYRegisterViewController alloc]init];
//    [self.navigationController pushViewController:rvc animated:YES];
}
-(void)seePasswordButtonClick
{
    _passWord.secureTextEntry = !_passWord.secureTextEntry;
}

/**
 *  “登录”按钮的点击事件
 */
-(void)loginBtnClick
{
    // 结束编辑
    [self.view endEditing:YES];
    
    NSDictionary *userDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"UserInfo" ofType:@"plist"]];
    NSString *userPhone = [userDict objectForKey:@"userPhone"];
    NSString *passWord = [userDict objectForKey:@"passWord"];
    
    BOOL userPhoneIsRight = [userPhone isEqualToString:_userPhone.text];
    BOOL passWordIsRight = [passWord isEqualToString:_passWord.text];
    
    if (userPhoneIsRight && passWordIsRight)
    {
        //本地换用户信息
        [GlobalTools sharedInstance].user_Phone = _userPhone.text;
        [GlobalTools sharedInstance].user_Pwd = _passWord.text;
        
        // 过渡动画（菊花）
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"正在登录...";
        hud.removeFromSuperViewOnHide = YES;
        //跳转至页面
        self.view.window.rootViewController = [[systemTabbar alloc] init];
    
    }
    else if(!userPhoneIsRight)
    {
//        [self setupAlertControllerWithMessage:@"请输入正确的手机号码"];
    }
    else if (!passWordIsRight)
    {
//        [self setupAlertControllerWithMessage:@"请输入6~18位密码"];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    // 结束编辑
    [self.view endEditing:YES];
}
@end
