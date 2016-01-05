//
//  MusicPlayViewController.m
//  LoveLife
//
//  Created by qiaqnfeng on 16/1/5.
//  Copyright © 2016年 CCW. All rights reserved.
//

#import "MusicPlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicPlayViewController ()<AVAudioPlayerDelegate>
{
    UISlider *_slider;
    //播放器
    AVAudioPlayer *_player;
    
    //歌名
    UILabel *_titleLabel;
    //图片
    UIImageView *_imageView;
    //歌手
    UILabel *_authorLabel;
    
}
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation MusicPlayViewController

#pragma mark -切换导航
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   //  UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.coverURL]]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"15f81d189d5044b8ff2f825c0cbf1d24.jpg"]];
    [self createUI];
    
    //1创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //2创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //3.启用异步方法
    dispatch_group_async(group, queue, ^{
        
         [self createAVAudioPlayer];
    });
    
    //创建一个定时器,改变slide的值
    [self createTimer];
}

#pragma mark - 创建一个定时器,改变slide的值
- (void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(sliderVauleChange) userInfo:nil repeats:YES];
    
    //设置后台播放模式 AVAudioSession指的是一个音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //在后台保持活跃
    [session setActive:YES error:nil];
    
    //拔出耳机后暂停播放,,通过观察者监测
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isHasDevice:) name:AVAudioSessionRouteChangeNotification object:nil];
}

#pragma mark - 监听是否有耳机
- (void)isHasDevice:(NSNotification *)notification
{
    NSDictionary *dic = notification.userInfo;
    int changeReason = [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    
    if (changeReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        
        AVAudioSessionRouteDescription *routeDescription = dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription = [routeDescription.outputs firstObject];
        
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"]) {
            if ([_player isPlaying])
            {
                [_player pause];
                
                self.timer.fireDate = [NSDate distantFuture];
            }
        }
    }
}

#pragma mark -创建音乐播放器
- (void)createAVAudioPlayer
{
    //NSURL创建,,播放本地的音频url
    //_player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:@""] error:nil];
    
    _player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlArray[_currentIndex]]] error:nil];
    
    NSLog(@"createAVAudioPlayer%@",_titleLabel.text);
    
    //设置代理
    _player.delegate = self;
    //音量
    _player.volume = 0.5;//0--1之间
    //当前播放进度
    _player.currentTime = 0;
//    /设置循环次数  负数表示无限循环  0表示一次  正数是几就是几次
    _player.numberOfLoops = -1;
    
    //只读属性
//    _player.isPlaying //是否正在播放
//    _player.numberOfChannels //声道数
//    _player.duration //持续时间
    
    //预播放,,将播放资源添加在播放器中,播放器自己分配播放队列
    [_player prepareToPlay];
}

#pragma mark -创建UI
- (void)createUI
{
    //返回按钮
    UIButton *backButton = [FactoryUI createButtonWithFrame:CGRectMake(10, 20, 30, 30) title:nil titleColor:nil imageName:@"iconfont-fanhui" backgroundImageName:nil target:self selector:@selector(backButtonClick)];
    [self.view addSubview:backButton];
    
    //标题
    UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, 40, Screen_W, 30) text:self.titleArray[_currentIndex] textColor:nil font:[UIFont systemFontOfSize:14]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    _titleLabel = titleLabel;
    
    NSLog(@"createUI%@",_titleLabel.text);
    
    //演唱者
    UILabel *authorLabel = [FactoryUI createLabelWithFrame:CGRectMake((Screen_W - 100), titleLabel.frame.size.height + titleLabel.frame.origin.y + 10, 150, 20) text:self.artistArray[_currentIndex] textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
    [self.view addSubview:authorLabel];
    
    _authorLabel = authorLabel;
    
    //图片
    UIImageView *imageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, authorLabel.frame.size.height + authorLabel.frame.origin.y, (Screen_W - 20) , (Screen_H - 20) / 2) imageName:nil];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[_currentIndex]] placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:imageView];
    _imageView = imageView;
    
    //
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(10, imageView.frame.size.height + imageView.frame.origin.y + 20, (Screen_W - 20), 20)];
    
    //设置初始时value
    _slider.value = 0.0;
    
    //添加事件
    [_slider addTarget:self action:@selector(slideChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    //创建按钮
    NSArray *buttonImageArray = @[@"iconfont-bofangqishangyiqu",@"iconfont-musicbofang",@"iconfont-bofangqixiayiqu"];
    for (int i = 0; i < buttonImageArray.count; i ++) {
        
        UIButton *button = [FactoryUI createButtonWithFrame:CGRectMake(100 + i * 60, _slider.frame.size.height + _slider.frame.origin.y + 30, 40, 40) title:nil titleColor:nil imageName:buttonImageArray[i] backgroundImageName:nil target:self selector:@selector(playButtonClick:)];
        button.tag = 10 + i;
        [self.view addSubview:button];
    }
}

#pragma mark - 定时器监测slider的value
- (void)sliderVauleChange
{
    _slider.value = _player.currentTime / _player.duration;
}

#pragma mark - 指示条
- (void)slideChange:(UISlider *)slider
{
    _player.currentTime = slider.value * _player.duration;
}

#pragma mark - 按钮点击事件
- (void)playButtonClick:(UIButton *)button
{
    switch (button.tag - 10) {
        case 0:
        //上一曲
            //停止当前播放的文件
            [_player stop];
            //如果是第一首,就播放最后一首达到循环效果
            if (_currentIndex == 0) {
                
                _currentIndex = (int)self.urlArray.count - 1;
                
            }
            _currentIndex --;
            
            [self createAVAudioPlayer];
            
            [self refreshMusicUI];
            
            [_player play];
            
            break;
            
        case 1:
            //播放暂停
            //判断如果图标是正在播放,则暂停,改变按钮的状态为播放
            if (_player.isPlaying) {
                
                [button setImage:[UIImage imageNamed:@"iconfont-musicbofang"] forState:UIControlStateNormal];
                [_player pause];//暂停
                
                //播放器暂停时定时器也停止
                [self.timer setFireDate:[NSDate distantFuture]];
                
            }else
            {
                //如果图标是暂停,,就把状态改为播放
                [button setImage:[UIImage imageNamed:@"iconfont-zanting"] forState:UIControlStateNormal];
                
                [_player play];
                //重启定时器
                [self.timer setFireDate:[NSDate distantPast]];
                [self.timer invalidate];//销毁定时器,以后无法恢复
                
            }
            break;
            
        case 2:
            //下一曲
            
            [_player stop];
        //如果是最后一首歌,点击下一曲播放第一首
            if (_currentIndex == self.urlArray.count - 1) {
                
                _currentIndex = 0;
            }
            
            _currentIndex ++;
            [self createAVAudioPlayer];
            
             [self refreshMusicUI];
            
            [_player play];
            
            break;
            
        default:
            break;
    }
}

#pragma mark - 刷新UI
- (void)refreshMusicUI
{
    //标题
    _titleLabel.text = self.titleArray[_currentIndex];
    //NSLog(@"refreshMusicUI%@",_titleLabel.text);
    
    //歌手
    _authorLabel.text = self.artistArray[_currentIndex];
     //NSLog(@"refreshMusicUI%@",_authorLabel.text);
    
    //图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[_currentIndex]] placeholderImage:[UIImage imageNamed:@""]];
    
    
    //设置初始时value
    _slider.value = 0.0;
    
    //添加事件
    [_slider addTarget:self action:@selector(slideChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
}

#pragma mark -实现播放器的代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag) {
        
        //说明音频文件是正常播放完毕的
    }else{
        //音频文件虽然播放完了,但是数据解码错误
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@" 对音频文件--解码错误");
}

//ios8之后被废弃掉了,,之后自动做处理
//开始被中断,比如说用户home键返回或者突然来电打断
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    //暂停播放器
    [_player pause];
}

//中断结束回到播放器接着播放
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    //继续播放
    [_player play];
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
