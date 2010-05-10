//
//  ViewRotationTestViewController.m
//  ViewRotationTest
//
//  Created by Brian Hardy on 4/19/10.
//  Copyright Big Nerd Ranch 2010. All rights reserved.
//

#import "ViewRotationTestViewController.h"
#import <QuartzCore/QuartzCore.h>

CABasicAnimation *makeRotateAnimation(float fromValue, float toValue) {
	CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	rotate.fromValue = [NSNumber numberWithFloat:fromValue];
	rotate.toValue = [NSNumber numberWithFloat:toValue];
	rotate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	rotate.duration = 2.0;
	return rotate;
}

@implementation ViewRotationTestViewController



- (IBAction)rotationSliderValueChanged:(id)sender {
	UIView *viewToRotate = rotationAffectsSuperview ? rotatingSuperview : rotatingView;
	viewToRotate.transform = CGAffineTransformMakeRotation(rotationSlider.value * M_PI);
	rotationValueTextField.text = [NSString stringWithFormat:@"%.2f", rotationSlider.value];
}

- (IBAction)rotateLeft:(id)sender {
	UIView *viewToRotate = rotationAffectsSuperview ? rotatingSuperview : rotatingView;
	CABasicAnimation *rotate = makeRotateAnimation(0, -M_PI);
	[viewToRotate.layer addAnimation:rotate forKey:nil];
	viewToRotate.transform = CGAffineTransformMakeRotation(-M_PI);
}

- (IBAction)rotateRight:(id)sender {
	UIView *viewToRotate = rotationAffectsSuperview ? rotatingSuperview : rotatingView;
	CABasicAnimation *rotate = makeRotateAnimation(0, M_PI);
	[viewToRotate.layer addAnimation:rotate forKey:nil];
	viewToRotate.transform = CGAffineTransformMakeRotation(M_PI);
}

- (IBAction)positionCorrectionSwitchValueChanged:(id)sender {
	correctPosition = positionCorrectionSwitch.on;
	if (correctPosition) {
		// correct the position relative to the anchor point
		[self correctLayerPosition];
	} else {
		CGRect bounds = rotatingView.bounds;
		// reset the position to the original anchorPoint's location in the superlayer
		rotatingView.layer.position = CGPointMake(0.5 * bounds.size.width, 0.5 * bounds.size.height);
	}
}

- (IBAction)rotationSegmentedControlValueChanged:(id)sender {
	rotationAffectsSuperview = (rotationSegmentedControl.selectedSegmentIndex == 0) ? NO : YES;
}

- (void)correctLayerPosition {
	CGPoint position = rotatingView.layer.position;
	CGPoint anchorPoint = rotatingView.layer.anchorPoint;
	CGRect bounds = rotatingView.bounds;
	// 0.5, 0.5 is the default anchorPoint; calculate the difference
	// and multiply by the bounds of the view
	position.x = (0.5 * bounds.size.width) + (anchorPoint.x - 0.5) * bounds.size.width;
	position.y = (0.5 * bounds.size.height) + (anchorPoint.y - 0.5) * bounds.size.height;
	rotatingView.layer.position = position;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	CGPoint anchorPoint = rotatingView.layer.anchorPoint;
	anchorPointXTextField.text = [NSString stringWithFormat:@"%.1f", anchorPoint.x];
	anchorPointYTextField.text = [NSString stringWithFormat:@"%.1f", anchorPoint.y];
	positionCorrectionSwitch.on = correctPosition;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[anchorPointXTextField release];
	anchorPointXTextField = nil;
	[anchorPointYTextField release];
	anchorPointYTextField = nil;
	[rotatingView release];
	rotatingView = nil;
	[rotatingSuperview release];
	rotatingSuperview = nil;
	[rotationValueTextField release];
	rotationValueTextField = nil;
	[rotationSlider release];
	rotationSlider = nil;
	[positionCorrectionSwitch release];
	positionCorrectionSwitch = nil;
	[rotationSegmentedControl release];
	rotationSegmentedControl = nil;
}


- (void)dealloc {
	[anchorPointXTextField release];
	[anchorPointYTextField release];
	[rotatingView release];
	[rotatingSuperview release];
	[rotationValueTextField release];
	[rotationSlider release];
	[positionCorrectionSwitch release];
	[rotationSegmentedControl release];
	[super dealloc];
}

#pragma mark UITextFieldDelegate methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
	CGPoint anchorPoint = rotatingView.layer.anchorPoint;
	if (textField == anchorPointXTextField) {
		anchorPoint.x = [textField.text floatValue];
	} else if (textField == anchorPointYTextField) {
		anchorPoint.y = [textField.text floatValue];
	}
	// update the anchorPoint based on values from the text field
	rotatingView.layer.anchorPoint = anchorPoint;
	if (correctPosition)
		[self correctLayerPosition];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField == anchorPointXTextField) {
		// advance to the next text field
		[anchorPointYTextField becomeFirstResponder];
	} else if (textField == anchorPointYTextField) {
		// make the keyboard go away
		[textField resignFirstResponder];
	}
	return YES;
}

@end
