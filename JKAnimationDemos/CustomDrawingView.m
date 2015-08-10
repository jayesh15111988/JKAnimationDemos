//
//  CustomDrawingView.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/10/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "CustomDrawingView.h"

@interface CustomDrawingView ()<UITextFieldDelegate>

@property (strong, nonatomic) CAShapeLayer* viewLayer;
@property (copy, nonatomic) UIBezierPath* bezierPath;
@property (copy, nonatomic) UIBezierPath* originalBezierPath;
@property (strong, nonatomic) NSMutableArray* tracedPointsCollection;
@property (strong, nonatomic) NSMutableArray* originalTracedPointsCollection;
@property (assign, nonatomic) CGFloat brushSize;
@property (assign, nonatomic) BOOL isBezierOptimized;
@property (weak, nonatomic) IBOutlet UILabel *modeIndicatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *optimizationStatusLabel;
@property (weak, nonatomic) IBOutlet UITextField *brushSizeField;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@property (assign, nonatomic) BOOL isRegularModeOn;
@property (strong, nonatomic) NSMutableArray* col;

@property (strong, nonatomic) CALayer* layer1;
@property (strong, nonatomic) CAShapeLayer *progressLayer;

@property (strong, nonatomic) NSDate* operationStartDate;
@property (strong, nonatomic) NSDate* operationEndDate;
@property (strong, nonatomic) NSTimer* timer;

@end

@implementation CustomDrawingView

- (void)drawRect:(CGRect)rect {
    for(NSValue* tracedPointValue in self.tracedPointsCollection) {
        CGPoint currentPoint = [tracedPointValue CGPointValue];
        CGRect rectangleToPaint = [self getRectFromPoint:currentPoint];
        if(self.isBezierOptimized) {
            if(CGRectIntersectsRect(rectangleToPaint, rect)){
                [[UIImage imageNamed:@"donald.png"] drawInRect:[self getRectFromPoint:currentPoint]];
            }
        } else {
            [[UIImage imageNamed:@"donald.png"] drawInRect:[self getRectFromPoint:currentPoint]];
        }
    }
}

- (CGRect)getRectFromPoint:(CGPoint)inputPoint {
    return CGRectMake(inputPoint.x - self.brushSize, inputPoint.y - self.brushSize, self.brushSize, self.brushSize);
}

- (void)drawPath:(NSTimer*)timer {
    if (self.originalTracedPointsCollection.count) {
        NSValue* pointValue = [self.originalTracedPointsCollection firstObject];
        [self.tracedPointsCollection addObject:pointValue];
        [self setNeedsDisplayInRect:[self getRectFromPoint:[pointValue CGPointValue]]];
        [self.originalTracedPointsCollection removeObjectAtIndex:0];
    }
}

- (void)awakeFromNib {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(drawPath:) userInfo:nil repeats:YES];
    
    self.col = [NSMutableArray new];
    self.isRegularModeOn = YES;
    self.isBezierOptimized = YES;
    self.brushSizeField.delegate = self;
    self.tracedPointsCollection = [NSMutableArray new];
    self.bezierPath = [UIBezierPath bezierPath];
    self.viewLayer = [CAShapeLayer layer];
    self.viewLayer.strokeColor = [UIColor redColor].CGColor;
    self.viewLayer.fillColor = [UIColor clearColor].CGColor;
    self.viewLayer.lineWidth = 1.0f;
    [self.layer addSublayer:self.viewLayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchBeginPoint = [[touches anyObject] locationInView:self];
    [self clearAllButtonPressed:nil];
    [self.col addObject:@"1"];
    [self.originalBezierPath removeAllPoints];
    self.viewLayer.path = self.originalBezierPath.CGPath;
    
    self.operationStartDate = [NSDate date];
    
    if(self.isRegularModeOn) {
        [self.bezierPath moveToPoint:touchBeginPoint];
    } else {
        [self.tracedPointsCollection addObject:[NSValue valueWithCGPoint:touchBeginPoint]];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.brushSize = [self.brushSizeField.text floatValue];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchMovePoint = [[touches anyObject] locationInView:self];
    [self.col addObject:@"1"];
    if(self.isRegularModeOn) {
        [self.bezierPath addLineToPoint:touchMovePoint];
        self.viewLayer.path = self.bezierPath.CGPath;
    } else {
        [self.tracedPointsCollection addObject:[NSValue valueWithCGPoint:touchMovePoint]];
        if(self.isBezierOptimized) {
            [self setNeedsDisplayInRect:[self getRectFromPoint:touchMovePoint]];
        } else {
            [self setNeedsDisplay];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    self.originalBezierPath = self.bezierPath;
    
    self.originalTracedPointsCollection = [self.tracedPointsCollection mutableCopy];
    [self.tracedPointsCollection removeAllObjects];


    
    
    //[self clearAllButtonPressed:nil];
    
    [self setNeedsDisplay];
    [UIView transitionWithView:self duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.layer displayIfNeeded];
                    } completion:^(BOOL finished) {
                        
                       self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(drawPath:) userInfo:nil repeats:YES];
                    }];
    
    self.operationEndDate = [NSDate date];
    NSTimeInterval executionTime = [self.operationEndDate timeIntervalSinceDate:self.operationStartDate];
    
    
    NSLog(@"Col Count is %ld", (long)self.col.count);
    [self.col removeAllObjects];
    self.progressLayer = [[CAShapeLayer alloc] init];
    
    [self.progressLayer setPath: self.originalBezierPath.CGPath];
    [self.progressLayer setStrokeColor:[UIColor redColor].CGColor];
    [self.progressLayer setFillColor:[UIColor clearColor].CGColor];
    [self.progressLayer setLineWidth:1.0f];
    [self.progressLayer setStrokeStart:0.0];
    [self.progressLayer setStrokeEnd:1.0];
    
    [self.layer addSublayer:self.progressLayer];
    
    
    CABasicAnimation *animateStrokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animateStrokeEnd.duration  = 2.0 * executionTime;
    animateStrokeEnd.fromValue = [NSNumber numberWithFloat:0.0f];
    animateStrokeEnd.toValue   = [NSNumber numberWithFloat:1.0f];
    animateStrokeEnd.removedOnCompletion = YES;
    [self.progressLayer addAnimation:animateStrokeEnd forKey:nil];
    
    
    self.layer1 = [CALayer layer];
    self.layer1.frame = CGRectMake(0, 0, 5, 5);
    self.layer1.backgroundColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:self.layer1];
    
    CABasicAnimation* colorChangeAnimation = [CABasicAnimation animation];
    colorChangeAnimation.keyPath = @"backgroundColor";
    colorChangeAnimation.toValue = (__bridge id) [UIColor blueColor].CGColor;
    
    //Usually use this approach for perform rotation while animating stuff
    CABasicAnimation* rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    rotationAnimation.byValue = @(M_PI*2);
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = self.originalBezierPath.CGPath;
    animation.removedOnCompletion = YES;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[colorChangeAnimation, animation];
    animationGroup.duration = 2 * executionTime;
    animationGroup.autoreverses = NO;
    animationGroup.delegate = self;
    [self.layer1 addAnimation:animationGroup forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)finished {
    if (finished) {
        [self.layer1 removeFromSuperlayer];
        [self.progressLayer removeFromSuperlayer];
        self.viewLayer.path = self.originalBezierPath.CGPath;
    }
}

- (IBAction)modeSwitchChanged:(UISwitch *)sender {
    self.isRegularModeOn = !self.isRegularModeOn;
    self.modeIndicatorLabel.text = [sender isOn]? @"Regular" : @"Custom";
}

- (IBAction)clearAllButtonPressed:(id)sender {
    if(self.isRegularModeOn) {
        [self.bezierPath removeAllPoints];
        self.viewLayer.path = self.bezierPath.CGPath;
    } else {
        [self.tracedPointsCollection removeAllObjects];
        [self setNeedsDisplay];
    }
}

- (IBAction)optimizationSwitchChanged:(UISwitch*)sender {
    self.optimizationStatusLabel.text = [sender isOn]? @"Optimized" : @"Unoptimized";
    self.isBezierOptimized = !self.isBezierOptimized;
    if(self.isBezierOptimized) {
        [self.modeSwitch setOn:NO];
        self.modeIndicatorLabel.text = @"Custom";
        self.isRegularModeOn = NO;
    }
    [self clearAllButtonPressed:nil];
}

@end
