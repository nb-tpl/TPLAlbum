//
//  TPLMutableTextLabel.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-3-24.
//  Copyright (c) 2014年 李红微. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPLMutableTextLabel : UIView

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


@end
