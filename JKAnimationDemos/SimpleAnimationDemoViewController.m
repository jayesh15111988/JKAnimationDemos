//
//  SimpleAnimationDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "SimpleAnimationDemoViewController.h"
#define DEFAULT_ANIMATION_DURATION 1.0

@interface SimpleAnimationDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *sampleView;
@property (weak, nonatomic) IBOutlet UIView *complexView;
@property (weak, nonatomic) IBOutlet UIView *keyframeAnimationView;

@property (assign) CGColorRef recentBackgroundColor;
@property (assign) CGColorRef keyframeAnimationRecentColor;
@property (strong) CALayer* layer;
@property (strong) CALayer* complexLayer;
@property (strong) CALayer* keyframeAnimationLayer;
@end

@implementation SimpleAnimationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Animation Demos";
    
    self.layer = [CALayer layer];
    self.layer.backgroundColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.frame = self.sampleView.bounds;
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    self.layer.actions = @{@"backgroundColor": transition};
    [self.sampleView.layer addSublayer:self.layer];
    
    self.complexLayer = [CALayer layer];
    self.complexLayer.frame = self.complexView.bounds;
    self.complexLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.complexView.layer addSublayer:self.complexLayer];
    
    self.keyframeAnimationLayer = [CALayer layer];
    self.keyframeAnimationLayer.frame = self.keyframeAnimationView.bounds;
    self.keyframeAnimationLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.keyframeAnimationView.layer addSublayer:self.keyframeAnimationLayer];
}

- (IBAction)changeColor:(id)sender {
    [CATransaction begin];
    [CATransaction setAnimationDuration:DEFAULT_ANIMATION_DURATION];
    [CATransaction setCompletionBlock:^{
        NSLog(@"Color change animation is complete now!");
    }];

    self.layer.backgroundColor = [self getRandomColor];
    [CATransaction commit];
}

- (IBAction)changeComplexColor:(id)sender {
    CABasicAnimation* animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.fromValue = (__bridge id)(self.complexLayer.backgroundColor);
    self.recentBackgroundColor = [self getRandomColor];
    animation.toValue = (__bridge id) self.recentBackgroundColor;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 2.0f;
    self.complexLayer.backgroundColor = self.recentBackgroundColor;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    [self.complexLayer addAnimation:animation forKey:@"backgroundColorChangeAnimation"];
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    //CAAnimation* backgroundColorChangeAnimation = [self.complexLayer animationForKey:@"backgroundColorChangeAnimation"];
    NSLog(@"Successfully retrieved animation from given key for background color change property");
    NSLog(@"We successfully finished animation with CABasic Animation block API");
}

- (IBAction)beginKeyframeAnimationButtonPressed:(id)sender {
    CAKeyframeAnimation* keyframeAnimation = [CAKeyframeAnimation animation];
    keyframeAnimation.duration = 3.0;
    keyframeAnimation.keyPath = @"backgroundColor";
    self.keyframeAnimationRecentColor = [self getRandomColor];
    keyframeAnimation.values = @[(__bridge id) [self getRandomColor], (__bridge id) [self getRandomColor], (__bridge id) [self getRandomColor], (__bridge id) self.keyframeAnimationRecentColor];
    self.keyframeAnimationLayer.backgroundColor = self.keyframeAnimationRecentColor;
    [self.keyframeAnimationLayer addAnimation:keyframeAnimation forKey:nil];
}

-(CGColorRef)getRandomColor {
    CGFloat redColor = rand()/(CGFloat)INT_MAX;
    CGFloat greenColor = rand()/(CGFloat)INT_MAX;
    CGFloat blueColor = rand()/(CGFloat)INT_MAX;
    return [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0].CGColor;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.sampleView];
    if([self.layer.presentationLayer hitTest:point]) {
        [self changeColor:nil];
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:DEFAULT_ANIMATION_DURATION];
        self.layer.position = point;
        [CATransaction commit];
    }
}

@end
