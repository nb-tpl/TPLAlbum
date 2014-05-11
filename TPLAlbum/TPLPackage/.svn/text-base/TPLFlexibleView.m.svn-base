//
//  TPLFlexibleView.m
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-25.
//  Copyright (c) 2014年 李红微. All rights reserved.
//


#define VIEW_HEGHT_DEFAULT 60

#import "TPLFlexibleView.h"
#import "TPLAutoChangeView.h"
@interface TPLFlexibleView()
{
    //视图数据数组
    NSMutableArray * _viewsArray;
    NSMutableArray * _buttonsArray;
    
    
    //视图的容器
    TPLAutoChangeView * _viewsScrollView;
}



@end

@implementation TPLFlexibleView
@synthesize buttonsArray = _buttonsArray,viewsArray = _viewsArray;
@synthesize titleButtonHeight = _titleButtonHeight,viewsCount = _viewsCount;
@synthesize stateNormalImage = _stateNormalImage,stateSelectedImage = _stateSelectedImage;

@synthesize autoChangeView = _viewsScrollView;



#pragma mark
#pragma mark---------------property
//标题按钮高度
-(void)setTitleButtonHeight:(CGFloat)titleButtonHeight
{
    _titleButtonHeight = titleButtonHeight;
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
            [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageNamed:@"终端页-通用背景条.png"] forState:UIControlStateNormal
             ];
            button.frame = CGRectMake(0, 0, _viewsScrollView.frame.size.width, _titleButtonHeight);
            UIImageView * signImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.size.width - 30, 5, 22, 22)];
            signImageView.tag = 111;
            signImageView.image =  _stateNormalImage;
            [button addSubview:signImageView];
            // button.backgroundColor = [UIColor redColor];
            [_buttonsArray addObject:button];
            
            
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEW_HEGHT_DEFAULT)];
            //view.backgroundColor = [TPLHelpTool getRandomColor];
            [_viewsArray addObject:view];
        }
    }
    
    [self refreshView];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //初始化数据
        _buttonsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _viewsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _viewsCount = 1;
        _stateNormalImage = nil;
        _stateSelectedImage = nil;
        _titleButtonHeight = FLEXIBLE_BUTTON_HEIGHT_DEFAULT;
        _stateNormalImage = [UIImage imageNamed:@"终端页-向右箭头.png"];
        _stateSelectedImage =  [UIImage imageNamed:@"终端页-向下箭头.png"];
        //初始化视图
        _viewsScrollView = [[TPLAutoChangeView alloc] initWithFrame:self.bounds];
        _viewsScrollView.scrollEnabled = YES;
        _viewsScrollView.fitFrame = YES;
        _viewsScrollView.verticalShouldScroll = YES;
        [self addSubview:_viewsScrollView];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, _viewsScrollView.frame.size.width, _titleButtonHeight);
        [button setBackgroundImage:[UIImage imageNamed:@"终端页-通用背景条.png"] forState:UIControlStateNormal
         ];
        button.selected = NO;
        button.tag = 222+0;
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonsArray addObject:button];
        UIImageView * signImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.size.width - 30, 5, 22, 22)];
        signImageView.image =  _stateNormalImage;
        signImageView.tag = 111;
        [button addSubview:signImageView];
        [_viewsScrollView addSubview:button];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, VIEW_HEGHT_DEFAULT)];
        [_viewsArray addObject:view];
        
    }
    return self;
}







#pragma mark
#pragma mark---------------view show
-(void)refreshView
{
    //CGFloat x = 0.0f;
    CGFloat y = 0.0f;
    for (int i = 0; i < _buttonsArray.count; i++)
    {
        UIButton * button = [_buttonsArray objectAtIndex:i];
        button.frame = CGRectMake(0, y, _viewsScrollView.frame.size.width, self.titleButtonHeight);
        y = y + self.titleButtonHeight;
        button.tag = 222+i;
        //[button setTitle:@"测试" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (button.superview ==nil || button.superview != _viewsScrollView)
        {
            [_viewsScrollView addSubview:button];
        }
        else
        {
            [button removeFromSuperview];
            [_viewsScrollView addSubview:button];
        }
        if (button.selected == YES)
        {
            UIView * view = [_viewsArray objectAtIndex:i];
            view.frame = CGRectMake(0, y, _viewsScrollView.frame.size.width, view.frame.size.height);
            y = y + view.frame.size.height;
            if (view.superview == nil || view.superview != _viewsScrollView)
            {
                [_viewsScrollView addSubview:view];
            }
            else
            {
                [view removeFromSuperview];
                [_viewsScrollView addSubview:view];
            }
        }
        else if (button.selected == NO)
        {
            UIView * view = [_viewsArray objectAtIndex:i];
            if (view.superview != nil || view.superview == _viewsScrollView)
            {
                [view removeFromSuperview];
            }
        }
    }
}

//调整视图，使指定视图可视
-(void)setViewEyeAbleForIndex:(NSInteger)index
{
    //求出Y的范围
    CGFloat endY = _viewsScrollView.contentOffset.y + _viewsScrollView.frame.size.height;
    
    CGFloat viewY = 0;
    
    UIButton * endButton = [_buttonsArray objectAtIndex:index];
    if (endButton.selected == YES)
    {
        UIView * view = (UIView*)[_viewsArray objectAtIndex:index];
        viewY = view.frame.origin.y + view.frame.size.height;

        //如果超出了,动画将视图展现出来，使其可见
        if (viewY > endY)
        {
            [_viewsScrollView setContentOffset:CGPointMake(0, _viewsScrollView.contentOffset.y +(viewY - endY)) animated:YES];
        }
    }
    else
    {
        viewY = endButton.frame.origin.y + endButton.frame.size.height;
    }

}


#pragma mark
#pragma mark---------------button Function
-(void)titleButtonClicked:(UIButton*)button
{
    button.selected = button.selected ? NO : YES;
    UIImageView * imageView = (UIImageView*)[button viewWithTag:111];
    imageView.image = button.selected ?_stateSelectedImage : _stateNormalImage;
    CGPoint contentOffSet1 = _viewsScrollView.contentOffset;
    [self refreshView];
    CGPoint contentOffSet2 = _viewsScrollView.contentOffset;
    
    _viewsScrollView.contentOffset = contentOffSet1;
    if (button.selected == NO)
    {
        [_viewsScrollView setContentOffset:contentOffSet2 animated:YES];
    }
    
    //将视图移动到可视范围
    [self setViewEyeAbleForIndex:button.tag - 222];
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
