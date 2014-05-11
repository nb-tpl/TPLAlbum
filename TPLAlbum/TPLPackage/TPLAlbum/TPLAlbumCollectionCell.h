//
//  TPLAlbumCollectionCell.h
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-11.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface TPLAlbumCollectionCell : UICollectionViewCell

@property(nonatomic,strong)ALAsset * asset;
@property(nonatomic,strong)UIImage * image;
//是否选中,默认为NO;
@property(nonatomic,assign)BOOL isChoose;


@end
