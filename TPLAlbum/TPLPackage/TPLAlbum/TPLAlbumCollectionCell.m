//
//  TPLAlbumCollectionCell.m
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-11.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import "TPLAlbumCollectionCell.h"
@interface TPLAlbumCollectionCell()
{
    UIImageView * _imageView;
}
//创建展示相框
-(void)loadImageView;
@end;

@implementation TPLAlbumCollectionCell
@synthesize asset = _asset,image = _image,isChoose = _isChoose;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isChoose = NO;
        [self loadImageView];
    }
    return self;
}
#pragma mark
#pragma mark           perporty
#pragma mark
-(void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    _imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = image;
}

-(void)setIsChoose:(BOOL)isChoose
{
    _isChoose = isChoose;
    if (isChoose)
    {
        _imageView.image = nil;
    }
    else
    {
        _imageView.image = [UIImage imageWithCGImage:_asset.thumbnail];
    }
}
#pragma mark
#pragma mark           load view life
#pragma mark
//创建展示相框
-(void)loadImageView
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
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
