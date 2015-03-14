//
//  LayerMaskingViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/12/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "LayerMaskingViewController.h"

@interface LayerMaskingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *originalImageView;
@property (weak, nonatomic) IBOutlet UIImageView *maskedImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftImageLeadingSpaceCostraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightImageTrailingSpaceCostraint;
@property (weak, nonatomic) IBOutlet UIImageView *maskingImage;
@end

@implementation LayerMaskingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Miscelleneous Examples";
    
    UILabel* maskingLayerDemo = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 21)];
    maskingLayerDemo.text = @"Masking Layer";
    [self.view addSubview:maskingLayerDemo];
    
    CALayer* borderLayer = [CALayer layer];
    borderLayer.frame = CGRectMake(0, 0, 100, 100);
    borderLayer.position = CGPointMake(self.view.center.x, self.view.center.y + 44);
    borderLayer.cornerRadius = 50;
    borderLayer.borderColor = [UIColor blackColor].CGColor;
    borderLayer.borderWidth = 2.0f;
    borderLayer.masksToBounds = YES;
    
    CALayer* overLayLayer = [CALayer layer];
    overLayLayer.frame = CGRectMake(0, 0, 50, 50);
    overLayLayer.backgroundColor = [UIColor redColor].CGColor;
    [borderLayer addSublayer:overLayLayer];
    
    [self.view.layer addSublayer:borderLayer];
    
    UILabel* clippingPathDemoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 244, 200, 21)];
    clippingPathDemoLabel.text = @"Clipping Path - Layers";
    [self.view addSubview:clippingPathDemoLabel];
    
    UILabel* shadowsDemoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 370, 200, 21)];
    shadowsDemoLabel.text = @"Shadows";
    [self.view addSubview:shadowsDemoLabel];
    
    CALayer* shadowLayer = [CALayer layer];
    shadowLayer.frame = CGRectMake(0, 0, 50, 50);
    shadowLayer.position = CGPointMake(50, self.view.center.y + 190);
    shadowLayer.borderWidth = 2.0f;
    shadowLayer.borderColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOpacity = 1.0;
    shadowLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
    shadowLayer.shadowOffset = CGSizeMake(0.0,10.0);
    shadowLayer.shadowColor = [UIColor grayColor].CGColor;
    shadowLayer.shadowRadius = 10.0f;
    [self.view.layer addSublayer:shadowLayer];
    
    UIImageView* shadowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"donald.png"]];
    shadowImage.frame = CGRectMake(0, 0, 100, 100);
    shadowImage.layer.position = CGPointMake(150, self.view.center.y + 200);
    shadowImage.layer.shadowOpacity = 0.5;
    CGMutablePathRef shadowPathRect = CGPathCreateMutable();
    CGPathAddRect(shadowPathRect, nil, shadowImage.bounds);
    shadowImage.layer.shadowPath = shadowPathRect;
    CGPathRelease(shadowPathRect);
    [self.view.layer addSublayer:shadowImage.layer];
    
    UIImageView* shadowImageCircular = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cone.png"]];
    shadowImageCircular.frame = shadowImage.frame;
    shadowImageCircular.layer.position = CGPointMake(250, self.view.center.y + 200);
    shadowImageCircular.layer.shadowOpacity = 0.5;
    CGMutablePathRef shadowPathCircular = CGPathCreateMutable();
    CGPathAddEllipseInRect(shadowPathCircular, nil, shadowImageCircular.bounds);
    //shadowImageCircular.layer.shadowPath = shadowPathCircular;
    shadowImageCircular.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    shadowImageCircular.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    CGPathRelease(shadowPathCircular);
    [self.view.layer addSublayer:shadowImageCircular.layer];
    
}
- (IBAction)maskImageButtonPressed:(UIButton*)sender {
    self.leftImageLeadingSpaceCostraint.constant = self.view.frame.size.width/2 - (self.maskingImage.frame.size.width/2) - 16;
    self.rightImageTrailingSpaceCostraint.constant = -self.view.frame.size.width/2 + (self.originalImageView.frame.size.width/2) + 16;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.maskedImageView.alpha = 0.0;
            self.originalImageView.alpha = 0.0;
            self.maskedImageView.alpha = 1.0;
            CALayer* maskLayer = [CALayer layer];
            maskLayer.frame = self.maskedImageView.bounds;
            UIImage* maskImage = [UIImage imageNamed:@"donald.png"];
            maskLayer.contents = (__bridge id) maskImage.CGImage;
            self.maskedImageView.layer.mask = maskLayer;
            sender.hidden = YES;
        }];
    }];
}



@end
