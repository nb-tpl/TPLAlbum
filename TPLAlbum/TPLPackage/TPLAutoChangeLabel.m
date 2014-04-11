//
//  TPLAutoChangeLabel.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-22.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import "TPLAutoChangeLabel.h"
#import "TPLHelpTool.h"


@interface TPLAutoChangeLabel ()
{
    //展示文字Label
    UILabel * _label;
    NSString * _text;
}
@end
@implementation TPLAutoChangeLabel
@synthesize text = _text,font = _font,label = _label,textColor = _textColor;

#pragma mark
#pragma mark---------------property Function---------------
-(void)setText:(NSString *)text
{
    _text = text;
    CGSize size = [TPLHelpTool sizeOfString:_text withFont:_label.font];
    CGFloat width = size.width;
    CGFloat height = size.height;
    if (size.width < self.bounds.size.width)
    {
        width = self.bounds.size.width;
    }
    else if(size.height < self.bounds.size.height)
    {
        height = self.bounds.size.height;
    }
    _label.frame = CGRectMake(0, 0, width, height);
    if (_label.superview != nil)
    {
        [_label removeFromSuperview];
    }
    _label.text = _text;
    // _label.textColor = [UIColor blackColor];
    //    _label.backgroundColor = [UIColor orangeColor];
    [self addSubview:_label];
    
}
-(NSString*)text
{
    return _text;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    _label.font = font;
}
-(UIFont*)font
{
    return _label.font;
}
-(UIColor*)textColor
{
    return _label.textColor;
}
-(void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    _label.textColor = textColor;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _text = @"";
        _label = [[UILabel alloc] init];
        _label.userInteractionEnabled = YES;
        [self addSubview:_label];
    }
    return self;
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
