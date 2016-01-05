//
//  MusicViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicCollectionViewCell.h"
#import "MusicReusableView.h"//头脚视图
#import "MusicDetailViewController.h"


@interface MusicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (nonatomic,strong) NSArray *nameArray;
@property (nonatomic,strong) NSArray *urlArray;
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initArray];
    [self settingNav];
    [self createUI];
}

#pragma mark -创建UI
- (void)createUI
{
    //创建网格布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerClass:[MusicCollectionViewCell class] forCellWithReuseIdentifier:@"musicId"];
    
    //注册header和footer
    [_collectionView registerClass:[MusicReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
    
    [_collectionView registerClass:[MusicReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"view"];
}

#pragma mark -实现代理方法
//确定section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//确定每个section对应的item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//创建cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"musicId" forIndexPath:indexPath];
    //图片
    [cell.imageView setImage:[UIImage imageNamed:self.imageArray[indexPath.item]]];
    //文字
    cell.titleLabel.text = self.nameArray[indexPath.item];
    return cell;
}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Screen_W - 20) / 2, 150);
}

//设置垂直的间距 默认的垂直和水平间距都是10
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//设置水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

//四周的间距,上左下右
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//设置header的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

//设置footer的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(60, 30);
}

//设置header和footer的view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    MusicReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    //分别给header和footer赋值
    if (kind == UICollectionElementKindSectionHeader) {
        
        view.titleLabel.text = @"段头";
    }else{
        view.titleLabel.text = @"段尾";
    }
    
    return view;
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicDetailViewController *music = [[MusicDetailViewController alloc] init];
    //传值
    music.typeString = self.nameArray[indexPath.item];
    music.urlString = self.urlArray[indexPath.item];
    
    music.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:music animated:YES];
}

#pragma  mark -设置导航
- (void)settingNav
{
    self.titlelabel.text = @"音乐";
}

#pragma  mark -初始化数组
- (void)initArray
{
<<<<<<< Updated upstream
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语",@"歌曲排行榜"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu,paihangbang];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13",@"shili24"];
=======
    self.nameArray = @[@"流行",@"新歌",@"华语",@"英语",@"日语",@"轻音乐",@"民谣",@"韩语"];
    self.urlArray = @[liuxing,xinge,huayu,yingyu,riyu,qingyinyue,minyao,hanyu];
    self.imageArray = @[@"shili0",@"shili1",@"shili2",@"shili8",@"shili10",@"shili19",@"shili15",@"shili13"];
>>>>>>> Stashed changes
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
