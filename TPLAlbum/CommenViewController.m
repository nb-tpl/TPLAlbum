//
//  CommenViewController.m
//  GoDataing_LYBT
//
//  Created by 艾广华 on 14-4-8.
//  Copyright (c) 2014年 艾广华. All rights reserved.
//

#import "CommenViewController.h"

@interface CommenViewController ()

@end

@implementation CommenViewController

@synthesize navBg,navLbl,returnBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}
-(void)loadView{
    [super loadView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建导航条
    navBg=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,44)];
    navBg.image=[UIImage imageNamed:@"u_bg_04.png"];
    [self.view addSubview:navBg];
    //如果设备的系统的7.0以上
    if([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0f){
        self.view.bounds=CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.view.backgroundColor=[UIColor colorWithWhite:0.9f alpha:200.0f];
        navBg.frame=CGRectMake(0, -20, 320, 64);
    }
    navLbl=[[UILabel alloc]initWithFrame:CGRectMake(0,0,320,44)];
    navLbl.backgroundColor=[UIColor clearColor];
    [navLbl setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [navLbl setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:navLbl];
    //返回按钮
    returnBtn=[UIButton buttonWithType:0];
    returnBtn.frame=CGRectMake(0,0,50,44);
    returnBtn.backgroundColor=[UIColor clearColor];
    UIImageView *returnIg=[[UIImageView alloc]initWithFrame:CGRectMake(15,15,15,15)];
    returnIg.image=[UIImage imageNamed:@"u_ico_03.png"];
    [returnBtn addSubview:returnIg];
    [self.view addSubview:returnBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
