//
//  GlobalTools.h
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/21.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalTools : NSObject

/**
 *  本地化用户登录手机号
 */
@property (nonatomic ,strong)NSString *user_Phone;
/**
 *  本地化用户登录密码
 */
@property (nonatomic ,strong)NSString *user_Pwd;

/**
 *@brief 获取DemoGlobalClass单例句柄
 */
+(GlobalTools *)sharedInstance;

/**
 *  本地化数据
 */
- (void)saveDataToLocalWithKey:(NSString *)key andValue:(NSString *)value;
/**
 *  获取本地数据
 */
- (NSString *)obtainDataFromLocalWithKey:(NSString *)key;

/**
 *  MD5加密
 */
-(NSString *)md5:(NSString *)inPutText;

/**
 *  是不是在登录状态
 */
- (BOOL)isInLogIn;

/**
 *  计算文字的的长度
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end
