//
//  ZSKStartViewController.m
//  SchoolAssistant
//
//  Created by  庄少坤 on 2018/3/6.
//  Copyright © 2018年 刘威. All rights reserved.
//

#import "ZSKStartViewController.h"
#import <Masonry.h>
#import "LWLoginRegisterController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ZSKStartViewController ()

@property(nonatomic,weak)UIScrollView *contentView;
@property(nonatomic,weak)UIPageControl *pageControl;

@property(nonatomic,weak)NSTimer *timer;

@property(nonatomic,weak)AVPlayerItem *playerItem;
@property(nonatomic,weak)AVPlayer *avPlayer;
@property(nonatomic,weak)AVPlayerLayer *playerLayer;

@end

@implementation ZSKStartViewController

//懒加载
-(UIScrollView *)contentView {
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        contentView.contentSize = CGSizeMake(screenWidth * 4, screenHeight);
        contentView.pagingEnabled = NO;
        _contentView = contentView;
        
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    
    [self setupAVPlayer];
}

//初始化界面
-(void)initUI {
    
    //注册按钮
    UIButton *btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.hidden = YES;
    [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    [btnRegister setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.7]];
    [btnRegister addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btnRegister];
    
    //登录按钮
    UIButton *btnLogin = [[UIButton alloc] init];
    btnLogin.hidden = YES;
    btnLogin.tag = 1;
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLogin setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];
    [btnLogin addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btnLogin];
    
    //按钮延迟5秒出现
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btnRegister.hidden = NO;
        btnLogin.hidden = NO;
    });
    
    //pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    pageControl.enabled = NO;
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    //Label
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * screenWidth, screenHeight - 165, screenWidth, 50)];
        label.text = @"生活就像海洋";
        
        if (i % 2 != 0) {
            label.text = @"只有意志坚强的人才能到达彼岸";
        }
        
        label.font = [UIFont systemFontOfSize:20];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
    }
    
    //计时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    //界面布局
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(btnRegister.mas_height);
        make.bottom.equalTo(btnRegister.mas_bottom);
        make.left.equalTo(btnRegister.mas_right).offset(20);
        make.width.equalTo(btnRegister.mas_width);
    }];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@50);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(btnRegister.mas_top).offset(-10);
    }];
}

//设置播放器
-(void)setupAVPlayer {
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"1.mp4" ofType:nil]]];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = self.view.frame;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    self.playerItem = playerItem;
    self.avPlayer = player;
    self.playerLayer = layer;
    
    [player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidFinish) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
}

//播放完成
-(void)playerItemDidFinish {
    NSLog(@"end......");
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer play];
}

//按钮点击事件
-(void)buttonClick:(UIButton *)button {
//    [UIView animateWithDuration:1 animations:^{
//        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
//        self.view.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.5 animations:^{
//            button.transform = CGAffineTransformIdentity;
    
            if (button.tag == 1) {
                [self presentViewController:[LWLoginRegisterController new] animated:YES completion:nil];
                NSLog(@"login....");
            }else {
                
                [self presentViewController:[LWLoginRegisterController new]  animated:YES completion:nil];
                NSLog(@"register.....");
            }
//        }];
//    }];
}

//pageControl改变事件
-(void)pageChange:(UIPageControl *)pageContrl {
    CGFloat x = pageContrl.currentPage * screenWidth;
    [self.contentView setContentOffset:CGPointMake(x,0) animated:YES];
}

//timerChange
-(void)timeChange {
    self.pageControl.currentPage = (self.pageControl.currentPage + 1) % 4;
    [self pageChange:self.pageControl];
}

-(void)viewWillDisappear:(BOOL)animated {
    //NSLog(@"disappear......");
    
    self.avPlayer = nil;
    self.playerItem = nil;
    [self.timer invalidate];
    [self.playerLayer removeFromSuperlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:[self.avPlayer currentItem]];
}

-(void)dealloc {
    
    NSLog(@"%@销毁了。。。。",[self class]);
}
@end
