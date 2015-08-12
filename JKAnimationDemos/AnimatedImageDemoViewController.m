//
//  AnimatedImageDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "AnimatedImageDemoViewController.h"

@interface AnimatedImageDemoViewController ()

@property (weak, nonatomic) IBOutlet UIView *animatingView;
@property (strong, nonatomic) NSTimer* timer;
@property (strong, nonatomic) UIImage* animatingImage;
@property (assign, nonatomic) CGFloat xAxisSpriteOffset;
@property (assign, nonatomic) CGFloat yAxisSpriteOffset;
@property (assign, nonatomic) CGFloat xOffsetIncrement;
@property (assign, nonatomic) CGFloat yOffsetIncrement;

@end

@implementation AnimatedImageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Animated Sprite Image";
    self.xAxisSpriteOffset = 0.0;
    self.yAxisSpriteOffset = 0.0;
    self.xOffsetIncrement = 0.143;
    self.yOffsetIncrement = 0.34;
    self.animatingImage = [UIImage imageNamed:@"girlRunning.png"];
    [self addSpriteImage:self.animatingImage toLayer:self.animatingView.layer withContentRect:CGRectMake(self.xAxisSpriteOffset, self.yAxisSpriteOffset, _xOffsetIncrement, _yOffsetIncrement)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeAnimatingImage) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)changeAnimatingImage {
    
    if(self.xAxisSpriteOffset >= 1.0) {
        self.xAxisSpriteOffset = 0.0;
        self.yAxisSpriteOffset += _yOffsetIncrement;
    }
    
    if(self.yAxisSpriteOffset >= 1.0) {
        self.yAxisSpriteOffset = 0.0;
    }
    
    [self addSpriteImage:self.animatingImage toLayer:self.animatingView.layer withContentRect:CGRectMake(self.xAxisSpriteOffset, self.yAxisSpriteOffset, _xOffsetIncrement, _yOffsetIncrement)];
    self.xAxisSpriteOffset += _xOffsetIncrement;
}

-(void)addSpriteImage:(UIImage*)image toLayer:(CALayer*)layer withContentRect:(CGRect)rect {
    layer.contents = (__bridge id) image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
    [super viewWillDisappear:animated];
}

@end
