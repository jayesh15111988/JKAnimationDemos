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
    //[self drawDecentAnimationWithBezierAnimation];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //[UIView animateWithDuration:1.0 animations:^{
    //    self.view.alpha = 0.0;
    //}];
    
    [self.activityIndicator startAnimating];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //Make preparation for desired animation
        self.previousProgressIndicator = 0;
        self.progressIndicator = 0;
        self.radius = 100;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        [bezierPath addArcWithCenter:CGPointMake(CGRectGetMidX(self.view.frame) - self.radius,
                                                 CGRectGetMidY(self.view.frame) - self.radius) radius:self.radius startAngle:-M_PI/2 endAngle:(3/2.0) * M_PI clockwise:YES];
        
        self.circle = [CAShapeLayer layer];
        //self.circle.path = bezierPath.CGPath; //[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * self.radius, 2.0 * self.radius)
        
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
        self.circle.fillMode = kCAFillModeForwards;
        
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
        //self.drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [self.activityIndicator stopAnimating];
        // Add the animation to the circle
        //[self.circle addAnimation:self.drawAnimation forKey:UNIQUE_ANIMATION_KEY];
        self.timer = [NSTimer timerWithTimeInterval:DEFAULT_ANIMATION_DURATION target:self selector:@selector(animateCircle) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
     
    });
}

-(void)animateCircle {
    if(self.progressIndicator <= 1.0) {
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        
        [bezierPath addArcWithCenter:CGPointMake(CGRectGetMidX(self.view.frame) - self.radius,
                                                 CGRectGetMidY(self.view.frame) - self.radius) radius:self.radius startAngle:-M_PI/2 endAngle:(self.progressIndicator)*((3/2.0) * M_PI) clockwise:YES];
        //[self.circle removeAllAnimations];
        //self.circle = [CAShapeLayer layer];
        self.circle.path = bezierPath.CGPath; //[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * self.radius, 2.0 * self.radius)
        
        self.drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        self.drawAnimation.duration            = DEFAULT_ANIMATION_DURATION;
        self.drawAnimation.repeatCount         = 1.0;
        self.drawAnimation.removedOnCompletion = YES;
        self.drawAnimation.fromValue = [NSNumber numberWithFloat:self.previousProgressIndicator];
        self.drawAnimation.toValue   = [NSNumber numberWithFloat:self.progressIndicator];
        [self.circle addAnimation:self.drawAnimation forKey:UNIQUE_ANIMATION_KEY];
        self.previousProgressIndicator = self.progressIndicator;
        self.progressIndicator += 0.1;
        self.view.alpha = self.progressIndicator;
        self.progressIndicatorLabel.text = [NSString stringWithFormat:@"%ld%%",(long)(self.progressIndicator*100)];
    } else {
        self.progressIndicatorLabel.text = @"COMPLETE";
        self.progressIndicatorLabel.font = [UIFont boldSystemFontOfSize:18];
        [self.timer invalidate];
    }
}

- (void)drawDecentAnimationWithBezierAnimation {
    self.view.alpha = 0.0f;
    CAShapeLayer* circle = [CAShapeLayer layer];
    self.radius = 100;
    
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * self.radius, 2.0 * self.radius)
                                             cornerRadius: self.radius].CGPath;
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame) - self.radius,
                                  CGRectGetMidY(self.view.frame) - self.radius);
    
    //////////
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor blackColor].CGColor;
    circle.lineWidth = 10;
    circle.fillMode = kCAFillModeBoth;
    
    /*CAShapeLayer *progressLayer = [[CAShapeLayer alloc] init];
     
     [progressLayer setPath: circle.path];
     [progressLayer setStrokeColor:[UIColor yellowColor].CGColor];
     [progressLayer setFillColor:[UIColor clearColor].CGColor];
     [progressLayer setLineWidth:2.0f];
     [progressLayer setStrokeStart:0.0];
     [progressLayer setStrokeEnd:1.0];
     */
    
    self.progressIndicatorLabel.text = @"0";
    
    [UIView animateWithDuration:2.0f animations:^{
        self.view.alpha = 1.0f;
    }];
    
    [self.view.layer addSublayer:circle];
    //[self.view.layer addSublayer:progressLayer];
    
    CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animateStrokeEnd.duration  = 2.0f;
    animateStrokeEnd.fromValue = [NSNumber numberWithFloat:0.0f];
    animateStrokeEnd.toValue   = [NSNumber numberWithFloat:1.0f];
    animateStrokeEnd.removedOnCompletion = YES;
    animateStrokeEnd.autoreverses = NO;
    [circle addAnimation:animateStrokeEnd forKey:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

@end
