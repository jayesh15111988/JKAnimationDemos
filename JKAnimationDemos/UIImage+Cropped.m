//
//  UIImage+Cropped.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/8/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "UIImage+Cropped.h"

@implementation UIImage (Cropped)

- (UIImage *)cropImageWithRect:(CGRect)cropRect {
    cropRect = CGRectMake(cropRect.origin.x * self.scale,
                          cropRect.origin.y * self.scale,
                          cropRect.size.width * self.scale,
                          cropRect.size.height * self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

@end
