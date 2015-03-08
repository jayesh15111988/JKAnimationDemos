//
//  SimpleAnimationDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "SimpleAnimationDemoViewController.h"

@interface SimpleAnimationDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *sampleView;
@property (strong) CALayer* layer;
@end

@implementation SimpleAnimationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
}

- (IBAction)changeColor:(id)sender {
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.5];
    [CATransaction setCompletionBlock:^{
        NSLog(@"Color change animation is complete now!");
    }];
    CGFloat redColor = rand()/(CGFloat)INT_MAX;
    CGFloat greenColor = rand()/(CGFloat)INT_MAX;
    CGFloat blueColor = rand()/(CGFloat)INT_MAX;
    self.layer.backgroundColor = [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0].CGColor;
    [CATransaction commit];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self.sampleView];
    if([self.layer.presentationLayer hitTest:point]) {
        [self changeColor:nil];
    } else {
        [CATransaction begin];
        [CATransaction setAnimationDuration:2.0];
        self.layer.position = point;
        [CATransaction commit];
    }
}

@end
