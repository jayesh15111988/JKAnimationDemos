//
//  MoreExamplesViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 8/11/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "MoreExamplesViewController.h"

@interface MoreExamplesViewController ()

@end

@implementation MoreExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView* parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    parentView.backgroundColor = [UIColor redColor];
    parentView.layer.zPosition = 1.0;
    [self.view addSubview:parentView];
    CALayer* childLayer = [CALayer new];
    childLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    childLayer.frame = CGRectMake(0, 0, 25, 25);
    childLayer.position = CGPointMake(25, 25);
    childLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    [parentView.layer addSublayer:childLayer];
    
    CALayer* overLayLayer = [CALayer new];
    overLayLayer.frame = CGRectMake(25, 75, 50, 50);
    overLayLayer.backgroundColor = [UIColor darkGrayColor].CGColor;
    [self.view.layer addSublayer:overLayLayer];
    
    UIView* sample1 = [[UIView alloc] initWithFrame:CGRectMake(125, 64, 50, 50)];
    sample1.backgroundColor = [UIColor greenColor];
    sample1.alpha = 0.5;
    [self.view addSubview:sample1];
    
    UIView* sample2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    sample2.backgroundColor = [UIColor redColor];
    [sample1 addSubview:sample2];
    
    CAGradientLayer* gradLayer = [CAGradientLayer layer];
    gradLayer.frame = CGRectMake(175, 100, 50, 50);
    gradLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor];
    gradLayer.locations = @[@0.0, @0.5, @1.0];
    gradLayer.startPoint = CGPointMake(0, 0);
    gradLayer.endPoint = CGPointMake(1.0, 1.0);
    [self.view.layer addSublayer:gradLayer];
}

@end
