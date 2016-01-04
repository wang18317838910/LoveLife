//
//  FoodViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 15/12/29.
//  Copyright © 2015年 CCW. All rights reserved.
//

#import "FoodViewController.h"
#import "NBWaterFlowLayout.h"
#import "FoodCollectionViewCell.h"
#import "FoodTitleCollectionViewCell.h"
#import "FoodModel.h"
#import "PlayViewController.h"
#import "FoodStepViewController.h"
#import "FoodDetailViewController.h"

//视频播放
#import <MediaPlayer/MediaPlayer.h>

//ios下的视频播放
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@interface FoodViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateWaterFlowLayout,playDelegate>
{
    UICollectionView *_collectionView;
    //分类ID
    NSString *_categoryID;
    //左侧标题
    NSString *_titleString;
    //指示条
    UIView *_lineView;
    //分页
    int _page;
}

@property (nonatomic,strong) NSMutableArray *dataArray;
//button数组
@property (nonatomic,strong) NSMutableArray *buttonArray;

@end

@implementation FoodViewController

- (void)viewWillAppear:(BOOL)animated
{
    for (UIButton *btn in self.buttonArray) {
        
        //如果btn是数组里的第一个button
        if (btn == [self.buttonArray firstObject]) {
            
            btn.selected = YES;
            
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self createNav];
    [self createHeaderView];
    [self createCollectionView];
    [self createRefresh];
}

#pragma mark -创建刷新请求数据
- (void)createRefresh
{
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _collectionView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [_collectionView.header beginRefreshing];
}

//下拉刷新
- (void)loadNewData
{
    _page = 0;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self getData];
}

//上拉加载
- (void)loadMoreData
{
    _page ++;
    [self getData];
}

//请求数据
- (void)getData
{
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": _categoryID, @"size": @"20"};
    
    [manage POST:FOODURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 0) {
            //解析数据
            for (NSDictionary *dic in responseObject[@"data"][@"data"]) {
                //字典转模型
                FoodModel *model = [[FoodModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
            }
        }
        
        if (_page == 0) {
            [_collectionView.header endRefreshing];
        }else{
            [_collectionView.footer endRefreshing];
        }
        
        [_collectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark -创建collectionView
- (void)createCollectionView
{
    //创建网格布局对象
    NBWaterFlowLayout *flowLayout = [[NBWaterFlowLayout alloc] init];
    //网格大小
    flowLayout.itemSize = CGSizeMake((Screen_W - 20) / 2, 150);
    //设置列数
    flowLayout.numberOfColumns = 2;
    //设置代理
    flowLayout.delegate = self;
    
    //创建网格对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 45, Screen_W, Screen_H - 40) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    //设置背景色.默认为黑色
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    //注册cell
    [_collectionView registerClass:[FoodTitleCollectionViewCell class] forCellWithReuseIdentifier:@"foodTitleID"];
    
    [_collectionView registerClass:[FoodCollectionViewCell class]forCellWithReuseIdentifier:@"foodID"];
}

#pragma mark -实现collectionview的代理方法
//  确定个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray ? self.dataArray.count + 1 : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //标题cell
        FoodTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodTitleID" forIndexPath:indexPath];
        //赋值
        cell.titleLabel.text = _titleString;
        cell.titleLabel.backgroundColor = RGB(255, 156, 187, 1);
        return cell;
    }else{
        //正文
        FoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodID" forIndexPath:indexPath];
        
        //设置代理
        cell.delegate = self;
        
        // 赋值
        if (self.dataArray) {
            FoodModel *model = self.dataArray[indexPath.row - 1];
            [cell refreshUI:model];
        }
        
        return cell;
    }
}

//设置cell高度
- (CGFloat)collectionView:(UICollectionView *)collectionView waterFlowLayout:(NBWaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30;
    }else{
        return 170;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FoodDetailViewController *footDetail = [[FoodDetailViewController alloc] init];
    //因为数据源的第一个数据是文字所以要减去1,才能保证点击进去的是响应的链接
    FoodModel *model = self.dataArray[indexPath.row - 1];
    footDetail.dishID = model.dishes_id;
    footDetail.foodName = model.title;
    [self.navigationController pushViewController:footDetail animated:YES];
}

#pragma mark -实现自定义的代理方法播放视频
- (void)play:(FoodModel *)model
{
    /*
    //进行视频播放
    //默认播放
  //  MPMoviePlayerController *playVc = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:model.video]];
    
    //强制横屏播放
    PlayViewController *playVc = [[PlayViewController alloc] initWithContentURL:[NSURL URLWithString:model.video]];
   //准备播放
    [playVc.moviePlayer prepareToPlay];
    //开始播放
    [playVc.moviePlayer play];
    //页面跳转
    [self presentViewController:playVc animated:YES completion:nil];
     
     */
    
    //初始化播放器
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
    AVPlayer *avPlayer = [AVPlayer playerWithURL:[NSURL URLWithString:model.video]];
    playerVC.player = avPlayer;
    [self presentViewController:playerVC animated:YES completion:nil];
}

#pragma mark -设置头部分类按钮
- (void)createHeaderView
{
    NSArray *titleArray = @[@"家常菜",@"小炒",@"凉菜",@"烘培"];
    UIView *bgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, Screen_W, 40)];
    [self.view addSubview:bgView];
    
    for (int i = 0; i < titleArray.count; i ++) {
        
        UIButton *headerButton = [FactoryUI createButtonWithFrame:CGRectMake(Screen_W / 4 * i, 0, Screen_W / 4, 40) title:titleArray[i] titleColor:[UIColor lightGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(headerButtonClick:)];
        //设置选中时候的颜色
        [headerButton setTitleColor:RGB(255, 156, 187, 1) forState:UIControlStateSelected];
        
        headerButton.titleLabel.font = [UIFont systemFontOfSize:15];
        headerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        headerButton.tag = 10 + i;
        [bgView addSubview:headerButton];
        
        //将创建的button添加到数组中
        [self.buttonArray addObject:headerButton];
    }
    
    //指示条
    _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, 38, Screen_W / 4, 2)];
    _lineView.backgroundColor = RGB(255, 156, 187, 1);
    [bgView addSubview:_lineView];
   
}

#pragma mark -按钮响应方法
- (void)headerButtonClick:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        
        //指示条位置改变
        _lineView.frame = CGRectMake((button.tag - 10) * Screen_W / 4 , 38, Screen_W / 4, 2);
        
    }];
    
    //保证让每次点击的时候只选中一个按钮
    for (UIButton *btn in self.buttonArray) {
        //如果选中时选中状态为YES,设置为NO
        if (btn.selected == YES) {
            btn.selected = NO;
        }
    }
    //把点击的状态设置为YES
    button.selected = YES;
}

#pragma mark -初始化数据
- (void)initData
{
    _categoryID = @"1";
    _titleString = @"家常菜";
    self.buttonArray = [[NSMutableArray alloc] init];
    
}

#pragma mark -设置导航
- (void)createNav
{
    self.titlelabel.text = @"美食";
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
