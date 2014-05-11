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
@synthesize buttonHeight = _buttonHeight,buttonWidth = _buttonWidth,viewsCount = _viewsCount,titleArray = _titleArray,titleColorNormal = _titleColorNormal,titleColorSelected = _titleColorSelected,titleBackgroundColorSelected = _titleBackgroundColorSelected;
@synthesize segementBackgroundView = _segementBackgroundView;
@synthesize viewsArray = _viewsArray,titleButtonsArray = _buttonsArray;
@synthesize scrollEnble = _scrollEnble;
@synthesize titleSelectedImage = _titleSelectedImage;
@synthesize delegate = _delegate;

#pragma mark
#pragma mark---------------property
//设定标题选中背景
-(void)setTitleSelectedImage:(UIImage *)titleSelectedImage
{
    if (titleSelectedImage != nil && [titleSelectedImage isKindOfClass:[UIImage class]])
    {
        _titleSelectedImage = titleSelectedImage;
        for (UIButton * button  in _buttonsArray)
        {
            [button setBackgroundImage:titleSelectedImage forState:UIControlStateSelected];
        }
    }
}
//设定标题滚动允许
-(void)setScrollEnble:(BOOL *)scrollEnble
{
    _scrollEnble = scrollEnble;
    _buttonsScrollView.scrollEnabled = NO;
}
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
//标题平常颜色
-(void)setTitleColorNormal:(UIColor *)titleColorNormal
{
    _titleColorNormal = titleColorNormal;
    for (UIButton * button in _buttonsArray)
    {
        [button setTitleColor:self.titleColorNormal  forState:UIControlStateNormal];
    }
}
//标题选中颜色
-(void)setTitleColorSelected:(UIColor *)titleColorSelected
{
    _titleColorSelected = titleColorSelected;
    for (UIButton * button in _buttonsArray)
    {
        [button setTitleColor:_titleColorSelected forState:UIControlStateSelected];
        [button setTitleColor:_titleColorSelected forState:UIControlStateHighlighted];
    }
    UIButton * button = (UIButton*)[_buttonsArray objectAtIndex:_selectIndex];
    button.enabled = YES;
    button.selected = YES;
}
//选中按钮背景颜色
-(void)setTitleBackgroundColorSelected:(UIColor *)titleBackgroundColorSelected
{
    UIButton * button = (UIButton*)[_buttonsArray objectAtIndex:_selectIndex];
    button.backgroundColor = titleBackgroundColorSelected;
    _titleBackgroundColorSelected = titleBackgroundColorSelected;
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
        _scrollEnble = YES;
        _buttonsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _viewsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _buttonWidth = SEGEMENT_BUTTON_WIDTH_DEFAULT;
        _buttonHeight = SEGEMENT_BUTTON_HEIGHT_DEFAULT;
        _selectIndex = 0;
        _viewsCount = 1;
        _titleArray = [[NSArray alloc] initWithObjects:@"title", nil];
        _titleColorNormal = [UIColor blackColor];
        _titleColorSelected = [UIColor whiteColor];
        _titleBackgroundColorSelected = [UIColor colorWithRed:221.0f/255.0f green:75.0f/255.0f blue:131.0f/255.0f alpha:1];
        //初始化视图
        _segementBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SEGEMENT_BUTTON_HEIGHT_DEFAULT)];
        [self addSubview:_segementBackgroundView];
        _buttonsScrollView = [[TPLAutoChangeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SEGEMENT_BUTTON_HEIGHT_DEFAULT)];
        _buttonsScrollView.horizontalShouldScroll = NO;
        [self addSubview:_buttonsScrollView];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor =_titleBackgroundColorSelected;
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
        [button setTitleColor:self.titleColorNormal  forState:UIControlStateNormal];
        [button setTitleColor:_titleColorSelected forState:UIControlStateSelected];
        [button setTitleColor:_titleColorSelected forState:UIControlStateHighlighted];
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
    button.backgroundColor =_titleBackgroundColorSelected;
    UIView * willShowView = [_viewsArray objectAtIndex:_selectIndex];
    willShowView.hidden = NO;
    
    //代理
    if ([self.delegate respondsToSelector:@selector(clickedItemTitleIndex:)])
    {
        [self.delegate clickedItemTitleIndex:_selectIndex];
    }
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
