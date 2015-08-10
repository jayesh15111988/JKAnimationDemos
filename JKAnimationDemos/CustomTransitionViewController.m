//
//  CustomTransitionViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/8/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "CustomTransitionViewController.h"

@interface CustomTransitionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *centerImageView;
@end

@implementation CustomTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Custom Transitions";
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.view.layer addAnimation:transition forKey:nil];
    
    [self showCustomTransition];
}

-(void)showCustomTransition {
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* currentViewScreenshot = UIGraphicsGetImageFromCurrentImageContext();
    [self.centerImageView setImage:[UIImage imageNamed:@"smurf_sprite"]];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    UIImageView* frontConverImageView = [[UIImageView alloc] initWithImage:currentViewScreenshot];
    frontConverImageView.frame = self.view.bounds;
    [self.view addSubview:frontConverImageView];
    
    [UIView animateWithDuration:2.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI);
        frontConverImageView.transform = transform;
        frontConverImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [frontConverImageView removeFromSuperview];
    }];
}

@end
