//
//  UIImage+LYZ.m
//  HappyDoctorDoctor
//
//  Created by mac on 16/7/1.
//  Copyright © 2016年 胡小羊. All rights reserved.
//

#import "UIImage+LYZ.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (LYZ)

/**
 *  将颜色转化成图片
 *
 *  @param color 传入颜色
 *
 *  @return image
 */
+ (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  为图片添加毛玻璃效果
 *
 *  @param image 图片
 *  @param blur  透明度
 *
 *  @return 处理后的图片
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

/**
 *  将图片转化成圆形图片
 */
- (UIImage *)circleImage
{
//    // 获得的就是一个圆形的图片
//    UIImage *placeHolder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    // 开始图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置一个范围
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 根据一个rect创建一个椭圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪
    CGContextClip(ctx);
    
    // 将原照片画到图形上下文
    [self drawInRect:rect];
    
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 将图片转换成二进制流文件
 
 @param image 图片
 @return 二进制流文件
 */
+ (NSData *)imageTransFormDataWithImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData.length>512*1024)
    {
        imageData=UIImageJPEGRepresentation(image, 0.5);
    }
    return imageData;
    
//    //压缩图像
//    +(NSData *)imageData:(UIImage *)myimage
//    {
//        NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
//        if (data.length>100*1024) {
//            if (data.length>1024*1024) {//1M以及以上
//                data=UIImageJPEGRepresentation(myimage, 0.1);
//            }else if (data.length>512*1024) {//0.5M-1M
//                data=UIImageJPEGRepresentation(myimage, 0.5);
//            }else if (data.length>200*1024) {//0.25M-0.5M
//                data=UIImageJPEGRepresentation(myimage, 0.9);
//            }
//        }
//        return data;
//    }
}

@end
