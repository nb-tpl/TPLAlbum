//
//  TPLShowInfoPanel.h
//  Matchmaker_LYBT
//
//  Created by NB_TPL on 14-2-25.
//  Copyright (c) 2014年 李红微. All rights reserved.
//
#define HORIZONTAL_SPACE 3.0f
#define HORIZONTAL_HEIGHT 30.0f
#define LEFT_MARGIN 0.0f


#import <UIKit/UIKit.h>

@interface TPLShowInfoPanel : UIView
{
    
}
//展示所用规格
//行数
@property(nonatomic,readonly)int lines;
//竖行行数,默认为1
@property(nonatomic,assign)NSInteger verticalRowCount;
//水平间距,默认为3.0f
@property(nonatomic,assign)CGFloat horizontalSpace;
//水平左边距,默认为5.0f
@property(nonatomic,assign)CGFloat leftMargin;
//水平行高,默认为30
@property(nonatomic,assign)CGFloat horizontalHeight;
//标题文字颜色
@property(nonatomic,strong)UIColor * titleColor;
//标题文字字体
@property(nonatomic,strong)UIFont * titleFont;
//信息文字颜色
@property(nonatomic,strong)UIColor * infoColor;
//信息文字字体
@property(nonatomic,strong)UIFont * infoFont;
//是否折行
@property(nonatomic,assign)BOOL isBreakLine;
//自动适应展示大小
@property(nonatomic,assign)BOOL isFitSize;
//内容对齐方式,默认左对齐
@property(nonatomic,assign)NSTextAlignment infoTextAlignment;
//左侧标题加宽距离,默认为0
@property(nonatomic,assign)CGFloat leftTitleWidthAdd;
//标题带不带冒号,默认不带
@property(nonatomic,assign)BOOL isHaveColon;



//展示方法
/**
 *  根据传入内容展现的方法
 *
 *  @param titleArray 标题数组
 *  @param infoArray  内容数组
 */
-(void)showWithTitleArray:(NSArray*)titleArray andInfoArray:(NSArray*)infoArray;

//将指定竖行的内容向指定方向扩展指定宽度
/**
 *  将指定竖行的内容向指定方向扩展指定宽度
 *
 *  @param width     扩展宽度
 *  @param index     扩展的列
 *  @param direction 扩展的方向，0为左，1为右
 */
-(BOOL)expandWidth:(CGFloat)width forIndex:(NSInteger)index toDirection:(int)direction;

//设定第几行的颜色
/**
 *  设定第几行的颜色
 *
 *  @param lineColor 需要设定的颜色
 *  @param row       第几行
 *
 *  @return 
 */
-(void)setLineColor:(UIColor*)lineColor forRow:(int)row;
/**
 *  设定单数行的颜色
 *
 *  @param singularLineColor 单数行颜色
 *
 *  @return
 */
-(void)setSingularLineColor:(UIColor*)singularLineColor;
/**
 *  设定双数行颜色
 *
 *  @param doubleLineColor 双数行颜色
 *
 *  @return
 */
-(void)setDoubleLineColor:(UIColor*)doubleLineColor;


@end
