//
//  TPLHelpTool.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-22.
//  Copyright (c) 2014年 李红微. All rights reserved.
//
#define MORE_WIDTH 0
#define ANIMATION_DURATION_DEFAULT 0.5

#import <ImageIO/ImageIO.h>

#import "TPLHelpTool.h"


@implementation TPLHelpTool



#pragma mark
#pragma mark           about System
#pragma mark
//禁止交互
+(void)ignoringInteractionEvents
{
    if (![[UIApplication sharedApplication] isIgnoringInteractionEvents])    //禁止交互
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}
//启用交互
+(void)endIgnoringInteractionEvents
{
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}


#pragma mark
#pragma mark---------------about Device---------------
+(NSString*)getDeviceType
{
    return  [[UIDevice currentDevice] model];
}


#pragma mark
#pragma mark---------------about Screen---------------
//获取屏幕分辨率
+(CGRect)getScreenRect
{
    return [[UIScreen mainScreen] bounds];
}
//获取屏幕尺寸
+(int)getScreenSize
{
    CGRect bounds = [TPLHelpTool getScreenRect];
    int size = 1;
    if (bounds.size.height <= 480 || bounds.size.height <= 960)
    {
        size = 1;
    }
    else if (bounds.size.height <= 1136)
    {
        size = 2;
    }
    return size;
}

#pragma mark
#pragma mark---------------about Calculate---------------
//获得字符串占的大小
+(CGSize)sizeOfString:(NSString*)string withFont:(UIFont*)font
{
    NSString * systemString = [TPLHelpTool getSystemVersion];
    CGSize size;
    if ([systemString intValue] >= 7)
    {
        size = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    }
    else
    {
        size = [string sizeWithFont:font];
    }
    
    return size;
}

//获得字符串长度
+(CGFloat)lengthOfString:(NSString*)string withFont:(UIFont*)font
{
    NSString * systemString = [TPLHelpTool getSystemVersion];
    CGSize size;
    if ([systemString intValue] >= 7)
    {
        size = [string sizeWithAttributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]];
    }
    else
    {
        size = [string sizeWithFont:font];
    }
    
    return size.width + MORE_WIDTH;
}


//限定宽度，获得字符串高度
+(CGFloat)heightOfString:(NSString*)string withFont:(UIFont*)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSString * systemString = [TPLHelpTool getSystemVersion];
    CGSize size;
    if ([systemString intValue] >= 7)
    {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
        size = [string boundingRectWithSize:CGSizeMake(width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }
    else
    {
        //        string = [NSString stringWithFormat:@"%@     hahaha",string];
        //        size = [string sizeWithFont:font forWidth:width lineBreakMode:lineBreakMode];
        size = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, 9999) lineBreakMode:lineBreakMode];
    }
    
    return size.height;
}

//获得操作系统版本号
+(NSString *)getSystemVersion
{
    return  [[UIDevice currentDevice] systemVersion];
}

#pragma mark
#pragma mark---------------about color
//获得一个随机颜色
+(UIColor*)getRandomColor
{
    return [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:1];
}

//16进制颜色转换成UIColor
+ (UIColor *)getHexColor:(NSString *)hexColor
{
//    unsigned int red,green,blue;
//    NSRange range;
//    range.length = 2;
//    range.location = 0;
//    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
//    range.location = 2;
//    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
//    range.location = 4;
//    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
//    
//    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
    
    NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark
#pragma mark           about image
#pragma mark

//旋转图片
+(UIImage*)rotationImage:(UIImage*)image withAngle:(CGFloat)angle
{
    CGSize size = image.size;
    UIGraphicsBeginImageContext(size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextRotateCTM(ctx, angle);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0,0,size.width, size.height), image.CGImage);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

//压缩图片
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

+(UIImage *)image:(UIImage *)img addText:(NSString *)text1
{
    int w = img.size.width;
    int h = img.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
    char* text= (char *)[text1 cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Arial",20, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextShowTextAtPoint(context,10,10,text, strlen(text));
    CGImageRef imgCombined = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *retImage = [UIImage imageWithCGImage:imgCombined];
    CGImageRelease(imgCombined);
    
    return retImage;
}


//指定UIImageView加载GIF
+(void)imageView:(UIImageView*)imageView loadGifFilePath:(NSString*)gifFliePath
{
    NSData *gifData = [NSData dataWithContentsOfFile: gifFliePath];
    NSMutableArray *frames = nil;
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    double total = 0;
    NSTimeInterval gifAnimationDuration;
    if (src)
    {
        size_t l = CGImageSourceGetCount(src);
        if (l > 1)
        {
            frames = [NSMutableArray arrayWithCapacity: l];
            for (size_t i = 0; i < l; i++)
            {
                CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
                CFDictionaryRef dic = CGImageSourceCopyPropertiesAtIndex(src, 0, NULL);
                NSDictionary *dict = [NSDictionary dictionaryWithDictionary:CFBridgingRelease(dic)];
                
                if (dict){
                    NSDictionary *tmpdict = [dict objectForKey: @"{GIF}"];
                    total += [[tmpdict objectForKey: @"DelayTime"] doubleValue] * 100;
                }
                if (img) {
                    [frames addObject: [UIImage imageWithCGImage: img]];
                    CGImageRelease(img);
                }
            }
            gifAnimationDuration = total / 100;
            
            imageView.animationImages = frames;
            imageView.animationDuration = gifAnimationDuration;
            [imageView startAnimating];
        }
    }
    
    CFBridgingRelease(src);
}

#pragma mark
#pragma mark           about View
#pragma mark
//创建一个指定颜色和宽度的线视图
+(UIView*)createALineViewWithLineColor:(UIColor*)lineColor lineWidth:(CGFloat)lineWidth
{
    UIView * lineView = [[UIView alloc] init];
    lineView.layer.borderColor = lineColor.CGColor;
    lineView.layer.borderWidth = lineWidth;
    return lineView;
}

//给指定view上的所有view附上随即颜色
+(void)setRandomColorToSubviewsForView:(UIView*)view
{
    view.backgroundColor = [TPLHelpTool getRandomColor];
    if (view.subviews.count > 0)
    {
        for (UIView * subview in view.subviews)
        {
            [TPLHelpTool setRandomColorToSubviewsForView:subview];
        }
    }
}


#pragma mark
#pragma mark---------------about String
//修改接收的字符串，返回符合iOS系统的....主要是换行符不同
+(NSString *)htmlToString:(NSString *)str
{
    
    NSString *tempStr;
//    tempStr = [str stringByReplacingOccurrencesOfString:@"<br />" withString:@""];
    
    
    
    if (str == nil)
    {
        return nil;
    }
    else
    {
        //tempStr = [str stringByReplacingOccurrencesOfString:@"&lt;p" withString:@""];
        //tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@""];
        //            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        //            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        //            tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        
        tempStr = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];


    }
    return tempStr;
}

//生成指定颜色指定font的富文本字符串
+(NSAttributedString*)greatAttributedString:(NSString*)text WithTextFont:(UIFont*)textFont textColor:(UIColor*)textColor
{
    NSAttributedString * attributeString = [[NSAttributedString alloc] initWithString:text attributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName,textColor,NSForegroundColorAttributeName, nil]];
    
    
    return attributeString;
}

#pragma mark
#pragma mark           about Time
#pragma mark
//获取当年
+(NSInteger)currentYear
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *now;
    
    NSDateComponents *comps  ;
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    now=[NSDate date];
    
    comps = [calendar components:unitFlags fromDate:now];
    
    int year = [comps year];
    
    
    return year;
}
//由日期获得星座
+(NSString *)getAstroWithMonth:(int)m day:(int)d{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return result;
}
//由年份获得生肖
+(NSString *)getShengXiaoFromYear:(NSString*)year
{
    int i=[year intValue]%12;
    NSArray * shengXiaoArray = @[@"猴",@"鸡",@"狗",@"猪",@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊"];
    return shengXiaoArray[i];
}
//获取距今时间差
+(NSString*)intervalSinceNow: (NSString*) theDate
{
    if ([theDate isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    NSDateFormatter*date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString*timeString=@"";
    NSTimeInterval cha=now-late;
    //发表在一小时之内
    if(cha/3600<1) {
        if(cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    //在一小时以上24小以内
    else if(cha/3600>1&&cha/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    //发表在24以上10天以内
    else if(cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    //发表时间大于10天
    else
    {
        //        timeString = [NSString stringWithFormat:@"%d-%"]
        NSArray*array = [theDate componentsSeparatedByString:@" "];
        //        return [array objectAtIndex:0];
        timeString = [array objectAtIndex:0];
        timeString = [timeString substringWithRange:NSMakeRange(5, [timeString length]-5)];
    }
    return timeString;
}

#pragma mark
#pragma mark           about location distance
#pragma mark
#define PI 3.1415926
+(double) distanceForLongtitude1:(double)lon1 latitude1:(double)lat1 longtitude2:(double)lon2 latitude2:(double)lat2
{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}

@end

