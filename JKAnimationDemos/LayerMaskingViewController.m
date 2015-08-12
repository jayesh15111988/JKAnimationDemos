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
    
    CAShapeLayer* blueLayer = [CAShapeLayer layer];
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.frame = CGRectMake(10, 100, 40, 40);
    blueLayer.fillColor = [UIColor redColor].CGColor;
    blueLayer.strokeColor = [UIColor yellowColor].CGColor;
    blueLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(7.5, 7.5, 25, 25) cornerRadius:10].CGPath;
    [self.view.layer addSublayer:blueLayer];
    
    CGRect rect = CGRectMake(0, 0, 20, 20);
    CGSize radius = CGSizeMake(10, 10);
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    CAShapeLayer* lay1 = [CAShapeLayer layer];
    lay1.frame = CGRectMake(50, 50, 35, 35);
    lay1.backgroundColor = [UIColor clearColor].CGColor;
    lay1.path = bezierPath.CGPath;
    [self.view.layer addSublayer:lay1];
    
    UIView* sam = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    sam.backgroundColor = [UIColor lightGrayColor];
    sam.layer.mask = lay1;
    [self.view addSubview:sam];
    
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
    
    UIButton* but1 = [UIButton new];
    //[but1 setTitle:@"but 1" forState:UIControlStateNormal];
    [but1 setBackgroundColor:[UIColor redColor]];
    but1.frame = CGRectMake(100, 300, 100, 30);
    but1.alpha = 0.3;
    
    UIButton* but2 = [UIButton new];
    [but2 setBackgroundColor:[UIColor redColor]];
    //[but2 setTitle:@"but 2" forState:UIControlStateNormal];
    but2.frame = CGRectMake(0, 0, 50, 20);
    but2.alpha = 0.3;
    
    [but1 addSubview:but2];
    [self.view addSubview:but1];
    
    
    
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
    shadowImage.layer.shadowOffset = CGSizeMake(10, 10);
    CGMutablePathRef shadowPathRect = CGPathCreateMutable();
    CGPathAddRect(shadowPathRect, nil, shadowImage.bounds);
    shadowImage.layer.shadowPath = shadowPathRect;
    CGPathRelease(shadowPathRect);
    [self.view.layer addSublayer:shadowImage.layer];
    
    UIImageView* shadowImageCircular = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cone.png"]];
    shadowImageCircular.frame = shadowImage.frame;
    shadowImageCircular.layer.position = CGPointMake(280, self.view.center.y + 200);
    shadowImageCircular.layer.shadowOpacity = 0.5;
    CGMutablePathRef shadowPathCircular = CGPathCreateMutable();
    CGPathAddEllipseInRect(shadowPathCircular, nil, shadowImageCircular.bounds);
    shadowImageCircular.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    shadowImageCircular.layer.shadowOffset = CGSizeMake(-10.0, -10.0);
    //shadowImageCircular.layer.shadowPath = shadowPathCircular;
    CGPathRelease(shadowPathCircular);
    [self.view.layer addSublayer:shadowImageCircular.layer];
    [self maskImageButtonPressed:nil];
}

- (CGColorRef)getRandomColor {
    CGFloat redColor = rand()/(CGFloat)INT_MAX;
    CGFloat greenColor = rand()/(CGFloat)INT_MAX;
    CGFloat blueColor = rand()/(CGFloat)INT_MAX;
    return [UIColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0].CGColor;
}

- (IBAction)maskImageButtonPressed:(UIButton*)sender {
    self.leftImageLeadingSpaceCostraint.constant = self.view.frame.size.width/2 - (self.maskingImage.frame.size.width/2) - 16;
    self.rightImageTrailingSpaceCostraint.constant = -self.view.frame.size.width/2 + (self.originalImageView.frame.size.width/2) + 16;
    [UIView animateWithDuration:0.0 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.0 animations:^{
            self.originalImageView.alpha = 0.0;
            self.maskedImageView.alpha = 1.0;
            UIImage* maskImage = [UIImage imageNamed:@"donald.png"];
            CALayer* maskLayer = [CALayer layer];
            maskLayer.frame = self.maskedImageView.bounds;
            maskLayer.contents = (__bridge id) maskImage.CGImage;
            self.maskedImageView.layer.mask = maskLayer;
        } completion:^(BOOL finished) {
            sender.hidden = YES;
        }];
    }];
}

@end
