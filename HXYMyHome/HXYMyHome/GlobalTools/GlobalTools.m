//
//  GlobalTools.m
//  HXYMyHome
//
//  Created by 胡小羊 on 17/3/21.
//  Copyright © 2017年 HXY. All rights reserved.
//

#import "GlobalTools.h"
#import "CommonCrypto/CommonDigest.h"

#define USER_PHONE @"user_phone"//用户登录的手机号
#define USER_PWD @"user_password"//用户登录的密码

static GlobalTools *globalToos;

@implementation GlobalTools

+ (GlobalTools *)sharedInstance{

    if (!globalToos) {
        globalToos = [[GlobalTools alloc]init];
    }
    return globalToos;
}

/**
 *  MD5加密
 */
-(NSString *)md5:(NSString *)inPutText{
    
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

/**
 *  本地化数据
 */
- (void)saveDataToLocalWithKey:(NSString *)key andValue:(NSString *)value{
    [[NSUserDefaults standardUserDefaults]setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  获取本地数据
 */
- (NSString *)obtainDataFromLocalWithKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
}

- (void)setUser_Pwd:(NSString *)user_Pwd{
    [self saveDataToLocalWithKey:USER_PWD andValue:user_Pwd];
    
}
- (void)setUser_Phone:(NSString *)user_Phone{
    [self saveDataToLocalWithKey:USER_PHONE andValue:user_Phone];
}

- (NSString *)user_Pwd{
   return  [self obtainDataFromLocalWithKey:USER_PWD];
}
- (NSString *)user_Phone{
    return [self obtainDataFromLocalWithKey:USER_PHONE];
}

/**
 *  是不是在登录状态
 */
- (BOOL)isInLogIn{
    if (self.user_Phone && self.user_Pwd){
        return YES;
    }else{
        return NO;
    }
}

//计算文字的的长度
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}
@end
