//
//  TPLAutoChangeView.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-22.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import "TPLAutoChangeView.h"

@implementation TPLAutoChangeView
@synthesize horizontalShouldScroll = _horizontalShouldScroll,verticalShouldScroll = _verticalShouldScroll;
@synthesize fitFrame = _fitFrame;
#pragma mark
#pragma mark---------------property
//竖直是否初始能滑动
-(void)setVerticalShouldScroll:(BOOL)verticalShouldScroll
{
    _verticalShouldScroll = verticalShouldScroll;
    if (_verticalShouldScroll)
    {
        if (self.frame.size.height >= self.contentSize.height)
        {
            self.contentSize = CGSizeMake(self.contentSize.width, self.frame.size.height + 1);
        }
    }
}
//水平是否初始能滑动
-(void)setHorizontalShouldScroll:(BOOL)horizontalShouldScroll
{
    _horizontalShouldScroll = horizontalShouldScroll;
    if (_horizontalShouldScroll)
    {
        if (self.frame.size.width >= self.contentSize.width)
        {
            self.contentSize = CGSizeMake(self.frame.size.width + 1, self.contentSize.height);
        }
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        _verticalShouldScroll = NO;
        _horizontalShouldScroll = NO;
        _fitFrame = NO;
    }
    return self;
}


//改变自己的滑动范围
-(void)addSubview:(UIView *)view
{
    //水平扩充和恢复
    if ((view.frame.origin.x + view.frame.size.width) > self.contentSize.width)
    {
        self.contentSize = CGSizeMake(view.frame.origin.x + view.frame.size.width, self.contentSize.height);
    }
    else
    {
        if (_fitFrame)
        {
            if (_horizontalShouldScroll)
            {
                self.contentSize = CGSizeMake(self.frame.size.width + 1, self.contentSize.height);
            }
            else
            {
                self.contentSize = CGSizeMake(self.frame.size.width, self.contentSize.height);
            }
        }
    }
    //垂直扩充和恢复
    if((view.frame.origin.y + view.frame.size.height) > self.contentSize.height)
    {
        self.contentSize = CGSizeMake(self.contentSize.width, view.frame.origin.y + view.frame.size.height);
    }
    else
    {
        if (_fitFrame)
        {
            if (_verticalShouldScroll)
            {
                self.contentSize = CGSizeMake(self.contentSize.width, self.frame.size.height + 1);
            }
            else
            {
                self.contentSize = CGSizeMake(self.contentSize.width, self.frame.size.height);
            }
        }
    }
    [super addSubview:view];
}



#pragma mark
#pragma mark---------------Function
-(void)addFrameFromSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + size.width, self.frame.size.height + size.height);
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}


@end
