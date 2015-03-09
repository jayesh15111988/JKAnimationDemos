//
//  MediaTimingFunctionsViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/8/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "MediaTimingFunctionsViewController.h"

#define DEFAULT_ANIMATION_DURATION 4
#define TIME_OFFSET_STEP_INCREMENT 0.2

@interface MediaTimingFunctionsViewController () {
    CALayer* movingLayer;
    CGFloat currentTimeOffsetValue;
}

@end

@implementation MediaTimingFunctionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentTimeOffsetValue = 0;
    self.title = @"Media Timing";
    [self createDummyCircularLoader];
}

//We are not using it for now - Maybe some time in the future
-(void)createDummyCircularLoader {
    /*CAShapeLayer* circulaerLoaderLayer = [CAShapeLayer layer];
    circulaerLoaderLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:100 startAngle:-M_PI_2 endAngle:(M_PI*3)/2 clockwise:YES].CGPath;
    circulaerLoaderLayer.strokeColor = [UIColor redColor].CGColor;
    circulaerLoaderLayer.fillColor = [UIColor clearColor].CGColor;
    circulaerLoaderLayer.lineWidth = 5.0f;
    circulaerLoaderLayer.strokeStart = 0.0f;
    circulaerLoaderLayer.strokeEnd = 1.0f;
    [self.view.layer addSublayer:circulaerLoaderLayer]; */
    
    movingLayer = [CALayer layer];
    movingLayer.frame = CGRectMake(0, 100, 50, 50);
    movingLayer.backgroundColor = [UIColor greenColor].CGColor;
    movingLayer.speed = 0;
    [self.view.layer addSublayer:movingLayer];
    
    CABasicAnimation* colorChangeAnimation = [CABasicAnimation animation];
    colorChangeAnimation.toValue = (__bridge id)[UIColor redColor].CGColor;
    colorChangeAnimation.keyPath = @"backgroundColor";
    
    CABasicAnimation* animation = [CABasicAnimation animation];
    animation.delegate = self;
    animation.keyPath = @"transform.translation.x";
    animation.toValue = @(self.view.frame.size.width - 50);
    animation.fillMode = kCAFillModeBoth;
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation, colorChangeAnimation];
    animationGroup.duration = DEFAULT_ANIMATION_DURATION;
    animationGroup.timeOffset = 0.0;
    animationGroup.removedOnCompletion = NO;
    
    [movingLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [movingLayer removeAnimationForKey:@"translateAnimation"];
}

- (IBAction)pauseButtonPressed:(id)sender {
    currentTimeOffsetValue += TIME_OFFSET_STEP_INCREMENT;
    if(currentTimeOffsetValue >= DEFAULT_ANIMATION_DURATION) {
        currentTimeOffsetValue = 0;
    }
    movingLayer.timeOffset = currentTimeOffsetValue;
}


@end
