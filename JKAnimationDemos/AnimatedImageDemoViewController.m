//
//  AnimatedImageDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "AnimatedImageDemoViewController.h"

#define X_OFFSET 0.25
#define Y_OFFSET 0.25

@interface AnimatedImageDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *animatingView;
@property (strong) NSTimer* timer;
@property (strong) UIImage* animatingImage;
@property (assign) CGFloat xAxisSpriteOffset;
@property (assign) CGFloat yAxisSpriteOffset;
@end

@implementation AnimatedImageDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Animated Sprite Image";
    self.xAxisSpriteOffset = 0.0;
    self.yAxisSpriteOffset = 0.0;
    self.animatingImage = [UIImage imageNamed:@"smurf_sprite.png"];
    [self addSpriteImage:self.animatingImage toLayer:self.animatingView.layer withContentRect:CGRectMake(self.xAxisSpriteOffset, self.yAxisSpriteOffset, X_OFFSET, Y_OFFSET)];
    self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(changeAnimatingImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

-(void)changeAnimatingImage {
    
    if(self.xAxisSpriteOffset >= 1.0) {
        self.xAxisSpriteOffset = 0.0;
        self.yAxisSpriteOffset += Y_OFFSET;
    }
    
    if(self.yAxisSpriteOffset >= 1.0) {
        self.yAxisSpriteOffset = 0.0;
    }
    
    [self addSpriteImage:self.animatingImage toLayer:self.animatingView.layer withContentRect:CGRectMake(self.xAxisSpriteOffset, self.yAxisSpriteOffset, X_OFFSET, Y_OFFSET)];
    self.xAxisSpriteOffset += X_OFFSET;
}

-(void)addSpriteImage:(UIImage*)image toLayer:(CALayer*)layer withContentRect:(CGRect)rect {
    layer.contents = (__bridge id) image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contentsRect = rect;
}

@end
