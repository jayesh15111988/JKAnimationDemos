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
    CALayer* easingAnimationLayer;
    CALayer* keyFrameAnimationLayer;
}

@end

@implementation MediaTimingFunctionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentTimeOffsetValue = 0;
    self.title = @"Media Timing";
    //[self createDummyCircularLoader];
    [self createStepAnimation];
    [self setupEasingAnimatingLayer];
    [self performKeyFrameEasingAnimation];
}

-(void)setupEasingAnimatingLayer {
    easingAnimationLayer = [CALayer layer];
    easingAnimationLayer.frame = CGRectMake(15, 235, 30, 30);
    easingAnimationLayer.position = CGPointMake(15, 235);
    easingAnimationLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:easingAnimationLayer];
}

-(void)createStepAnimation {
    movingLayer = [CALayer layer];
    movingLayer.frame = CGRectMake(0, 100, 50, 50);
    movingLayer.backgroundColor = [UIColor greenColor].CGColor;
    movingLayer.timeOffset = 0.0;
    movingLayer.speed = 0.0;
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
    animationGroup.removedOnCompletion = NO;
    [movingLayer addAnimation:animationGroup forKey:@"translateAnimation"];
}

//We are not using it for now - Maybe some time in the future
-(void)createDummyCircularLoader {
    CAShapeLayer* circulaerLoaderLayer = [CAShapeLayer layer];
    circulaerLoaderLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.center.x, self.view.center.y) radius:100 startAngle:-M_PI_2 endAngle:(M_PI*3)/2 clockwise:YES].CGPath;
    circulaerLoaderLayer.strokeColor = [UIColor redColor].CGColor;
    circulaerLoaderLayer.fillColor = [UIColor clearColor].CGColor;
    circulaerLoaderLayer.lineWidth = 5.0f;
    circulaerLoaderLayer.strokeStart = 0.0f;
    circulaerLoaderLayer.strokeEnd = 1.0f;
    [CAMediaTimingFunction functionWithControlPoints:2.0 :2.0 :2.0 :2.0];
    [self.view.layer addSublayer:circulaerLoaderLayer];
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


- (IBAction)animateWithEase:(id)sender {
    [self easeInLayerToPosition:CGPointMake(self.view.frame.size.width - 15, 235)];
}

-(void)easeInLayerToPosition:(CGPoint)destinationPoint {
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    easingAnimationLayer.position = destinationPoint;
    [CATransaction commit];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint currentTouchPoint = [[touches anyObject] locationInView:self.view];
    [self easeInLayerToPosition:currentTouchPoint];
}

-(void)performKeyFrameEasingAnimation {
    keyFrameAnimationLayer = [CALayer layer];
    keyFrameAnimationLayer.frame = CGRectMake(0, 0, 20, 20);
    keyFrameAnimationLayer.backgroundColor = [UIColor redColor].CGColor;
    keyFrameAnimationLayer.position = CGPointMake(10, 200);
    [self.view.layer addSublayer:keyFrameAnimationLayer];
    CAKeyframeAnimation* keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.duration = 5.0;
    keyFrameAnimation.repeatCount = 1;
    keyFrameAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    keyFrameAnimation.keyPath = @"position";
    keyFrameAnimationLayer.autoreverses = NO;
    
    keyFrameAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(10, 70)], [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width - 10, 120)], [NSValue valueWithCGPoint:CGPointMake(10, 170)], [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width - 10, 220)]];
    keyFrameAnimationLayer.position = CGPointMake(self.view.frame.size.width - 10, 220);
    [keyFrameAnimationLayer addAnimation:keyFrameAnimation forKey:nil];
}


@end
