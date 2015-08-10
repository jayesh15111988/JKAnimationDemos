//
//  VideoPlaybackAndEditViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "VideoPlaybackAndEditViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlaybackAndEditViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoContainerView;

@end

@implementation VideoPlaybackAndEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Video Player Demo";
    NSURL* localVideoURL = [[NSBundle mainBundle] URLForResource:@"animationVideo" withExtension:@"mp4"];
    AVPlayer* player = [AVPlayer playerWithURL:localVideoURL];
    player.volume = 0.5;
    AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.videoContainerView.bounds;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    transform = CATransform3DRotate(transform, -M_PI_4, 1, 0, 0);
    playerLayer.transform = transform;
    playerLayer.borderColor = [UIColor orangeColor].CGColor;
    playerLayer.borderWidth = 5.0f;
    playerLayer.cornerRadius = 10.0f;
    [self.videoContainerView.layer addSublayer:playerLayer];
    [player play];
}

@end
