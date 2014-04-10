//
//  TPLHelpTool.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-22.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLHelpTool : NSObject



#pragma mark
#pragma mark---------------about Device---------------
+(NSString *)getDeviceType;



#pragma mark
#pragma mark---------------about Screen---------------
//获取屏幕分辨率
+(CGRect)getScreenRect;
//获取屏幕尺寸,1为3.5英寸,2为4英寸
+(int)getScreenSize;
/**
 *  获得操作系统版本
 *
 *  @return 操作系统版本号
 */
+(NSString *)getSystemVersion;

#pragma mark
#pragma mark---------------about calculate---------------
//获得字符串占的大小
+(CGSize)sizeOfString:(NSString*)string withFont:(UIFont*)font;
//获得字符串长度
+(CGFloat)lengthOfString:(NSString*)string withFont:(UIFont*)font;
//限定宽度，获得字符串高度
+(CGFloat)heightOfString:(NSString*)string withFont:(UIFont*)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

#pragma mark
#pragma mark---------------about color
//获得一个随机颜色
+(UIColor*)getRandomColor;

#pragma mark
#pragma mark---------------about String
//修改接收的字符串，返回符合iOS系统的....主要是换行符不同
+(NSString *)htmlToString:(NSString *)str;



#pragma mark
#pragma mark---------------HNUtil



@end
