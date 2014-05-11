//
//  TPLAblumViewController.h
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-11.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPLAlbumCollectionView.h"

#import <AssetsLibrary/AssetsLibrary.h>


@interface TPLAblumViewController : UIViewController
{
    
}

@property(nonatomic,readonly)TPLAlbumCollectionView * tplAlbumCollectionView;
//最大多选数
@property(nonatomic,assign)NSInteger maxChooseNumber;


//被点击的Block
@property(nonatomic,strong)void(^cellClickedBlock)(TPLAlbumCollectionView * tplAlbumCollectionView,NSIndexPath * selectItemIndexPath);



//切换位置
-(void)changeSite;

@end
