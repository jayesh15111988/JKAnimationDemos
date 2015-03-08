//
//  BezierCurveArtViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "BezierCurveArtViewController.h"
#define MAN_IMAGE_HEAD_RADIUS 20
#define CUSOTM_REACTANGLE_WIDTH 300

@interface BezierCurveArtViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerOne;
@property (weak, nonatomic) IBOutlet UIView *containerTwo;
@end

@implementation BezierCurveArtViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bezier Curves Demo";
    UIBezierPath* path = [[UIBezierPath alloc] init];
    CGFloat containerOneCenterX = self.containerOne.center.x - MAN_IMAGE_HEAD_RADIUS;
    //[path moveToPoint:CGPointMake(containerOneCenterX, 10)];
    [path addArcWithCenter:CGPointMake(containerOneCenterX, MAN_IMAGE_HEAD_RADIUS) radius:MAN_IMAGE_HEAD_RADIUS startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(containerOneCenterX, 40)];
    [path addLineToPoint:CGPointMake(containerOneCenterX, 100)];
    [path moveToPoint:CGPointMake(containerOneCenterX - 30, 70)];
    [path addLineToPoint:CGPointMake(containerOneCenterX + 30, 70)];
    [path moveToPoint:CGPointMake(containerOneCenterX, 100)];
    [path addLineToPoint:CGPointMake(containerOneCenterX - 20, 150)];
    [path moveToPoint:CGPointMake(containerOneCenterX, 100)];
    [path addLineToPoint:CGPointMake(containerOneCenterX + 20, 150)];
    
    
    CAShapeLayer* shapeLayer = [CAShapeLayer new];
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPattern = @[@1, @3, @4, @2];
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineWidth = 2.0f;
    shapeLayer.path = path.CGPath;
    [self.containerOne.layer addSublayer:shapeLayer];
    
    //Rectabgle with rounded border only for 3 corners and sharp one for single corner
    CGRect rect = CGRectMake(self.containerTwo.center.x - CUSOTM_REACTANGLE_WIDTH/2, 10, CUSOTM_REACTANGLE_WIDTH, 120);
    CGSize radius = CGSizeMake(50, 50);
    UIRectCorner rectangleCorner = UIRectCornerBottomLeft | UIRectCornerTopRight;
    UIBezierPath* customeRoundedCornerBezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectangleCorner cornerRadii:radius];
    CAShapeLayer* shapeLayerForRoundedCornerRectangle = [CAShapeLayer new];
    shapeLayerForRoundedCornerRectangle.strokeColor = [UIColor redColor].CGColor;
    shapeLayerForRoundedCornerRectangle.fillColor = [UIColor clearColor].CGColor;
    shapeLayerForRoundedCornerRectangle.lineCap = kCALineCapRound;
    shapeLayerForRoundedCornerRectangle.lineWidth = 3.0f;
    shapeLayerForRoundedCornerRectangle.path = customeRoundedCornerBezierPath.CGPath;
    [self.containerTwo.layer addSublayer:shapeLayerForRoundedCornerRectangle];
    
}

@end
