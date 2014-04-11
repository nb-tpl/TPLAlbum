//
//  ViewController.m
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-10.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import "ViewController.h"

#import "TPLAblumViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    TPLAblumViewController * TPLAblumVC = [[TPLAblumViewController alloc] init];
    [self presentViewController:TPLAblumVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
