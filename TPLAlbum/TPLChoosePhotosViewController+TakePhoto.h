//
//  TPLChoosePhotosViewController+TakePhoto.h
//  GoDataing_LYBT
//
//  Created by NB_TPL on 14-4-21.
//  Copyright (c) 2014年 艾广华. All rights reserved.
//

#import "TPLChoosePhotosViewController.h"

@interface TPLChoosePhotosViewController (TakePhoto)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

//拍照
-(void)takePhoto;


@end
