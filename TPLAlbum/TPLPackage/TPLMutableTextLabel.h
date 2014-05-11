//
//  TPLMutableTextLabel.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-3-24.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPLMutableTextLabel : UIImageView

//显示的字体
@property(nonatomic,strong)UIFont * font;
//显示的字体颜色
@property(nonatomic,strong)UIColor * textColor;
//每行的高度
@property(nonatomic,assign)CGFloat  lineHeight;
//显示的文字
@property(nonatomic,strong)NSString * text;
//是否自动改变Frame
@property(nonatomic,assign)BOOL isAutoChangeFrame;
//文字对齐方式
@property(nonatomic,assign)NSTextAlignment textAlignment;

//内容左缩进
@property(nonatomic,assign)CGFloat contentLeftPadding;
//内容右缩进
@property(nonatomic,assign)CGFloat contentRightPadding;
//内容上缩进
@property(nonatomic,assign)CGFloat contentTopPadding;
//内容下缩进
@property(nonatomic,assign)CGFloat contentBottomPadding;
//缩进总
@property(nonatomic,assign)UIEdgeInsets contentEdgeInsets;




//是否用于展现消息
@property(nonatomic,assign)BOOL isUseForMessage;


@end
