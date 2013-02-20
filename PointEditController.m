//
//  PointEditController.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/14/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "PointEditController.h"

@implementation PointEditController

@synthesize point;
@synthesize dateLabel;
@synthesize locLabel;
@synthesize resendButton;

- (void) reposition {
	CGRect resendButtonFrame = [self.resendButton frame];
	resendButtonFrame.origin.y = self.nextFieldY;
	self.resendButton.frame = resendButtonFrame;
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	self.canRemoveFields = false;
	self.navigationItem.title = @"Edit Point";
	self.appManager = [AppManager getInstance];
	self.dateLabel.textAlignment = UITextAlignmentRight; 
	self.locLabel.textAlignment = UITextAlignmentCenter ; 
	self.dateLabel.text = [self.appManager dateToString:self.point.time];
    SavedLocation *location = self.point.location;
    if(location) {
        self.locLabel.text = [self.appManager getLocationString:location];
    } else {
        self.locLabel.text = @"None";
    }
	self.nextFieldY = 85.0;
    NSLog(@"num fields: %d", [self.point.fields count]);
	for(SavedField *field in self.point.fields) {
		NSLog(@"field: %@, value: %@", field.name, field.value);
		[self insertField:field.name presetValue:field.value];
	}
	[self reposition];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




@end
