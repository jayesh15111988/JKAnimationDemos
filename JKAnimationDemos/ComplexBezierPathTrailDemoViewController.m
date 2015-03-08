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
@property (strong) CATransition* imageViewTransition;
@end

@implementation ComplexBezierPathTrailDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bezier Curve Animation";
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
    [layer addAnimation:animationGroup forKey:nil];
    [self setAnimationForImageView];
}

-(void)setAnimationForImageView {

}

- (IBAction)changeImageButtonPressed:(id)sender {
    self.imageViewTransition = [CATransition animation];
    self.imageViewTransition.type = kCATransitionPush;
    self.imageViewTransition.subtype = kCATransitionFromRight;
    self.imageViewTransition.duration = 0.5f;
    [self.animatingImageView.layer addAnimation:self.imageViewTransition forKey:@"transition"];
    self.animatingImageView.image = [UIImage imageNamed:@"spriteAnimationRunning.png"];
}


@end
