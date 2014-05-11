//
//  TPLLookBigPhotosViewController.h
//  TPLLookBigPhotos
//
//  Created by NB_TPL on 14-4-23.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPLLookBigPhotosViewController : UIViewController


// 所有的图片对象
@property (nonatomic, strong) NSMutableArray * photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;





// 直接显示在屏幕最上方
- (void)show;
//手动显示
//显示照片
- (void)showPhotos;

@end
