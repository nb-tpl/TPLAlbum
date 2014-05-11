//
//  TPLChoosePhotosViewController.m
//  GoDataing_LYBT
//
//  Created by NB_TPL on 14-4-21.
//  Copyright (c) 2014年 艾广华. All rights reserved.
//

#import "TPLChoosePhotosViewController.h"
#import "TPLAblumViewController.h"


#import "TPLChoosePhotosViewController+TakePhoto.h"

#import "TPLHelpTool.h"


//#import "ASIFormDataRequest.h"


#define OKButton_Tag 577
@interface TPLChoosePhotosViewController ()//<ASIHTTPRequestDelegate>
{
///数据
    //多选相册控制器
    TPLAblumViewController * _ablumVC;
///视图
//    MBProgressHUD * _hud;
}

//加载头部
-(void)loadHeadView;
//加载相册
-(void)loadAblumView;
//加载底部视图
-(void)loadButtomView;

@end

@implementation TPLChoosePhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark
#pragma mark           view life
#pragma mark
//加载头部
-(void)loadHeadView
{
    [self.returnBtn addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    titleLable.text = @"相册";
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [TPLHelpTool getHexColor:@"#161616"];
    titleLable.font = [UIFont boldSystemFontOfSize:20.0f];
    [self.view addSubview:titleLable];
    
    //拍照按钮
    UIButton * takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhotoButton addTarget:self action:@selector(takePhotoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    takePhotoButton.frame = CGRectMake(self.navBg.frame.size.width - 60, 0, 70, 44);
    [takePhotoButton setTitle:@"相机" forState:UIControlStateNormal];
    [takePhotoButton setTitleColor:[TPLHelpTool getHexColor:@"ff5b00"] forState:UIControlStateNormal];
    [self.view addSubview:takePhotoButton];
    
    
 
}
//加载相册
-(void)loadAblumView
{
    _ablumVC = [[TPLAblumViewController alloc] init];
    _ablumVC.view.autoresizesSubviews = YES;
    _ablumVC.maxChooseNumber = 5;
    _ablumVC.view.frame = CGRectMake(self.view.bounds.origin.x,44, self.view.bounds.size.width, self.view.bounds.size.height - self.navBg.frame.size.height - 44);
    [self.view addSubview:_ablumVC.view];
    
}
//加载底部视图
-(void)loadButtomView
{
    UIButton * okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
//    [okButton setTitleColor:[TPLHelpTool getHexColor:@"ff5b00"] forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    okButton.frame = CGRectMake(_ablumVC.view.frame.origin.x, _ablumVC.view.frame.origin.y + _ablumVC.view.frame.size.height, 320, 44);
    okButton.userInteractionEnabled = NO;
    okButton.tag = OKButton_Tag;
    okButton.backgroundColor = [UIColor whiteColor];
    [okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    
    
    UIButton * changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeButton setTitle:@"切换" forState:UIControlStateNormal];
    [changeButton setTitleColor:[TPLHelpTool getHexColor:@"ff5b00"] forState:UIControlStateNormal];
    changeButton.frame = CGRectMake(260, okButton.frame.origin.y + 1, 60, 43);
    changeButton.backgroundColor = [UIColor whiteColor];
    [changeButton addTarget:_ablumVC action:@selector(changeSite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
    
    
    UIView * lineView = [TPLHelpTool createALineViewWithLineColor:[TPLHelpTool getHexColor:@"#ff5b00"] lineWidth:1.0];
    lineView.frame = CGRectMake(0, 0, okButton.frame.size.width, 1);
    [okButton addSubview:lineView];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    //加载头
    [self loadHeadView];
    //加载相册
    [self loadAblumView];
    //加载底部视图
    [self loadButtomView];
    
    
    __weak __block UIButton * button = (UIButton*)[self.view viewWithTag:OKButton_Tag];
    _ablumVC.cellClickedBlock = ^(TPLAlbumCollectionView * tplAlbumCollectionView,NSIndexPath * selectItemIndexPath)
    {
        if (tplAlbumCollectionView.chooseCount > 0)
        {
            [button setTitleColor:[TPLHelpTool getHexColor:@"ff5b00"] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            
        }
        else
        {
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            
            
        }
    };

    
    
}
#pragma mark
#pragma mark           Request
#pragma mark
-(void)postPhotosArray:(NSMutableArray*)photosArray
{
}
////请求成功
//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//}
////请求失败
//-(void)requestFailed:(ASIHTTPRequest *)request
//{
//    _hud.hidden = YES;
//    
//    //提示警告框失败...
//    [TPLCommon showSignInfoWithTitle:NSLocalizedString(@"warmSign", nil) detailInfo:NSLocalizedString(@"checkNetWorking", nil) inView:self.view];
//}
#pragma mark
#pragma mark           dealData
#pragma mark
-(NSMutableArray*)dealChoosePhotos
{
    NSMutableArray * photosArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(id choose in _ablumVC.tplAlbumCollectionView.choosePhotosArray)
    {
        if (![choose isKindOfClass:[NSNull class]])
        {
            ALAsset * asset = choose;
//            UIImage * photo = [UIImage imageWithCGImage:asset.thumbnail];
            UIImage * photo = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
            [photosArray addObject:photo];
        }
    }
    return photosArray;
}

#pragma mark
#pragma mark           button Clicked
#pragma mark
//返回按钮
-(void)backButtonClicked
{
    //    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.navigationController != nil)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//拍照
-(void)takePhotoButtonClicked
{
    [self takePhoto];
}


//确定按钮
-(void)okButtonClicked
{
//    _hud = [[MBProgressHUD alloc] initWithView:self.view];
//    _hud.dimBackground = YES;
//    [self.view addSubview:_hud];
//    _hud.detailsLabelText = @"正在上传...";
//    [_hud show:YES];
//    
    NSMutableArray * photosArray = [self dealChoosePhotos];
    
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否上传%d张图片",photosArray.count] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
//    [self postPhotosArray:photosArray];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
