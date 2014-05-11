//
//  ViewController.m
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-10.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import "ViewController.h"

//#import "TPLAblumViewController.h"
#import "TPLChoosePhotosViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * albumButton = [UIButton buttonWithType:UIButtonTypeCustom];
    albumButton.titleLabel.text = @"album";
    
    [albumButton setTitle:@"album" forState:UIControlStateNormal];
    albumButton.frame = CGRectMake(0, 0, 100, 100);
    [albumButton addTarget:self action:@selector(albumClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumButton];
    
}
-(void)albumClicked
{
    TPLChoosePhotosViewController * tplChoosePhotoVC = [[TPLChoosePhotosViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:tplChoosePhotoVC];
    [self presentViewController:nav animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
