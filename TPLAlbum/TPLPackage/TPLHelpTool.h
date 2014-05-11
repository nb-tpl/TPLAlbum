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
#pragma mark           about System
#pragma mark
//禁止交互
+(void)ignoringInteractionEvents;
//启用交互
+(void)endIgnoringInteractionEvents;


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
//将16进制颜色转换为UIColor
+ (UIColor *)getHexColor:(NSString *)hexColor;
#pragma mark
#pragma mark           about image
#pragma mark
//旋转图片.以弧度为单位
+(UIImage*)rotationImage:(UIImage*)image withAngle:(CGFloat)angle;

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+(UIImage *)image:(UIImage *)img addText:(NSString *)text1;



//指定UIImageView加载GIF
+(void)imageView:(UIImageView*)imageView loadGifFilePath:(NSString*)gifFilePath;

#pragma mark
#pragma mark           about View
#pragma mark
//创建一个指定颜色和宽度的线视图
+(UIView*)createALineViewWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth;
//给指定view上的所有view附上随即颜色
+(void)setRandomColorToSubviewsForView:(UIView*)view;


#pragma mark
#pragma mark---------------about String
//修改接收的字符串，返回符合iOS系统的....主要是换行符不同
+(NSString *)htmlToString:(NSString *)str;

//生成指定颜色指定font的富文本字符串
+(NSAttributedString*)greatAttributedString:(NSString*)text WithTextFont:(UIFont*)textFont textColor:(UIColor*)textColor;

#pragma mark
#pragma mark           about Time
#pragma mark
//获取今年
+(NSInteger)currentYear;
//由日期获得星座
+(NSString *)getAstroWithMonth:(int)m day:(int)d;
//由年份获得生肖
+(NSString *)getShengXiaoFromYear:(NSString*)year;
//获取距今时间差
+(NSString*)intervalSinceNow: (NSString*) theDate;

#pragma mark
#pragma mark           about location distance
#pragma mark
//计算两经纬度左边之间的距离
+(double) distanceForLongtitude1:(double)lon1 latitude1:(double)lat1 longtitude2:(double)lon2 latitude2:(double)lat2;



#pragma mark
#pragma mark           about Expression
#pragma mark
//返回表情数值字典
+(NSDictionary * )expressionDict;

//返回表情数值数组
+(NSArray*)expressionArray;

//返回表情名字数组
+(NSArray*)expressionNameArray;


#pragma mark
#pragma mark---------------HNUtil



@end
