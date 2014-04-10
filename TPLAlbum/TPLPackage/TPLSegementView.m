//
//  TPLSegementView.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-25.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import "TPLSegementView.h"
#import "TPLAutoChangeView.h"


@interface TPLSegementView ()
{
    //按钮数组
    NSMutableArray * _buttonsArray;
    //视图数组
    NSMutableArray * _viewsArray;
    
    //当前选择按钮
    NSInteger _selectIndex;
    
    //按钮滚动视图
    TPLAutoChangeView * _buttonsScrollView;
}

//刷新视图
-(void)refreshView;

@end

@implementation TPLSegementView
@synthesize buttonHeight = _buttonHeight,buttonWidth = _buttonWidth,viewsCount = _viewsCount,titleArray = _titleArray;
@synthesize segementBackgroundView = _segementBackgroundView;
@synthesize viewsArray = _viewsArray;

#pragma mark
#pragma mark---------------property
//按钮高度
-(void)setButtonHeight:(CGFloat)buttonHeight
{
    _buttonHeight = buttonHeight;
    [self refreshView];
}
//按钮宽度
-(void)setButtonWidth:(CGFloat)buttonWidth
{
    _buttonWidth = buttonWidth;
    [self refreshView];
}
//视图个数
-(void)setViewsCount:(NSInteger)viewsCount
{
    _viewsCount = viewsCount;
    if (_viewsCount < _buttonsArray.count)
    {
        for (int i = (int)_viewsCount; i < _buttonsArray.count ; )
        {
            UIButton * button = [_buttonsArray lastObject];
            [button removeFromSuperview];
            [_buttonsArray removeLastObject];
            UIView * view = [_viewsArray lastObject];
            [view removeFromSuperview];
            [_viewsArray removeLastObject];
        }
    }
    else if(viewsCount > _buttonsArray.count)
    {
        for(int i = (int)_viewsCount;i > _buttonsArray.count;)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [_buttonsArray addObject:button];
            UIView * view = [[UIView alloc] init];
            //view.backgroundColor = [TPLHelpTool getRandomColor];
            [_viewsArray addObject:view];
        }
    }
    
    [self refreshView];
}
//按钮标题数组
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    for (int i = 0; i < _buttonsArray.count; i++)
    {
        UIButton * button = [_buttonsArray objectAtIndex:i];
        NSString * title = @"title";
        if (_titleArray.count > i)
        {
            title = [_titleArray objectAtIndex:i];
        }
        [button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark
#pragma mark---------------Function
//改变标题字体
-(void)setTitleFont:(UIFont *)titleFont
{
    for (UIButton * button in _buttonsArray)
    {
        button.titleLabel.font = titleFont;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //初始化数据
        _buttonsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _viewsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _buttonWidth = SEGEMENT_BUTTON_WIDTH_DEFAULT;
        _buttonHeight = SEGEMENT_BUTTON_HEIGHT_DEFAULT;
        _selectIndex = 0;
        _viewsCount = 1;
        _titleArray = [[NSArray alloc] initWithObjects:@"title", nil];
        //初始化视图
        _segementBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SEGEMENT_BUTTON_HEIGHT_DEFAULT)];
        [self addSubview:_segementBackgroundView];
        _buttonsScrollView = [[TPLAutoChangeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SEGEMENT_BUTTON_HEIGHT_DEFAULT)];
        [self addSubview:_buttonsScrollView];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:75.0f/255.0f blue:131.0f/255.0f alpha:1];
        [_buttonsArray addObject:button];
        UIView * view = [[UIView alloc] init];
        [_viewsArray addObject:view];
        [self addSubview:view];
        //刷新视图
        [self refreshView];

    }
    return self;
}



//刷新视图
-(void)refreshView
{
    _segementBackgroundView.frame = CGRectMake(0, 0, self.frame.size.width,self.buttonHeight);
    _buttonsScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.buttonHeight);
    
    for (int i = 0; i < _buttonsArray.count; i++)
    {
        //按钮
        UIButton * button = [_buttonsArray objectAtIndex:i];
        button.frame = CGRectMake(i*self.buttonWidth, 0, self.buttonWidth, self.buttonHeight);
        button.tag = 100+i;
        [button addTarget:self action:@selector(viewsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (nil != button.superview)
        {
            [button removeFromSuperview];
        }
        [_buttonsScrollView addSubview:button];
        //视图
        UIView * view = [_viewsArray objectAtIndex:i];
        view.frame = CGRectMake(0, self.buttonHeight, self.frame.size.width, self.frame.size.height - self.buttonHeight);
        if (nil == view.superview || view.superview != self)
        {
            [self addSubview:view];
            view.hidden = YES;
        }
    }
}



//按钮点击事件
-(void)viewsButtonClicked:(UIButton*)button
{
    if (button.selected)
    {
        return;
    }
    //隐藏之前的视图
    UIButton * selectedButton = [_buttonsArray objectAtIndex:_selectIndex];
    selectedButton.selected = NO;
    selectedButton.backgroundColor = [UIColor clearColor];
    UIView * selectedView = [_viewsArray objectAtIndex:_selectIndex];
    selectedView.hidden = YES;
    
    //点亮现在的
    _selectIndex = button.tag - 100;
    button.selected = YES;
    button.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:75.0f/255.0f blue:131.0f/255.0f alpha:1];
    UIView * willShowView = [_viewsArray objectAtIndex:_selectIndex];
    willShowView.hidden = NO;
    //willShowView.backgroundColor = [TPLHelpTool getRandomColor];
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
