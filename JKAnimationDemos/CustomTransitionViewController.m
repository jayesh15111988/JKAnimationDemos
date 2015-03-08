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
    [self showCustomTransition];
}

-(void)showCustomTransition {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* currentViewScreenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageView* frontConverImageView = [[UIImageView alloc] initWithImage:currentViewScreenshot];
    frontConverImageView.frame = self.view.bounds;
    [self.view addSubview:frontConverImageView];
    
    [self.centerImageView setImage:[UIImage imageNamed:@"smurf_sprite"]];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    [UIView animateWithDuration:1.5 animations:^{
        frontConverImageView.transform = CGAffineTransformMakeTranslation(-self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [frontConverImageView removeFromSuperview];
    }];
}

@end
