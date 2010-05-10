//
//  ViewRotationTestAppDelegate.h
//  ViewRotationTest
//
//  Created by Brian Hardy on 4/19/10.
//  Copyright Big Nerd Ranch 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewRotationTestViewController;

@interface ViewRotationTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewRotationTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewRotationTestViewController *viewController;

@end

