//
//  ViewRotationTestViewController.h
//  ViewRotationTest
//
//  Created by Brian Hardy on 4/19/10.
//  Copyright Big Nerd Ranch 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewRotationTestViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UITextField *anchorPointXTextField;
	IBOutlet UITextField *anchorPointYTextField;
	IBOutlet UIView *rotatingSuperview;
	IBOutlet UIView *rotatingView;
	IBOutlet UITextField *rotationValueTextField;
	IBOutlet UISlider *rotationSlider;
	IBOutlet UISwitch *positionCorrectionSwitch;
	IBOutlet UISegmentedControl *rotationSegmentedControl;
	BOOL correctPosition;
	BOOL rotationAffectsSuperview;
}

- (IBAction)rotationSliderValueChanged:(id)sender;
- (IBAction)rotateLeft:(id)sender;
- (IBAction)rotateRight:(id)sender;
- (IBAction)positionCorrectionSwitchValueChanged:(id)sender;
- (IBAction)rotationSegmentedControlValueChanged:(id)sender;

- (void)correctLayerPosition;

@end

