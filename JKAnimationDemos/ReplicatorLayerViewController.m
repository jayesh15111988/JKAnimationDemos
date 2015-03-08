//
//  ReplicatorLayerViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "ReplicatorLayerViewController.h"

#define VIEW_SIZE 100
@interface ReplicatorLayerViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation ReplicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Replicator Demo";
    CAReplicatorLayer* replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = self.containerView.bounds;
    replicatorLayer.instanceCount = 2.0f;
    self.containerView.layer.backgroundColor = [UIColor colorWithRed:0.26 green:1.0 blue:1.0 alpha:1.0].CGColor;
    [self.containerView.layer addSublayer:replicatorLayer];
    
    replicatorLayer.instanceAlphaOffset = -0.9;
    
    CATransform3D transform = CATransform3DIdentity;
    //transform = CATransform3DTranslate(transform, 50, 0, 0);
    //transform = CATransform3DRotate(transform, M_PI/5, 0, 0,1);
    //transform = CATransform3DTranslate(transform, -50, 0, 0);
    
    //transform = CATransform3DRotate(transform, M_PI, 1, 0, 0);
    //transform = CATransform3DTranslate(transform, 0, -10, 0);
    transform = CATransform3DTranslate(transform, 0, -2 * VIEW_SIZE + 5, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    replicatorLayer.instanceTransform = transform;
    
    CALayer* subReplicateLayer = [CALayer layer];
    subReplicateLayer.contents = (__bridge id) [UIImage imageNamed:@"changeColor.png"].CGImage;
    subReplicateLayer.frame = CGRectMake(self.view.center.x - (VIEW_SIZE/2), 0, VIEW_SIZE, VIEW_SIZE);
    [replicatorLayer addSublayer:subReplicateLayer];
    
    
}

@end
