//
//  JKLandingViewController.m
//  JKAnimationDemos
//
//  Created by Jayesh Kawli Backup on 3/1/15.
//  Copyright (c) 2015 Jayesh Kawli Backup. All rights reserved.
//

#import "JKLandingViewController.h"
#import "LoadingAnimationDemoViewController.h"
#import "FadingBackgroundViewController.h"
#import "AnimatedImageDemoViewController.h"
#import "BezierCurveArtViewController.h"
#import "TDCubeLayerViewController.h"
#import "ReplicatorLayerViewController.h"
#import "EmitterDemoViewController.h"
#import "VideoPlaybackAndEditViewController.h"
#import "SimpleAnimationDemoViewController.h"
#import "ComplexBezierPathTrailDemoViewController.h"
#import "CustomTransitionViewController.h"
#import "MediaTimingFunctionsViewController.h"
#import "BezierCurveFromTimingFunctionsViewController.h"
#import "BezierCurvesTestViewController.h"
#import "LayerMaskingViewController.h"
#import "LineDrawDemoViewController.h"

@interface JKLandingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSArray* demosList;
@end

@implementation JKLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Animation Demos";
    self.demosList = @[@"Loading View", @"Faded View", @"Animated Image", @"Bezier Path", @"3D Cube", @"Replication Layer", @"Emitter Layer", @"Video Playback", @"Animation Demo", @"Bezier Movement", @"Custom Transition", @"Media Timings", @"Bezier from timing functions", @"Bezier Curve Fun", @"More Examples", @"Draw line With bezier"];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"animationDemoCell" forIndexPath:indexPath];
    cell.textLabel.text = self.demosList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController* destinationViewController = nil;
    if(indexPath.row == 0) {
        destinationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loading"];
    } else if(indexPath.row == 1){
        destinationViewController = (FadingBackgroundViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"fading"];
    } else if (indexPath.row == 2) {
        destinationViewController = (AnimatedImageDemoViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"animatedimage"];
    } else if (indexPath.row == 3) {
        destinationViewController = (BezierCurveArtViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"bezierpath"];
    } else if (indexPath.row == 4) {
        destinationViewController = (TDCubeLayerViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"3dcube"];
    } else if (indexPath.row == 5) {
        destinationViewController = (ReplicatorLayerViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"replicator"];
    } else if (indexPath.row == 6) {
        destinationViewController = (EmitterDemoViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"emitter"];
    } else if (indexPath.row == 7) {
        destinationViewController = (VideoPlaybackAndEditViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"video"];
    } else if (indexPath.row == 8) {
        destinationViewController = (SimpleAnimationDemoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"animation"];
    } else if (indexPath.row == 9) {
        destinationViewController = (ComplexBezierPathTrailDemoViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"beziermovement"];
    } else if (indexPath.row == 10) {
        destinationViewController = (CustomTransitionViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"customtransition"];
    } else if (indexPath.row == 11) {
        destinationViewController = (MediaTimingFunctionsViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"mediatiming"];
    } else if (indexPath.row == 12) {
        destinationViewController = (BezierCurveFromTimingFunctionsViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"bezierfromtiming"];
    } else if (indexPath.row == 13) {
        destinationViewController = (BezierCurvesTestViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"bezierplay"];
    } else if (indexPath.row == 14) {
        destinationViewController = (LayerMaskingViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"layermask"];
    } else if (indexPath.row == 15) {
        destinationViewController = (LineDrawDemoViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"linedrawing"];
    }
    [self.navigationController pushViewController:destinationViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.demosList count];
}


@end
