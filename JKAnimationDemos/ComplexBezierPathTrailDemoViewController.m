//
//  ComplexBezierPathTrailDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ComplexBezierPathTrailDemoViewController.h"

@interface ComplexBezierPathTrailDemoViewController () {
    CALayer* layer;
}

@property (weak, nonatomic) IBOutlet UIImageView *animatingImageView;
@property (strong, nonatomic) CATransition* imageViewTransition;
@property (strong, nonatomic) NSArray* imageCollection;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) CALayer* sohLayer;

@end

@implementation ComplexBezierPathTrailDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.sohLayer = [CALayer layer];
    self.sohLayer.frame = CGRectMake(0, 64, 200, 200);
    //sohLayer.position = CGPointMake(100, 100);
    self.sohLayer.contents = (__bridge id) [UIImage imageNamed:@"sp.jpg"].CGImage;
    [self.view.layer addSublayer:self.sohLayer];
    
    CABasicAnimation* anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.duration = 2.0;
    anim.autoreverses = YES;
    anim.toValue = @(M_PI * (3.0/4));
    [self.sohLayer addAnimation:anim forKey:nil];
    
    
    self.title = @"Bezier Curve Animation";
    self.currentIndex = 0;
    self.imageCollection = @[@"sl.jpg", @"sc.jpg", @"compiler.jpg", @"sp.jpg"];
    self.animatingImageView.image = [UIImage imageNamed:self.imageCollection[self.currentIndex]];
    UIBezierPath* circularPath = [UIBezierPath bezierPath];
    [circularPath moveToPoint:CGPointMake(50, 300)];
    [circularPath addCurveToPoint:CGPointMake(300, 300) controlPoint1:CGPointMake(100, 50) controlPoint2:CGPointMake(250, 450)];
    CAShapeLayer* layerShape = [CAShapeLayer layer];
    layerShape.lineWidth = 2.0f;
    layerShape.fillColor = [UIColor clearColor].CGColor;
    layerShape.strokeColor = [UIColor redColor].CGColor;
    layerShape.path = circularPath.CGPath;
    [self.view.layer addSublayer:layerShape];
    
    layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 20, 20);
    layer.position = CGPointMake(50, 300);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation* colorChangeAnimation = [CABasicAnimation animation];
    colorChangeAnimation.keyPath = @"backgroundColor";
    colorChangeAnimation.toValue = (__bridge id) [UIColor blueColor].CGColor;
    
    //Usually use this approach for perform rotation while animating stuff
    CABasicAnimation* rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    rotationAnimation.byValue = @(M_PI*2);
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = circularPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[colorChangeAnimation, animation, rotationAnimation];
    animationGroup.duration = 1.0f;
    animationGroup.delegate = self;
    animationGroup.autoreverses = NO;
    animationGroup.removedOnCompletion = YES;
    layer.position = CGPointMake(300, 300);
    [layer addAnimation:animationGroup forKey:@"anim"];
}

- (void)animationDidStop:(CAAnimationGroup *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    layer.backgroundColor = [UIColor blueColor].CGColor;
    //self.sohLayer.affineTransform = CGAffineTransformMakeRotation(M_PI * (3.0/4));
    [CATransaction commit];
}

- (IBAction)changeImageButtonPressed:(id)sender {
    self.currentIndex++;
    
    self.imageViewTransition = [CATransition animation];
    self.imageViewTransition.type = kCATransitionPush;
    self.imageViewTransition.subtype = kCATransitionFromRight;
    self.imageViewTransition.duration = 0.25f;
    [self.animatingImageView.layer addAnimation:self.imageViewTransition forKey:kCATransition];
    self.animatingImageView.image = [UIImage imageNamed:self.imageCollection[self.currentIndex%self.imageCollection.count]];
    
    //Use this if opting for alternate transition effect
//    [UIView transitionWithView:self.animatingImageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//            self.animatingImageView.image = [UIImage imageNamed:self.imageCollection[self.currentIndex]];
//    } completion:^(BOOL finished) {
//
//    }];
}


@end
