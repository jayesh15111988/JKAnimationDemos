//
//  BezierCurveFromTimingFunctionsViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/9/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "BezierCurveFromTimingFunctionsViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BezierCurveFromTimingFunctionsViewController ()
@property (strong) CAShapeLayer* layer;
@property (weak, nonatomic) IBOutlet UIView *timingFunctionsBezierCurve;

@property (weak, nonatomic) IBOutlet UITextField *point1Y;
@property (weak, nonatomic) IBOutlet UITextField *point2X;
@property (weak, nonatomic) IBOutlet UITextField *point1X;
@property (weak, nonatomic) IBOutlet UITextField *point2Y;
@end

@implementation BezierCurveFromTimingFunctionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bezier from timing functions";
    self.layer = [CAShapeLayer layer];
    self.layer.lineWidth = 5.0f;
    self.layer.strokeColor = [UIColor blueColor].CGColor;
    self.layer.fillColor = [UIColor clearColor].CGColor;
    self.layer.lineJoin = kCALineJoinRound;
    self.layer.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:1.0 alpha:1.0].CGColor;
    self.layer.frame = CGRectMake(0, 0, 200, 200);
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]]];
    [self.timingFunctionsBezierCurve.layer addSublayer:self.layer];
}

-(void)setLayerWithPath:(CGPathRef)destinationPath {
    CABasicAnimation* anim = [CABasicAnimation animation];
    anim.keyPath = @"path";
    anim.duration = 1.0f;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:anim forKey:nil];
    self.layer.path = destinationPath;
}

-(CGPathRef)getPathFromMediaTimingFunction:(CAMediaTimingFunction*)inputTimingFunction {
    CGPoint pointOne, pointTwo;
    
    [inputTimingFunction getControlPointAtIndex:1 values:(float*)&pointOne];
    [inputTimingFunction getControlPointAtIndex:2 values:(float*)&pointTwo];
    UIBezierPath* bezier = [[UIBezierPath alloc] init];
    [bezier moveToPoint:CGPointZero];
    [bezier addCurveToPoint:CGPointMake(1, 1) controlPoint1:pointOne controlPoint2:pointTwo];
    [bezier applyTransform:CGAffineTransformMakeScale(200, 200)];
    return bezier.CGPath;
}

- (IBAction)easeOut:(id)sender {
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]]];
}

- (IBAction)linear:(id)sender {
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]]];
}

- (IBAction)easeIn:(id)sender {
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]]];
}

- (IBAction)defaultCurve:(id)sender {
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]]];
}

- (IBAction)easeInEaseOut:(id)sender {
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]]];
}

- (IBAction)customCurve:(id)sender {
    [self setLayerWithPath:[self getPathFromMediaTimingFunction:[CAMediaTimingFunction functionWithControlPoints:[self.point1X.text floatValue] :[self.point1Y.text floatValue] :[self.point2X.text floatValue] :[self.point2Y.text floatValue]]]];
}

- (IBAction)viewTapped:(id)sender {
    [self.view endEditing:YES];
}


@end
