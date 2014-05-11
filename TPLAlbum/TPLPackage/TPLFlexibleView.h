//
//  TPLFlexibleView.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-25.
//  Copyright (c) 2014年 李红微. All rights reserved.
//
#define FLEXIBLE_BUTTON_HEIGHT_DEFAULT 30.0f

#import <UIKit/UIKit.h>

@class TPLAutoChangeView;

@interface TPLFlexibleView : UIView



//按钮数组
@property(nonatomic,readonly)NSArray * buttonsArray;
//视图数组
@property(nonatomic,readonly)NSArray * viewsArray;
//标题按钮高度
@property(nonatomic,assign)CGFloat titleButtonHeight;
//视图个数
@property(nonatomic,assign)NSInteger viewsCount;
//正常状态的标志图像
@property(nonatomic,strong)UIImage * stateNormalImage;
//选中状态的标志图像
@property(nonatomic,strong)UIImage * stateSelectedImage;
//获得展现的滚动视图
@property(nonatomic,readonly)TPLAutoChangeView * autoChangeView;




@end
