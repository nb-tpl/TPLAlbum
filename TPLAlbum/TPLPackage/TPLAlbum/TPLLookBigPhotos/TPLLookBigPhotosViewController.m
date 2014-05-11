//
//  TPLLookBigPhotosViewController.m
//  TPLLookBigPhotos
//
//  Created by NB_TPL on 14-4-23.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import "TPLLookBigPhotosViewController.h"
#import "SDImageCache.h"



#import "TPLAutoChangeView.h"


#import "TPLBigPhoto.h"
#import "TPLBigPhotoView.h"


#define kPadding 0
#define kPhotoViewTagOffset 1000
#define kPhotoViewIndex(photoView) ([photoView tag] - kPhotoViewTagOffset)



@interface TPLLookBigPhotosViewController ()<UIScrollViewDelegate>
{
///视图
    TPLAutoChangeView * _photosScrollView;
    
//数据
    // 所有的图片view
	NSMutableSet *_visiblePhotoViews;
    NSMutableSet *_reusablePhotoViews;

    
}


//加载照片视图
-(void)loadPhotosScrollView;
@end

@implementation TPLLookBigPhotosViewController


#pragma mark
#pragma mark           perporty
#pragma mark
//所有图片
-(void)setPhotos:(NSMutableArray *)photos
{
    //清空再加载
    _photos = photos;
    //
    
    for (int i = 0; i<_photos.count; i++) {
        TPLBigPhoto *photo = _photos[i];
        photo.index = i;
    }

}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;

    if ([self isViewLoaded]) {
        _photosScrollView.contentOffset = CGPointMake(_currentPhotoIndex * _photosScrollView.frame.size.width, 0);
        
        // 显示所有的相片
        [self showPhotos];
    }
}



#pragma mark
#pragma mark           init
#pragma mark
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        //初始化
        //可视的
        _visiblePhotoViews = [[NSMutableSet alloc] initWithCapacity:0];
        //非可视的
        _reusablePhotoViews = [[NSMutableSet alloc] initWithCapacity:0];
        
    }
    return self;
}
#pragma mark
#pragma mark           view Life
#pragma mark

//加载照片视图
-(void)loadPhotosScrollView
{
    CGRect frame = self.view.bounds;
    frame.origin.x -= kPadding;
    frame.size.width += (2 * kPadding);
	_photosScrollView = [[TPLAutoChangeView alloc] initWithFrame:frame];
	_photosScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	_photosScrollView.pagingEnabled = YES;
	_photosScrollView.delegate = self;
	_photosScrollView.showsHorizontalScrollIndicator = NO;
	_photosScrollView.showsVerticalScrollIndicator = NO;
	_photosScrollView.backgroundColor = [UIColor clearColor];
    _photosScrollView.contentSize = CGSizeMake(frame.size.width * _photos.count, 0);
	[self.view addSubview:_photosScrollView];
    _photosScrollView.contentOffset = CGPointMake(_currentPhotoIndex * frame.size.width, 0);

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];

    
    [self loadPhotosScrollView];
    
//    UIButton * exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    exitButton.frame = CGRectMake(0, 0, 100, 100);
//    exitButton.backgroundColor = [UIColor orangeColor];
//    [exitButton addTarget:self action:@selector(endShow) forControlEvents:UIControlEventTouchUpInside];
//    [_photosScrollView addSubview:exitButton];

}

#pragma mark
#pragma mark           show BigPhotos
#pragma mark


- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    self.view.backgroundColor = [UIColor blackColor];
    [window.rootViewController addChildViewController:self];
    
    if (_currentPhotoIndex == 0)
    {
        [self showPhotos];
    }
}
//结束展示
-(void)endShow
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

//显示照片
- (void)showPhotos
{
    // 只有一张图片
    if (_photos.count == 1) {
        [self showPhotoViewAtIndex:0];
        return;
    }
    
    CGRect visibleBounds = _photosScrollView.bounds;
	int firstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+kPadding*2) / CGRectGetWidth(visibleBounds));
	int lastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-kPadding*2-1) / CGRectGetWidth(visibleBounds));
    if (firstIndex < 0) firstIndex = 0;
    if (firstIndex >= _photos.count) firstIndex = _photos.count - 1;
    if (lastIndex < 0) lastIndex = 0;
    if (lastIndex >= _photos.count) lastIndex = _photos.count - 1;
	
	// 回收不再显示的ImageView
    NSInteger photoViewIndex;
	for (TPLBigPhotoView *photoView in _visiblePhotoViews) {
        photoViewIndex = kPhotoViewIndex(photoView);
		if (photoViewIndex < firstIndex || photoViewIndex > lastIndex)
        {
			[_reusablePhotoViews addObject:photoView];
			[photoView removeFromSuperview];
		}
	}
    
	[_visiblePhotoViews minusSet:_reusablePhotoViews];
    while (_reusablePhotoViews.count > 2) {
        [_reusablePhotoViews removeObject:[_reusablePhotoViews anyObject]];
    }
	
	for (NSUInteger index = firstIndex; index <= lastIndex; index++) {
		if (![self isShowingPhotoViewAtIndex:index]) {
			[self showPhotoViewAtIndex:index];
		}
	}
}

- (void)showPhotoViewAtIndex:(int)index
{
    TPLBigPhotoView *photoView = [self dequeueReusablePhotoView];
    if (!photoView) { // 添加新的图片view
        photoView = [[TPLBigPhotoView alloc] init];
    }
    
    // 调整当期页的frame
    CGRect bounds = _photosScrollView.bounds;
    CGRect photoViewFrame = bounds;
    photoViewFrame.size.width -= (2 * kPadding);
    photoViewFrame.origin.x = (bounds.size.width * index) + kPadding;
    photoView.tag = kPhotoViewTagOffset + index;
    
    TPLBigPhoto *photo = _photos[index];
    photoView.frame = photoViewFrame;
    photoView.bigPhoto = photo;
    
    [_visiblePhotoViews addObject:photoView];
    [_photosScrollView addSubview:photoView];
    
//    [self loadImageNearIndex:index];
}

//index这页是否正在显示
- (BOOL)isShowingPhotoViewAtIndex:(NSUInteger)index {
	for (TPLBigPhotoView *photoView in _visiblePhotoViews) {
		if (kPhotoViewIndex(photoView) == index) {
            return YES;
        }
    }
	return  NO;
}

//循环利用某个view
- (TPLBigPhotoView *)dequeueReusablePhotoView
{
    TPLBigPhotoView *photoView = [_reusablePhotoViews anyObject];
	if (photoView) {
		[_reusablePhotoViews removeObject:photoView];
	}
	return photoView;
}
////加载index附近的图片
//- (void)loadImageNearIndex:(int)index
//{
//    if (index > 0) {
//        TPLBigPhoto *photo = _photos[index - 1];
//    }
//    
//    if (index < _photos.count - 1) {
//        TPLBigPhoto *photo = _photos[index + 1];
//    }
//}

////加载缓存图片
//-(void)downloadWithUrl:(NSURL*)url
//{
//    [[SDWebImageManager sharedManager] downloadWithURL:url options:SDWebImageLowPriority|SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//        
//    }];
//}


#pragma mark
#pragma mark           UIScrollViewDelegate
#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self showPhotos];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
