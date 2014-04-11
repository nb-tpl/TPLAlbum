//
//  TPLAblumViewController.m
//  TPLAlbum
//
//  Created by NB_TPL on 14-4-11.
//  Copyright (c) 2014年 NB_TPL. All rights reserved.
//

#define GroupTable_Width_Default 50

#import "TPLAblumViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface TPLAblumViewController ()<UITableViewDataSource,UITableViewDelegate>
{
///查询相册Block
//    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *,BOOL *);
//    void (^assetsGroupsFailureBlock)(NSError *);
///相册数据
    ALAssetsLibrary * _assetsLibrary;
    __strong NSMutableArray * _assetsGroups;
///视图
    UITableView * _assetsGroupsTable;
}

///视图加载
//加载左边相册滚动视图
-(void)loadAssetsGroupsTable;

@end

@implementation TPLAblumViewController

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
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
        _assetsGroups = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#pragma mark
#pragma mark           view life
#pragma mark
///视图加载
//加载左边相册滚动视图
-(void)loadAssetsGroupsTable
{
    _assetsGroupsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,GroupTable_Width_Default, self.view.bounds.size.height)];
    _assetsGroupsTable.layer.borderColor = [UIColor redColor].CGColor;
    _assetsGroupsTable.backgroundColor = [UIColor greenColor];
    _assetsGroupsTable.delegate = self;
    _assetsGroupsTable.dataSource = self;
    [self.view addSubview:_assetsGroupsTable];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    //加载相册滚动选择视图
    [self loadAssetsGroupsTable];
    
    
    //枚举相册的Block
    void (^assetsGroupsEnumerationBlock)(ALAssetsGroup *,BOOL *) = ^(ALAssetsGroup *assetsGroup, BOOL *stop) {
        [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
        if (assetsGroup.numberOfAssets > 0)
        {
            [_assetsGroups addObject:assetsGroup];
            [_assetsGroupsTable reloadData];
        }
        
    };
    //查找相册失败block
    void(^assetsGroupsFailureBlock)(NSError *) = ^(NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    };
    
    
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:assetsGroupsEnumerationBlock failureBlock:assetsGroupsFailureBlock];

}


#pragma mark
#pragma mark           UITableViewDataSource&UItableViewDelegate
#pragma mark
//DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//   return  _assetsGroups.count;
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellName = @"groupCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        //相册名字
        UILabel * groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, 20)];
        groupNameLabel.tag = 1001;
        [cell addSubview:groupNameLabel];
    }
    //相册姓名
    UILabel * groupNameLabel = (UILabel*)[cell viewWithTag:1001];
    groupNameLabel.text = [[_assetsGroups objectAtIndex:indexPath.row]
                           objectForKey:ALAssetsGroupPropertyName];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
