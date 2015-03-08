//
//  EmitterDemoViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "EmitterDemoViewController.h"

@interface EmitterDemoViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation EmitterDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Emitter Layer Demo";
    
    CAEmitterLayer* emitterLayer = [CAEmitterLayer layer];
    emitterLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitterLayer];
    
    emitterLayer.renderMode = kCAEmitterLayerAdditive;
    emitterLayer.emitterPosition = CGPointMake(self.view.center.x, self.view.center.y);
    
    CAEmitterCell* emitterCell = [CAEmitterCell emitterCell];
    emitterCell.contents = (__bridge id) [UIImage imageNamed:@"redDot.png"].CGImage;
    emitterCell.birthRate = 20;
    emitterCell.lifetime = 5;
    emitterCell.velocity = 50;
    emitterCell.emissionRange = M_PI * 2;
    emitterCell.alphaSpeed = -0.5;
    emitterCell.velocityRange = 100;
    emitterLayer.emitterCells = @[emitterCell];
    
}

@end
