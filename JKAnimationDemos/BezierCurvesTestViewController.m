//
//  BezierCurvesTestViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/10/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "BezierCurvesTestViewController.h"
#import "CustomDrawingView.h"

@implementation BezierCurvesTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bezier Curve Fun";
}


- (IBAction)tapPressed:(id)sender {
    [self.view endEditing:YES];
}

@end
