//
//  TPLAlbumCollectionView.h
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-11.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <AssetsLibrary/AssetsLibrary.h>

@interface TPLAlbumCollectionView : UIView


//图像资源包
@property(nonatomic,strong)ALAssetsGroup * assetsGroup;



//方法
-(void)reloadData;

@end
