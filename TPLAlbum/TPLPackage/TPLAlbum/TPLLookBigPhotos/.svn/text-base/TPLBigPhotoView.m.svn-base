//
//  TPLBigPhotoView.m
//  GoDataing_LYBT
//
//  Created by NB_TPL on 14-4-24.
//  Copyright (c) 2014年 艾广华. All rights reserved.
//

#import "TPLBigPhotoView.h"

#import "TPLBigPhoto.h"

#import "UIImageView+WebCache.h"

@interface TPLBigPhotoView ()<UIScrollViewDelegate>
{
///视图
    //图片框
    UIImageView *_imageView;

}

@end

@implementation TPLBigPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        // 图片框
		_imageView = [[UIImageView alloc] init];
		[self addSubview:_imageView];
        
        self.backgroundColor = [UIColor clearColor];
        
//        _imageView.backgroundColor = [TPLHelpTool cl];
        
        
        self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.delegate = self;
        



    }
    return self;
}

#pragma mark
#pragma mark           show photo
#pragma mark
- (void)setBigPhoto:(TPLBigPhoto *)bigPhoto {
    _bigPhoto = bigPhoto;
    
    [self showImage];
}

//显示图片
- (void)showImage
{
    if (_bigPhoto.image == nil)
    {
        __weak TPLBigPhotoView *photoView = self;
        __weak TPLBigPhoto *photo = _bigPhoto;
        [_imageView setImageWithURL:_bigPhoto.url placeholderImage:_bigPhoto.placeHolderImage options:SDWebImageRetryFailed|SDWebImageLowPriority success:^(UIImage * image,BOOL cached){
            photo.image = image;
            // 调整frame参数
            [photoView adjustFrame];
        }  failure:^(NSError * error){
            
        }];
    }
    else
    {
        self.scrollEnabled = YES;
        _imageView.image = _bigPhoto.image;
    }
    
    // 调整frame参数
    [self adjustFrame];
}


//调整尺寸
- (void)adjustFrame
{
	if (_imageView.image == nil) return;
    
    // 基本尺寸参数
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
	
	// 设置伸缩比例
    CGFloat widthRatio = boundsWidth/imageWidth;
    CGFloat heightRatio = boundsHeight/imageHeight;
    CGFloat minScale = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    if (minScale >= 1) {
		minScale = 0.8;
	}
    
	CGFloat maxScale = 4.0;
    
    
	self.maximumZoomScale = maxScale;
	self.minimumZoomScale = minScale;
	self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * boundsWidth / imageWidth);
    // 内容尺寸
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // 宽大
    if ( imageWidth <= imageHeight &&  imageHeight <  boundsHeight ) {
        imageFrame.origin.x = floorf( (boundsWidth - imageFrame.size.width ) / 2.0) * minScale;
        imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0) * minScale;
    }else{
        imageFrame.origin.x = floorf( (boundsWidth - imageFrame.size.width ) / 2.0);
        imageFrame.origin.y = floorf( (boundsHeight - imageFrame.size.height ) / 2.0);
    }
    
    
    
        _imageView.frame = imageFrame;
}

#pragma mark
#pragma mark           UIScrollViewDelegate
#pragma mark
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
	return _imageView;
}

// 让UIImageView在UIScrollView缩放后居中显示
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
