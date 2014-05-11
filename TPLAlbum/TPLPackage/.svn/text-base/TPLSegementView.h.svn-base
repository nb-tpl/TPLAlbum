//
//  TPLSegementView.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-25.
//  Copyright (c) 2014年 李红微. All rights reserved.
//
#define SEGEMENT_BUTTON_WIDTH_DEFAULT 60.0f
#define SEGEMENT_BUTTON_HEIGHT_DEFAULT 30.0f



#import <UIKit/UIKit.h>

@protocol TPLSegementViewDelegate;
@interface TPLSegementView : UIView
//按钮的高度
@property(nonatomic,assign)CGFloat buttonHeight;
//按钮的宽度
@property(nonatomic,assign)CGFloat buttonWidth;
@property(nonatomic,strong)UIImage * titleSelectedImage;
//视图个数
@property(nonatomic,assign)NSInteger viewsCount;
//按钮标题数组
@property(nonatomic,strong)NSArray * titleArray;
//按钮条的背景视图
@property(nonatomic,readonly)UIImageView * segementBackgroundView;
//按钮标题正常颜色
@property(nonatomic,strong)UIColor * titleColorNormal;
//按钮标题选中颜色
@property(nonatomic,strong)UIColor * titleColorSelected;
//标题选中背景颜色
@property(nonatomic,strong)UIColor * titleBackgroundColorSelected;
//头标题是否能滚动,默认为YES;
@property(nonatomic,assign)BOOL * scrollEnble;


@property(nonatomic,assign)id<TPLSegementViewDelegate> delegate;



//视图数组
@property(nonatomic,readonly)NSArray * viewsArray;
//标题按钮数组
@property(nonatomic,readonly)NSArray * titleButtonsArray;



//初始化方法

//改变标题文字方法
/**
 *  改变标题文字的字体
 *
 *  @param titleFont 设定的字体对象
 */
-(void)setTitleFont:(UIFont*)titleFont;




@end

@protocol TPLSegementViewDelegate <NSObject>

//点击第几个按钮触发时间
-(void)clickedItemTitleIndex:(int)index;

@end
