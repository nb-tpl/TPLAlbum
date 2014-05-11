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
    //选中效果图
    UIImageView * _overImageView;
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
        
        //加载选中的效果图
        _overImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _overImageView.image = [UIImage imageNamed:@"overlay.png"];
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
        if (_overImageView.superview == nil)
        {
            [self addSubview:_overImageView];
        }
    }
    else
    {
        [_overImageView removeFromSuperview];
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
