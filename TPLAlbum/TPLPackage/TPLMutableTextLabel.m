//
//  TPLMutableTextLabel.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-3-24.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import "TPLMutableTextLabel.h"
#import "TPLHelpTool.h"



#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>



@implementation UIImageView (loadGif)

-(void)setGifFilePath:(NSString*)gifFilePath
{
    NSData *gifData = [NSData dataWithContentsOfFile:gifFilePath];
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
            
            self.animationImages = frames;
            self.animationDuration = gifAnimationDuration;
            [self startAnimating];
        }
        else if(l == 1)
        {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, 0, NULL);
            self.image = [UIImage imageWithCGImage:img];
            CGImageRelease(img);
        }
    }
    
    CFBridgingRelease(src);
}

@end




@interface TPLMutableTextLabel ()
{
//数据
    //label数组
    NSMutableArray * _labelArray;
}
@end

@implementation TPLMutableTextLabel

@synthesize font = _font,lineHeight = _lineHeight,text = _text,isAutoChangeFrame = _isAutoChangeFrame;
@synthesize textColor = _textColor;
@synthesize textAlignment = _textAlignment;
@synthesize contentLeftPadding = _contentLeftPadding,contentRightPadding = _contentRightPadding,contentTopPadding = _contentTopPadding,contentBottomPadding = _contentBottomPadding,contentEdgeInsets = _contentEdgeInsets;


@synthesize isUseForMessage = _isUseForMessage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //初始化
        _isAutoChangeFrame = YES;
        _lineHeight = 21.0f;
        //内容缩进
        _contentLeftPadding = 0.0;
        _contentRightPadding = 0.0;
        _contentTopPadding = 0.0;
        _contentBottomPadding = 0.0;
        
        _font = [UIFont systemFontOfSize:11.0f];
        self.textColor = [UIColor grayColor];
        _text = @"";
        _labelArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

#pragma mark
#pragma mark---------------property
//左缩进
-(void)setContentLeftPadding:(CGFloat)contentLeftPadding
{
    _contentLeftPadding = contentLeftPadding;
    [self showInfo];
}
//右缩进
-(void)setContentRightPadding:(CGFloat)contentRightPadding
{
    _contentRightPadding = contentRightPadding;
    [self showInfo];
}
//上缩进
-(void)setContentTopPadding:(CGFloat)contentTopPadding
{
    _contentTopPadding = contentTopPadding;
    [self showInfo];
}
//下缩进
-(void)setContentBottomPadding:(CGFloat)contentBottomPadding
{
    _contentBottomPadding = contentBottomPadding;
    [self showInfo];
}
//缩进总设置
-(void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
{
    _contentEdgeInsets = contentEdgeInsets;
    _contentLeftPadding = contentEdgeInsets.left;
    _contentRightPadding = contentEdgeInsets.right;
    _contentTopPadding = contentEdgeInsets.top;
    _contentBottomPadding = contentEdgeInsets.bottom;
    [self showInfo];
}



////frame
//-(void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//    [self showInfo];
//}
//文字
-(void)setText:(NSString *)text
{
    _text = text;
    [self showInfo];
}
-(NSString*)text
{
    return _text;
}
//文字颜色
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self showInfo];
}
-(UIColor*)textColor
{
    return  _textColor;
}
//行高
-(void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    [self showInfo];
}
//对齐方式
-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    for (UILabel * label in _labelArray)
    {
        if ([label isKindOfClass:[UILabel class]])
        {
            label.textAlignment = textAlignment;
        }
    }
}







#pragma mark
#pragma mark---------------show Function
-(void)showInfo
{
    //先清空之前的
    for (UILabel * label in _labelArray)
    {
        [label removeFromSuperview];
    }
    [_labelArray removeAllObjects];
    
    NSMutableString * infoString = [NSMutableString stringWithString:_text == nil ? @"":_text];
    CGFloat lineWidth = self.frame.size.width - _contentLeftPadding - _contentRightPadding;
    CGFloat frameWidth = lineWidth;
    CGFloat y = _contentTopPadding;
    CGFloat infoStringLength = [self lengthOfString:infoString withFont:self.font];
    CGFloat x = _contentLeftPadding;
    
    while (infoStringLength > 0)
    {
        for (int i = 0; i < infoString.length; i++)
        {
            NSString * lineStr = [infoString substringToIndex:i+1];
            CGFloat width = [self lengthOfString:lineStr withFont:self.font];
            
            NSString * checkStr = [lineStr substringWithRange:NSMakeRange(i, 1)];
            //如果开始有[,检查是不是表情
            if ([checkStr isEqualToString:@"["])
            {
                //先把之前的Label加上
                NSString * text = [infoString substringToIndex:i];
                if ([text isEqualToString:@""])
                {
                    width = 0;
                }
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, self.lineHeight)];
                label.text = text;
                label.font = self.font;
                label.textColor = self.textColor;
                label.textAlignment = self.textAlignment;
                label.backgroundColor = [UIColor clearColor];
                //                label.backgroundColor = [TPLHelpTool getRandomColor];
                [self addSubview:label];
                infoString = [NSMutableString stringWithString:[infoString substringFromIndex:i]];
                [_labelArray addObject:label];
                x = x + width;
                frameWidth = frameWidth - width;
                

                
                //如果剩下的够放表情
                if (frameWidth > _lineHeight || frameWidth == _lineHeight)
                {
                    //处理掉表情
                    NSString * experssionStr = @"";
                    //是否有表情
                    BOOL isHaveFace = NO;
                    for (int j = 0; j < (infoString.length > 7 ? 7 : (infoString.length)); j++)
                    {
                        checkStr = [infoString substringWithRange:NSMakeRange(j, 1)];
                        if ([checkStr isEqualToString:@"]"])
                        {
                            experssionStr = [infoString substringWithRange:NSMakeRange(1, j-1)];
                            
                            //如果有这个表情
                            NSString * faceID = [[TPLHelpTool expressionDict] objectForKey:experssionStr];
                            if (faceID != nil)
                            {
                                UIImageView * faceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, _lineHeight, _lineHeight)];
                                NSString * gifName = [NSString stringWithFormat:@"f%@",faceID];
                                [self addSubview:faceImageView];
                                [_labelArray addObject:faceImageView];
                                [faceImageView setGifFilePath:[[NSBundle mainBundle] pathForResource:gifName ofType:@"gif"]];
                                infoString = [NSMutableString stringWithString:[infoString substringFromIndex:j + 1]];
                                frameWidth = frameWidth - _lineHeight;
                                x = x + _lineHeight;
                                isHaveFace = YES;
                                break;
                            }
                        }
                    }
                    if (isHaveFace)//有表情
                    {
//                        //如果接下来不够放表情了,换行
//                        if ((frameWidth - _lineHeight) < 0)
//                        {
//                            x = _contentLeftPadding;
//                            y = y + self.lineHeight
//                            frameWidth = self.frame.size.width - _contentLeftPadding - _contentRightPadding;
//                        }
                        break;
                    }
                    else
                    {
                        //没有表情,遍历继续
                        continue;
                    }

                }
                else if(lineWidth < _lineHeight)//如果本身就不够放表情
                {
                    //肯定不是表情,继续
                    continue;
                }
                else//如果不够放表情,换行
                {
                    x = _contentLeftPadding;
                    y = y + self.lineHeight;
                    frameWidth = self.frame.size.width - _contentLeftPadding - _contentRightPadding;
                }
                
                
                break;
            }
            
            
            //看是否超过
            if (width > frameWidth)
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, frameWidth, self.lineHeight)];
                label.text = [infoString substringToIndex:i - 1];
                label.font = self.font;
                label.textColor = self.textColor;
                label.textAlignment = self.textAlignment;
                label.backgroundColor = [UIColor clearColor];
//                label.backgroundColor = [TPLHelpTool getRandomColor];
                [self addSubview:label];
                infoString = [NSMutableString stringWithString:[infoString substringFromIndex:i - 1]];
                [_labelArray addObject:label];
                y = y + self.lineHeight;
                x = _contentLeftPadding;
                frameWidth = self.frame.size.width - _contentLeftPadding - _contentRightPadding;
                break;
            }
            else if(width == frameWidth)
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, frameWidth, self.lineHeight)];
//                label.backgroundColor = [TPLHelpTool getRandomColor];
                label.text = [infoString substringToIndex:i];
                label.textAlignment = self.textAlignment;
                label.font = self.font;
                label.textColor = self.textColor;
                label.backgroundColor = [UIColor clearColor];
                [self addSubview:label];
                infoString = [NSMutableString stringWithString:[infoString substringFromIndex:i]];
                [_labelArray addObject:label];
                y = y + self.lineHeight;
                x = _contentLeftPadding;
                frameWidth = self.frame.size.width - _contentLeftPadding - _contentRightPadding;
                break;
            }
            else if(lineStr.length == infoString.length)
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, frameWidth, self.lineHeight)];
                label.text = infoString;
                label.textAlignment = self.textAlignment;
                label.backgroundColor = [UIColor clearColor];
                //        label.backgroundColor = [UIColor redColor];
                label.font = self.font;
                label.textColor = self.textColor;
                [self addSubview:label];
                //        self.superview.clipsToBounds = NO;
                [_labelArray addObject:label];
                infoString = nil;
            }
        }
        if (infoString != nil || [infoString isEqualToString:@""])
        {
            infoStringLength = [self lengthOfString:infoString withFont:self.font];
        }
        else//遍历结束
        {
            break;
        }
    }
//    //最后一截文字
//    if (infoStringLength > 0)
//    {
//        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(_contentLeftPadding, y, frameWidth, self.lineHeight)];
//        label.text = infoString;
//        label.textAlignment = self.textAlignment;
//        label.backgroundColor = [UIColor clearColor];
////        label.backgroundColor = [UIColor redColor];
//        label.font = self.font;
//        label.textColor = self.textColor;
//        [self addSubview:label];
////        self.superview.clipsToBounds = NO;
//        [_labelArray addObject:label];
//    }
    if (_isAutoChangeFrame)
    {
        UILabel * lastLabel = [_labelArray lastObject];
//        lastLabel.backgroundColor = [UIColor redColor];
        CGFloat height = [lastLabel frame].origin.y + _lineHeight + _contentBottomPadding;
        CGFloat width = self.frame.size.width;
        CGFloat x = self.frame.origin.x;
        CGFloat y = self.frame.origin.y;
        if (_isUseForMessage)
        {
            if (height > self.frame.size.height)
            {
                
            }
            else
            {
                CGFloat cotentWidth = self.frame.size.width - self.contentRightPadding;
                CGFloat labelWidth = 0;
                if ([lastLabel isKindOfClass:[UILabel class]])
                {
                    labelWidth = [TPLHelpTool lengthOfString:lastLabel.text withFont:self.font];
                    lastLabel.frame = CGRectMake(lastLabel.frame.origin.x, lastLabel.frame.origin.y, labelWidth, lastLabel.frame.size.height);
                }
                CGFloat realWidth = lastLabel.frame.origin.x + lastLabel.frame.size.width;
                if (cotentWidth > realWidth)
                {
                    CGFloat tempWidth = cotentWidth - realWidth;
                    width = width - tempWidth;
                    if (self.contentEdgeInsets.right > self.contentEdgeInsets.left)//右边的表情cell
                    {
                        x = x + tempWidth;
                    }
                }
            }
        }
         [self setFrame:CGRectMake(x, y, width, height)];
//        NSLog( @"height = %f",_lineHeight);
    }
}




//处理字符串
//获得字符串长度
-(CGFloat)lengthOfString:(NSString*)string withFont:(UIFont*)font
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
    
    return size.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




@end
