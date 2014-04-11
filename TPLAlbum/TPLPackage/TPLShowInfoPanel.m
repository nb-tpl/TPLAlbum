//
//  TPLShowInfoPanel.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-25.
//  Copyright (c) 2014年 李红微. All rights reserved.
//
#define default_tag 300

#import "TPLShowInfoPanel.h"
#import "TPLAutoChangeView.h"

#import "TPLMutableTextLabel.h"

#import "TPLHelpTool.h"

@interface TPLShowInfoPanel()
{
    //数据
    //标题数组
    NSMutableArray * _titleArray;
    //信息数组
    NSMutableArray * _infoArray;
    //标题label数组
    NSMutableArray * _titleLabelArray;
    //内容label数组
    NSMutableArray * _infoLabelArray;
    
    //每列的扩展信息
    NSMutableDictionary * _expenDict;
    
    //信息展示面板
    TPLAutoChangeView * _infoPanel;
    
}
@end

@implementation TPLShowInfoPanel
@synthesize titleColor = _titleColor,titleFont = _titleFont,infoColor = _infoColor,infoFont = _infoFont;
@synthesize verticalRowCount = _verticalRowCount,horizontalHeight = _horizontalHeight,horizontalSpace = _horizontalSpace;
@synthesize leftMargin = _leftMargin;
@synthesize isBreakLine = _isBreakLine,isFitSize = _isFitSize;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //数据初始化
        _isBreakLine = NO;
        _isFitSize = YES;
        _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
        _infoArray = [[NSMutableArray alloc] initWithCapacity:0];
        _titleLabelArray = [[NSMutableArray alloc] initWithCapacity:0];
        _infoLabelArray = [[NSMutableArray alloc] initWithCapacity:0];
        _expenDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        _verticalRowCount = 1;
        _horizontalSpace = HORIZONTAL_SPACE;
        _horizontalHeight = HORIZONTAL_HEIGHT;
        _leftMargin = LEFT_MARGIN;
        //视图初始化
        _infoPanel = [[TPLAutoChangeView alloc] initWithFrame:self.bounds];
        _infoPanel.horizontalShouldScroll = NO;
        _infoPanel.verticalShouldScroll = NO;
        _infoPanel.fitFrame = YES;
        [self addSubview:_infoPanel];
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = NO;
    }
    return self;
}


#pragma mark
#pragma mark---------------deal Data
-(void)showWithTitleArray:(NSArray *)titleArray andInfoArray:(NSArray *)infoArray
{
    [_titleArray addObjectsFromArray:titleArray];
    [_infoArray addObjectsFromArray:infoArray];
    
    [self showInfo];
    
}


#pragma mark
#pragma mark---------------deal View
-(BOOL)expandWidth:(CGFloat)width forIndex:(NSInteger)index toDirection:(int)direction
{
    if (index < self.verticalRowCount)
    {
        NSArray * array = [NSArray arrayWithObjects:[NSNumber numberWithFloat:width],[NSNumber numberWithInt:direction], nil];
        [_expenDict setObject:array forKey:[NSString stringWithFormat:@"%d",index]];
        [self showInfo];
        return YES;
    }
    return false;
}


#pragma mark
#pragma mark---------------Show Info

//清理信息
-(void)cleanInfo
{
    while (_infoPanel.subviews.count != 0)
    {
        UIView * view = [_infoPanel.subviews lastObject];
        [view removeFromSuperview];
    }
    [_titleLabelArray removeAllObjects];
    [_infoLabelArray removeAllObjects];
}

//展示信息
-(void)showInfo
{
    [self cleanInfo];
    CGFloat x = _leftMargin;
    CGFloat y = 0;
    CGFloat realWidth = (self.frame.size.width - _leftMargin)/self.verticalRowCount;
    CGFloat showWidth =realWidth;
    UILabel * titleLabel;
    //列调整扩展判断
    __weak  NSArray * expendArray = nil;
    TPLMutableTextLabel * infoLabel;
    for (int i = 0; i < _titleArray.count; i = i+(int)_verticalRowCount)//每列
    {
        CGFloat infoHeight = self.horizontalHeight;
        for (int j = 0; j < _verticalRowCount; j ++)//每行
        {
            //列扩展处理
            if (expendArray != nil)
            {
                showWidth = showWidth + realWidth;
            }
            
            @try {
                expendArray = [_expenDict objectForKey:[NSString stringWithFormat:@"%d",j + 1]];
            }
            @catch (NSException *exception) {
                
            }
            if (expendArray != nil)
            {
                if ([[expendArray objectAtIndex:1] intValue] == 0)
                {
                    showWidth = showWidth - [[expendArray objectAtIndex:0] floatValue];
                }
            }
            
            if (i+j < _titleArray.count)
            {
                titleLabel = [[UILabel alloc] init];
                [_titleLabelArray addObject:titleLabel];
                titleLabel.font = self.titleFont;
                titleLabel.textColor = self.titleColor;
                NSString * title = [NSString stringWithFormat:@"%@:",[_titleArray objectAtIndex:i+j]];
                titleLabel.text = title;
                titleLabel.backgroundColor = [UIColor clearColor];
                [_infoPanel addSubview:titleLabel];
                CGFloat titleWidth = [TPLHelpTool lengthOfString:title withFont:self.titleFont];
                titleLabel.frame = CGRectMake(x, y, titleWidth, self.horizontalHeight);
                
                x = x + titleWidth;
                
                
                CGFloat infoWidth = showWidth - titleWidth;
                CGFloat heihgt = self.horizontalHeight;
                infoLabel = [[TPLMutableTextLabel alloc] initWithFrame:CGRectMake(x, y, infoWidth, heihgt)];
                [_infoLabelArray addObject:infoLabel];
                //                infoLabel.numberOfLines = 0;
                //                infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
                infoLabel.font = self.infoFont;
                infoLabel.textColor = self.infoColor;
                //                infoLabel.backgroundColor = [TPLHelpTool getRandomColor];
                NSString * info = @"";
                if (_infoArray.count > i+j)
                {
                    info = [_infoArray objectAtIndex:i+j];
                }
                //                infoLabel.text = info;
                [_infoPanel addSubview:infoLabel];
                infoLabel.text = info;
                if (_isBreakLine == YES)//自适应
                {
                    //                    heihgt =  [TPLHelpTool heightOfString:info withFont:self.infoFont forWidth:infoWidth lineBreakMode:infoLabel.lineBreakMode];
                    //                    heihgt = heihgt > self.horizontalHeight ? heihgt : self.horizontalHeight;
                    infoHeight = infoLabel.frame.size.height > infoHeight ? infoLabel.frame.size.height : infoHeight;
                }
                //                infoLabel.frame = CGRectMake(x, y, infoWidth, heihgt
                //                                             );
                x = x + infoWidth;
            }
            //处理完了之后恢复宽度
            if (expendArray == nil)
            {
                showWidth = realWidth;
            }
            
        }
        x = _leftMargin;
        y = y + infoHeight + self.horizontalSpace;
    }
    
    if (_isFitSize)
    {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
        _infoPanel.frame = self.bounds;
    }
    
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
