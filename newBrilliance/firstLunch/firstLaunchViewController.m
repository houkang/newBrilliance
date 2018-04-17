//
//  firstLaunchViewController.m
//  newBrilliance
//
//  Created by 软件工程系01 on 2018/4/16.
//  Copyright © 2018年 软件工程系01. All rights reserved.
//

#import "firstLaunchViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "ViewController.h"

@interface firstLaunchViewController ()

//播放器ViewController
@property(nonatomic, strong)AVPlayerViewController *AVPlayer;

@end

@implementation firstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化AVPlayer
    [self setMoviePlayer];
}

-(void)setMoviePlayer {
    //初始化AVPlayer
    self.AVPlayer = [[AVPlayerViewController alloc]init];
    //多分屏功能取消
    self.AVPlayer.allowsPictureInPicturePlayback = NO;
    //设置是否显示媒体播放组件
    self.AVPlayer.showsPlaybackControls = false;
    
    //初始化一个播放单位。给AVplayer 使用
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:_movieURL];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    //layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setFrame:[UIScreen mainScreen].bounds];
    //设置填充模式
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    self.AVPlayer.player = player;
    //添加到self.view上面去
    [self.view.layer addSublayer:layer];
    //开始播放
    [self.AVPlayer.player play];
    
    //这里设置重复播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    //定时器。延迟3秒再出现进入应用按钮
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(setLoginButton) userInfo:nil repeats:YES];
}

//播放完成代理
-(void)playDidEnd:(NSNotification *)Notification{
    //播放完成后。设置播放进度为0 。 重新播放
    [self.AVPlayer.player seekToTime:CMTimeMake(0, 1)];
    //开始播放
    [self.AVPlayer.player play];
}

-(void)setLoginButton {
    UIButton *enterMainButton = [[UIButton alloc]init];
    enterMainButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width-48, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24;
    enterMainButton.alpha = 0;
    enterMainButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [enterMainButton setTitle:@"开启光彩" forState:UIControlStateNormal];
    [self.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.5 animations:^{
        enterMainButton.alpha = 1;
    }];
}

-(void)enterMainAction:(UIButton *)btn {
    ViewController *rootTabControl = [[ViewController alloc]init];
    self.view.window.rootViewController =rootTabControl;
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
