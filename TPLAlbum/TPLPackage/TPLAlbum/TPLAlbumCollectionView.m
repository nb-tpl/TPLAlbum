//
//  TPLAlbumCollectionView.m
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-11.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#import "TPLAlbumCollectionView.h"
#import "TPLAlbumCollectionCell.h"
@interface TPLAlbumCollectionView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
///数据
    //图片数组
    NSMutableArray * _assetsArray;
    //选中的Cell数组
    NSMutableArray * _choosePhotosArray;
///相册展示视图
    UICollectionView * _photosCollectionView;
    
}

@end;

@implementation TPLAlbumCollectionView
@synthesize assetsGroup = _assetsGroup;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor lightGrayColor];
        //初始化数据
        _assetsGroup = nil;
        _assetsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _choosePhotosArray = [[NSMutableArray alloc] initWithCapacity:0];
        //加上图片展示视图
        //创建CollectionView的布局类
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //处理布局类
        flowLayout = [self dealFlowLayout:flowLayout];
        _photosCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _photosCollectionView.backgroundColor = [UIColor orangeColor];
        _photosCollectionView.dataSource = self;
        _photosCollectionView.delegate = self;
        [_photosCollectionView registerClass:[TPLAlbumCollectionCell class] forCellWithReuseIdentifier:@"photoItem"];
        [self addSubview:_photosCollectionView];
    }
    return self;
}
#pragma mark
#pragma mark           perporty Function
#pragma mark
-(void)setAssetsGroup:(ALAssetsGroup *)assetsGroup
{
    _assetsGroup = assetsGroup;
    [_assetsArray removeAllObjects];
    [_choosePhotosArray removeAllObjects];
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result) {
            [_assetsArray addObject:result];
            [_choosePhotosArray addObject:[NSNull null]];
        }
        if (stop)
        {
            [self reloadData];
        }
    }];

}
#pragma mark
#pragma mark           deal Function
#pragma mark
//处理布局
-(UICollectionViewFlowLayout*)dealFlowLayout:(UICollectionViewFlowLayout*)flowLayout
{
    CGFloat size = (self.bounds.size.width - 6)/3.0f;
    flowLayout.minimumInteritemSpacing = 3.0f;
    flowLayout.minimumLineSpacing = 3.0f;
    
    flowLayout.itemSize=CGSizeMake(size,size);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return flowLayout;
}

//重刷新数据
-(void)reloadData
{
    [_photosCollectionView reloadData];
}


#pragma mark
#pragma mark           UICollectionViewDataSource&UICollectionViewDelegateFlowLayout
#pragma mark
//dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_assetsGroup == nil)
    {
        return 0;
    }
    return _assetsGroup.numberOfAssets;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TPLAlbumCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoItem" forIndexPath:indexPath];
    if (!cell) {
        
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.asset = [_assetsArray objectAtIndex:indexPath.row];
    if (![[_choosePhotosArray objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]])
    {
        cell.isChoose = YES;
    }

    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TPLAlbumCollectionCell * cell = (TPLAlbumCollectionCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if ([[_choosePhotosArray objectAtIndex:indexPath.row] isKindOfClass:[NSNull class]])
    {
        [_choosePhotosArray replaceObjectAtIndex:indexPath.row withObject:cell.asset];
        cell.isChoose = YES;
    }
    else
    {
        [_choosePhotosArray replaceObjectAtIndex:indexPath.row withObject:[NSNull null]];
        cell.isChoose = NO;
    }
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
