//
//  CustomLineDrawingView.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/19/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "CustomLineDrawingView.h"

@interface CustomLineDrawingView ()
@property (strong) CAShapeLayer* customLineLayer;
@property (strong) UIBezierPath* bezierPath;
@property (strong) NSMutableArray* tempPointsCollection;
@property (strong) NSMutableArray* pointsCollection;
@property (assign) CGPoint beginPoint;
@end

@implementation CustomLineDrawingView

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

-(void)awakeFromNib {
    self.tempPointsCollection = [NSMutableArray new];
    self.pointsCollection = [NSMutableArray new];
    self.customLineLayer = [CAShapeLayer layer];
    self.customLineLayer.strokeColor = [UIColor blackColor].CGColor;
    self.customLineLayer.fillColor = [UIColor clearColor].CGColor;
    self.bezierPath = [UIBezierPath bezierPath];
    self.customLineLayer.path = self.bezierPath.CGPath;
    [self.layer addSublayer:self.customLineLayer];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchBeginPoint = [[touches anyObject] locationInView:self];
    [self.bezierPath moveToPoint:touchBeginPoint];
    self.beginPoint = touchBeginPoint;
    [self.tempPointsCollection addObject:[NSValue valueWithCGPoint:self.beginPoint]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchMovePoint = [[touches anyObject] locationInView:self];
    [self.tempPointsCollection removeLastObject];
    [self.tempPointsCollection addObject:[NSValue valueWithCGPoint:self.beginPoint]];
    [self.tempPointsCollection addObject:[NSValue valueWithCGPoint:touchMovePoint]];
    [self.bezierPath removeAllPoints];
    
    NSInteger counter = 0;
    for(NSValue* value in _pointsCollection) {
        if(counter % 2 == 0) {
            [self.bezierPath moveToPoint:[value CGPointValue]];
        } else {
            [self.bezierPath addLineToPoint:[value CGPointValue]];
        }
        counter++;
    }
    [self.bezierPath moveToPoint:self.beginPoint];
    [self.bezierPath addLineToPoint:touchMovePoint];

    self.customLineLayer.path = self.bezierPath.CGPath;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint touchEndPoint = [[touches anyObject] locationInView:self];
    [_tempPointsCollection removeLastObject];
    [_tempPointsCollection addObject:[NSValue valueWithCGPoint:(self.beginPoint)]];
    [_tempPointsCollection addObject:[NSValue valueWithCGPoint:touchEndPoint]];
    [_pointsCollection addObjectsFromArray:[self.tempPointsCollection copy]];
    [self.bezierPath addLineToPoint:touchEndPoint];
    self.customLineLayer.path = self.bezierPath.CGPath;
}

@end
