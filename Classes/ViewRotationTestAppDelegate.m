//
//  ViewRotationTestAppDelegate.m
//  ViewRotationTest
//
//  Created by Brian Hardy on 4/19/10.
//  Copyright Big Nerd Ranch 2010. All rights reserved.
//

#import "ViewRotationTestAppDelegate.h"
#import "ViewRotationTestViewController.h"

@implementation ViewRotationTestAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
