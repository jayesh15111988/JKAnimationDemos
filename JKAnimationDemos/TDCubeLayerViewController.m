//
//  3DCubeLayerViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/7/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "TDCubeLayerViewController.h"
#import <QuartzCore/QuartzCore.h>
#define ROTATION_ANGLE_INCREMENT_FACTOR 10
#define MAXIMUM_ROTATION_ANGLE_VALUE 360

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface TDCubeLayerViewController ()
@property (strong, nonatomic) IBOutlet UIView *cubeContainer;
@property (assign) CATransform3D cubeShapeTransform;
@property (weak, nonatomic) IBOutlet UILabel *rotationDirectionLabel;
@property (strong) CALayer* cubeLayer;
@property (assign) CGFloat xAngle;
@property (assign) CGFloat yAngle;
@property (assign) CGFloat zAngle;
@property (assign) NSInteger rotationAngleDirectionToggle;
@end

@implementation TDCubeLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rotationAngleDirectionToggle = 1;
    self.title = @"3D Cube transitions Demo";
    self.xAngle = 0;
    self.yAngle = self.xAngle;
    self.zAngle = self.yAngle;
    
    CATransform3D cubeTransform = CATransform3DIdentity;
    cubeTransform.m34 = -1.0/500.0;
    self.cubeContainer.layer.sublayerTransform = cubeTransform;
    
    self.cubeShapeTransform = CATransform3DIdentity;
    self.cubeShapeTransform = CATransform3DTranslate(self.cubeShapeTransform, -50, 0, 0);
    self.cubeShapeTransform = CATransform3DRotate(self.cubeShapeTransform, 0, 1, 0, 0);
    //self.cubeShapeTransform = CATransform3DRotate(self.cubeShapeTransform, -M_PI_4, 1, 0, 0);
    self.cubeLayer = [self createCubeWithTransform:self.cubeShapeTransform];
    [self.cubeContainer.layer addSublayer:self.cubeLayer];
}


-(CALayer*)createLayerWithTransform:(CATransform3D)transform {
    CALayer* cubeFace = [CALayer new];
    cubeFace.frame = CGRectMake(50, 50, 100, 100);
    CGFloat red = (rand()/(double)INT_MAX);
    CGFloat green = (rand()/(double)INT_MAX);
    CGFloat blue = (rand()/(double)INT_MAX);
    cubeFace.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    cubeFace.transform = transform;
    return cubeFace;
}
- (IBAction)transformXButtonPressed:(id)sender {
    self.xAngle += ROTATION_ANGLE_INCREMENT_FACTOR;
    
    if(self.xAngle >= MAXIMUM_ROTATION_ANGLE_VALUE) {
        self.xAngle = 0.0;
    }
    
    self.cubeShapeTransform = CATransform3DRotate(self.cubeShapeTransform, self.rotationAngleDirectionToggle * DEGREES_TO_RADIANS(self.xAngle), 1, 0, 0);
    [UIView animateWithDuration:2.0 animations:^{
        self.cubeLayer.transform = self.cubeShapeTransform;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)transformYButtonPressed:(id)sender {
    self.yAngle += ROTATION_ANGLE_INCREMENT_FACTOR;
    
    if(self.yAngle >= MAXIMUM_ROTATION_ANGLE_VALUE) {
        self.yAngle = 0.0;
    }
    self.cubeShapeTransform = CATransform3DRotate(self.cubeShapeTransform, self.rotationAngleDirectionToggle * DEGREES_TO_RADIANS(self.yAngle), 0, 1, 0);
    [UIView animateWithDuration:2.0 animations:^{
        self.cubeLayer.transform = self.cubeShapeTransform;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)transformZButtonPressed:(id)sender {
    self.zAngle += ROTATION_ANGLE_INCREMENT_FACTOR;
    
    if(self.zAngle >= MAXIMUM_ROTATION_ANGLE_VALUE) {
        self.zAngle = 0.0;
    }
    self.cubeShapeTransform = CATransform3DRotate(self.cubeShapeTransform, self.rotationAngleDirectionToggle * DEGREES_TO_RADIANS(self.zAngle), 0, 0, 1);
    [UIView animateWithDuration:2.0 animations:^{
        self.cubeLayer.transform = self.cubeShapeTransform;
    } completion:^(BOOL finished) {
        
    }];
}

-(CALayer*)createCubeWithTransform:(CATransform3D)transform {
    CATransformLayer* cube = [CATransformLayer new];
    
    CATransform3D facesTransform = CATransform3DIdentity;
    
    facesTransform = CATransform3DMakeTranslation(0, 0, 50);
    CALayer* firstSide = [self createLayerWithTransform:facesTransform];
    [cube addSublayer:firstSide];
    
    facesTransform = CATransform3DMakeTranslation(50, 0, 0);
    facesTransform = CATransform3DRotate(facesTransform, M_PI_2, 0, 1, 0);
    CALayer* secondSide = [self createLayerWithTransform:facesTransform];
    [cube addSublayer:secondSide];
    
    facesTransform = CATransform3DMakeTranslation(0, -50, 0);
    facesTransform = CATransform3DRotate(facesTransform, -M_PI_2, 1, 0, 0);
    CALayer* thirdSide = [self createLayerWithTransform:facesTransform];
    [cube addSublayer:thirdSide];
    
    facesTransform = CATransform3DMakeTranslation(0, 50, 0);
    facesTransform = CATransform3DRotate(facesTransform, M_PI_2, 1, 0, 0);
    CALayer* fourthSide = [self createLayerWithTransform:facesTransform];
    [cube addSublayer:fourthSide];
    
    facesTransform = CATransform3DMakeTranslation(-50, 0, 0);
    facesTransform = CATransform3DRotate(facesTransform, -M_PI_2, 0, 1, 0);
    CALayer* fifthSide = [self createLayerWithTransform:facesTransform];
    [cube addSublayer:fifthSide];
    
    facesTransform = CATransform3DMakeTranslation(0, 0, -50);
    facesTransform = CATransform3DRotate(facesTransform, M_PI, 0, 1, 0);
    CALayer* sixthSide = [self createLayerWithTransform:facesTransform];
    [cube addSublayer:sixthSide];
    
    cube.position = CGPointMake(self.cubeContainer.frame.size.width/2, self.cubeContainer.frame.size.height/2);
    
    cube.transform = transform;
    
    return cube;
}

- (IBAction)rotationDirectionSwitchChanged:(UISwitch *)sender {
    self.rotationDirectionLabel.text = sender.isOn ? @"Anticlockwise" : @"Clockwise";
    self.rotationAngleDirectionToggle *= -1;
}


@end
