//
//  CommenViewController.h
//  GoDataing_LYBT
//
//  Created by 艾广华 on 14-4-8.
//  Copyright (c) 2014年 艾广华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommenViewController : UIViewController

//数据接收成功
-(void)AReciveSucess:(NSNotification *)note;
//数据接收失败
-(void)AReciveFail:(NSNotification *)note;

@property(nonatomic,retain)UIImageView *navBg;
@property(nonatomic,retain)UIButton *returnBtn;
@property(nonatomic,retain)UILabel *navLbl;

@end
