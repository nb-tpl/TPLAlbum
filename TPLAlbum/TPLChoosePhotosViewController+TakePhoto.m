//
//  TPLChoosePhotosViewController+TakePhoto.m
//  GoDataing_LYBT
//
//  Created by NB_TPL on 14-4-21.
//  Copyright (c) 2014年 艾广华. All rights reserved.
//

#import "TPLChoosePhotosViewController+TakePhoto.h"

#import "TPLHelpTool.h"

@implementation TPLChoosePhotosViewController (TakePhoto)



//拍照
-(void)takePhoto
{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}



- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    image = [self dealImage:image];
    
    NSLog(@"%d",image.imageOrientation);
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:0];
    [array addObject:image];
//    [self postPhotosArray:array];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//处理照片方向问题
-(UIImage*)dealImage:(UIImage*)image
{
    UIImage * resultImage;
    switch (image.imageOrientation)
    {
        case 0:
            resultImage = image;
            break;
        case 1:
            resultImage = [TPLHelpTool rotationImage:image withAngle:M_PI];
            break;
        case 2:
            resultImage = [TPLHelpTool rotationImage:image withAngle:M_PI/2.0f];
            break;
        case 3:
            resultImage = [TPLHelpTool rotationImage:image withAngle:M_PI/2.0f];
        default:
            break;
    }
    return resultImage;
}
@end
