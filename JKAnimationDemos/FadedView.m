//
//  FadedView.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "FadedView.h"

@implementation FadedView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    size_t locationsCount = 2;
    CGFloat locations[4] = {0.0f,1.0f};
    CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,75.0f};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
    CGColorSpaceRelease(colorSpace);
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
    CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
}

@end
