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
@property (strong, nonatomic) NSArray* demosList;
@property (strong, nonatomic) NSArray* storyboardIdentifiersCollection;
@end

@implementation JKLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Animation Demos";
    self.demosList = @[@"Faded View", @"Animated Image", @"Bezier Path", @"3D Cube", @"Emitter Layer", @"Video Playback", @"Animation Demo", @"Bezier Movement", @"Custom Transition", @"Media Timings", @"Bezier Curve Fun", @"More Examples"];
    self.storyboardIdentifiersCollection = @[@"fading", @"animatedimage", @"bezierpath", @"3dcube", @"emitter", @"video", @"animation", @"beziermovement", @"customtransition", @"mediatiming", @"bezierplay", @"layermask"];
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
    UIViewController* destinationViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.storyboardIdentifiersCollection[indexPath.row]];
    [self.navigationController pushViewController:destinationViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.demosList count];
}


@end
