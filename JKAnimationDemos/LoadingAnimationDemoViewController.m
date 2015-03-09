//
//  LoadingAnimationDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/4/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "LoadingAnimationDemoViewController.h"

#define UNIQUE_ANIMATION_KEY @"drawCircleAnimation"
#define DEFAULT_ANIMATION_DURATION 0.25

@interface LoadingAnimationDemoViewController ()
@property (strong) CAShapeLayer* circlePathLayer;
@property (assign) CGFloat progress;
@property (nonatomic, retain) NSTimer* timer;
@property (assign) CGFloat progressIndicator;
@property (strong) CAShapeLayer *circle;
@property (strong) CABasicAnimation *drawAnimation;
@property (assign) CGFloat previousProgressIndicator;
@property (assign) NSInteger radius;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong) UILabel* progressIndicatorLabel;

@end

@implementation LoadingAnimationDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Loading Animation Demo";
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 0.0;
    }];
    
    [self.activityIndicator startAnimating];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //Make preparation for desired animation
        self.previousProgressIndicator = 0;
        self.progressIndicator = 0;
        
        self.radius = 100;
        self.circle = [CAShapeLayer layer];
        self.circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * self.radius, 2.0 * self.radius)
                                                      cornerRadius: self.radius].CGPath;
        self.circle.position = CGPointMake(CGRectGetMidX(self.view.frame) - self.radius,
                                           CGRectGetMidY(self.view.frame) - self.radius);
        
        self.progressIndicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.radius, self.radius)];
        self.progressIndicatorLabel.text = @"Loading...";
        [self.progressIndicatorLabel setBackgroundColor:[UIColor clearColor]];
        self.progressIndicatorLabel.center = self.view.center;
        self.progressIndicatorLabel.numberOfLines = 0;
        self.progressIndicatorLabel.font = [UIFont boldSystemFontOfSize:24];
        self.progressIndicatorLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.progressIndicatorLabel];
        // Configure the apperence of the circle
        self.circle.fillColor = [UIColor clearColor].CGColor;
        self.circle.strokeColor = [UIColor blackColor].CGColor;
        self.circle.lineWidth = 10;
        //self.circle.strokeStart = 0.0;
        //self.circle.strokeEnd = 0.0;
        self.circle.fillMode = kCAFillModeBoth;
        
        // Add to parent layer
        [self.view.layer addSublayer: self.circle];

        // Configure animation
        self.drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        self.drawAnimation.duration            = DEFAULT_ANIMATION_DURATION;
        self.drawAnimation.repeatCount         = 1.0;
        
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        self.drawAnimation.fromValue = [NSNumber numberWithFloat:self.previousProgressIndicator];
        self.drawAnimation.toValue   = [NSNumber numberWithFloat:self.progressIndicator];
        
        // Experiment with timing to get the appearence to look the way you want
        self.drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [self.activityIndicator stopAnimating];
        // Add the animation to the circle
        [self.circle addAnimation:self.drawAnimation forKey:UNIQUE_ANIMATION_KEY];
        self.timer = [NSTimer timerWithTimeInterval:DEFAULT_ANIMATION_DURATION target:self selector:@selector(animateCircle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    });
    
}

-(void)animateCircle {
    if(self.progressIndicator <= 1.0) {
        self.drawAnimation.fromValue   = [NSNumber numberWithFloat:self.previousProgressIndicator];
        self.drawAnimation.toValue   = [NSNumber numberWithFloat:self.progressIndicator];
        NSLog(@"%f Stroke End Value is", self.progressIndicator);
        [self.circle addAnimation:self.drawAnimation forKey:UNIQUE_ANIMATION_KEY];
        self.previousProgressIndicator = self.progressIndicator;
        self.progressIndicator += 0.05;
        self.view.alpha = self.progressIndicator;
        self.progressIndicatorLabel.text = [NSString stringWithFormat:@"%ld%%",(long)(self.progressIndicator*100)];
    } else {
        self.progressIndicatorLabel.text = @"COMPLETE";
        self.progressIndicatorLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.timer invalidate];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

@end
