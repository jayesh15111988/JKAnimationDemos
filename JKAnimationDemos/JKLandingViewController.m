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

@interface JKLandingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSArray* demosList;
@end

@implementation JKLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Animation Demos";
    self.demosList = @[@"Loading View", @"Faded View", @"Animated Image", @"Bezier Path", @"3D Cube", @"Replication Layer", @"Emitter Layer", @"Video Playback"];
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
    if(indexPath.row == 0) {
        LoadingAnimationDemoViewController* loadingDemo = [self.storyboard instantiateViewControllerWithIdentifier:@"loading"];
        [self.navigationController pushViewController:loadingDemo animated:YES];
    } else if(indexPath.row == 1){
        FadingBackgroundViewController* fadingBackgroundViewController = (FadingBackgroundViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"fading"];
        [self.navigationController pushViewController:fadingBackgroundViewController animated:YES];
    } else if (indexPath.row == 2) {
        AnimatedImageDemoViewController* animatedImageViewController = (AnimatedImageDemoViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"animatedimage"];
        [self.navigationController pushViewController:animatedImageViewController animated:YES];
    } else if (indexPath.row == 3) {
        BezierCurveArtViewController* bezierPath = (BezierCurveArtViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"bezierpath"];
        [self.navigationController pushViewController:bezierPath animated:YES];
    } else if (indexPath.row == 4) {
        TDCubeLayerViewController* cubeViewCotroller = (TDCubeLayerViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"3dcube"];
        [self.navigationController pushViewController:cubeViewCotroller animated:YES];
    } else if (indexPath.row == 5) {
        ReplicatorLayerViewController* replicateLayerViewController = (ReplicatorLayerViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"replicator"];
        [self.navigationController pushViewController:replicateLayerViewController animated:YES];
    } else if (indexPath.row == 6) {
        EmitterDemoViewController* emitterViewController = (EmitterDemoViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"emitter"];
        [self.navigationController pushViewController:emitterViewController animated:YES];
    } else if (indexPath.row == 7) {
        VideoPlaybackAndEditViewController* videoDemoViewControlelr = (VideoPlaybackAndEditViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"video"];
        [self.navigationController pushViewController:videoDemoViewControlelr animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.demosList count];
}


@end
