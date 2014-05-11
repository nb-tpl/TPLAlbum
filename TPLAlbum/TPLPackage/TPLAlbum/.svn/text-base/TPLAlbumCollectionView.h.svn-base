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
//被选择的数组
@property(nonatomic,readonly)NSMutableArray * choosePhotosArray;
//最大多选数
@property(nonatomic,assign)NSInteger maxChooseNumber;
//被选中数
@property(nonatomic,readonly)int chooseCount;





//被点击的Block
@property(nonatomic,strong)void(^cellClickedBlock)(TPLAlbumCollectionView * tplAlbumCollectionView,NSIndexPath * selectItemIndexPath);



//方法
-(void)reloadData;

@end
