//
//  BezierCurvesTestViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/10/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "BezierCurvesTestViewController.h"
#import "CustomDrawingView.h"

@interface BezierCurvesTestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *modeIndicatorLabel;
@property (strong, nonatomic) IBOutlet CustomDrawingView *customDrawingView;
@end

@implementation BezierCurvesTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bezier Curve Fun";
}
- (IBAction)modeSwitchChanged:(UISwitch *)sender {
    self.customDrawingView.isRegularModeOn = !self.customDrawingView.isRegularModeOn;
    self.modeIndicatorLabel.text = [sender isOn]? @"Regular" : @"Custom";
}

- (IBAction)tapPressed:(id)sender {
    [self.view endEditing:YES];
}

@end
