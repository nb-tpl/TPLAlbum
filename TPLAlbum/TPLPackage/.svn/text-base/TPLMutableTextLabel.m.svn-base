//
//  TPLMutableTextLabel.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-3-24.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import "TPLMutableTextLabel.h"



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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //初始化
        _isAutoChangeFrame = YES;
        _lineHeight = 21.0f;
        _font = [UIFont systemFontOfSize:11.0f];
        self.textColor = [UIColor grayColor];
        _text = @"";
        _labelArray = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

#pragma mark
#pragma mark---------------property
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
//







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
    CGFloat frameWidth = self.frame.size.width;
    CGFloat y = 0;
    CGFloat infoStringLength = [self lengthOfString:infoString withFont:self.font];
    while (infoStringLength > frameWidth)
    {
        for (int i = 0; i < infoString.length + 1; i++)
        {
            NSString * lineStr = [infoString substringToIndex:i];
            CGFloat width = [self lengthOfString:lineStr withFont:self.font];
            //看是否超过
            if (width > frameWidth)
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frameWidth, self.lineHeight)];
                label.text = [infoString substringToIndex:i - 1];
                label.font = self.font;
                label.textColor = self.textColor;
//                label.backgroundColor = [TPLHelpTool getRandomColor];
                [self addSubview:label];
                infoString = [NSMutableString stringWithString:[infoString substringFromIndex:i - 1]];
                [_labelArray addObject:label];
                y = y + self.lineHeight;
                break;
            }
            else if(width == frameWidth)
            {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frameWidth, self.lineHeight)];
//                label.backgroundColor = [TPLHelpTool getRandomColor];
                label.text = [infoString substringToIndex:i];
                label.font = self.font;
                label.textColor = self.textColor;
                [self addSubview:label];
                infoString = [NSMutableString stringWithString:[infoString substringFromIndex:i]];
                [_labelArray addObject:label];
                y = y + self.lineHeight;
                break;
            }
            else
            {
                
            }
        }
        infoStringLength = [self lengthOfString:infoString withFont:self.font];
    }
    //最后一截文字
    if (infoStringLength > 0)
    {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, frameWidth, self.lineHeight)];
        label.text = infoString;
//        label.backgroundColor = [UIColor redColor];
        label.font = self.font;
        label.textColor = self.textColor;
        [self addSubview:label];
//        self.superview.clipsToBounds = NO;
        [_labelArray addObject:label];
    }
    if (_isAutoChangeFrame)
    {
         [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.lineHeight * _labelArray.count)];
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
