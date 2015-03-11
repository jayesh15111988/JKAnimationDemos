//
//  CustomDrawingView.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/10/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "CustomDrawingView.h"

@interface CustomDrawingView ()<UITextFieldDelegate>
@property (strong) CAShapeLayer* viewLayer;
@property (strong) UIBezierPath* bezierPath;
@property (strong) NSMutableSet* tracedPointsCollection;
@property (assign) CGFloat brushSize;
@property (weak, nonatomic) IBOutlet UITextField *brushSizeField;

@end

@implementation CustomDrawingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */

- (void)drawRect:(CGRect)rect {
    for(NSValue* tracedPointValue in self.tracedPointsCollection) {
        CGPoint currentPoint = [tracedPointValue CGPointValue];
        [[UIImage imageNamed:@"redDot.png"] drawInRect:CGRectMake(currentPoint.x - self.brushSize, currentPoint.y - self.brushSize, self.brushSize, self.brushSize)];
    }
}

-(void)awakeFromNib {
    self.isRegularModeOn = YES;
    self.brushSizeField.delegate = self;
    self.tracedPointsCollection = [NSMutableSet set];
    self.bezierPath = [UIBezierPath bezierPath];
    self.viewLayer = [CAShapeLayer layer];
    self.viewLayer.strokeColor = [UIColor redColor].CGColor;
    self.viewLayer.fillColor = [UIColor clearColor].CGColor;
    self.viewLayer.lineWidth = 2.0f;
    [self.layer addSublayer:self.viewLayer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchBeginPoint = [[touches anyObject] locationInView:self];
    if(self.isRegularModeOn) {
        [self.bezierPath moveToPoint:touchBeginPoint];
    } else {
        [self.tracedPointsCollection addObject:[NSValue valueWithCGPoint:touchBeginPoint]];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    self.brushSize = [self.brushSizeField.text floatValue];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchMovePoint = [[touches anyObject] locationInView:self];
    if(self.isRegularModeOn) {
        [self.bezierPath addLineToPoint:touchMovePoint];
        self.viewLayer.path = self.bezierPath.CGPath;
    } else {
        [self.tracedPointsCollection addObject:[NSValue valueWithCGPoint:touchMovePoint]];
        [self setNeedsDisplay];
    }
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



@end
