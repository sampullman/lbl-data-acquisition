//
//  lbl_iphone_appViewController.m
//  lbl-iphone-app
//
//  Created by John Peterson on 11/13/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "lbl_iphone_appViewController.h"
#import "PointsViewController.h"

@implementation lbl_iphone_appViewController

@synthesize gpsLabel;
@synthesize addFieldButton;
@synthesize submitButton;

CLLocation *lastGPSLoc;

- (void) reposition {
	CGRect addButtonFrame = [self.addFieldButton frame];
	CGRect submitFrame = [self.submitButton frame];
	addButtonFrame.origin.y = self.nextFieldY;
	submitFrame.origin.y = self.nextFieldY + 40;
	self.addFieldButton.frame = addButtonFrame;
	self.submitButton.frame = submitFrame;
}

- (IBAction) submitPoint {
	if([self.values count] > 0) {
		UITextField *field = [self.values objectAtIndex:0];
		NSMutableString *pointText = [[NSMutableString alloc] initWithFormat:@"%@",field.text];
		for(int i=1;i<[self.values count];i+=1) {
			field = [self.values objectAtIndex:i];
			[pointText appendFormat:@", %@",field.text];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:pointText
											message:@"USB GPS data unavailable. Submit anyways?"
											delegate:self
											cancelButtonTitle:@"Cancel"
											otherButtonTitles:@"Ok", nil];
		[alert setTag:2];
		[alert show];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if([alertView tag] == 2) {
		if(buttonIndex == 1) {
			NSManagedObjectContext *context = [self.appManager managedObjectContext];
			SavedPoint *point = (SavedPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"SavedPoint"
																			inManagedObjectContext:context];
			point.time = [NSDate date];
			for(int i=0;i<[self.fields count];i+=1) {
				SavedField *field = (SavedField *)[NSEntityDescription insertNewObjectForEntityForName:@"SavedField"
                            inManagedObjectContext:context];
				field.name = [[self.fields objectAtIndex:i] text];
                UITextField *value = [self.values objectAtIndex:i];
				field.value = [value text];
                bool autoInc = [[self.autoIncs objectAtIndex:i] isSelected];
                if(autoInc) {
                    NSNumber *nextVal = [NSNumber numberWithFloat:[field.value floatValue] + 1];
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setMaximumFractionDigits:6];
                    [formatter setMinimumFractionDigits:0];
                    value.text = [formatter stringFromNumber:nextVal];
                }
				[point addFieldsObject:field];
			}
            if(lastGPSLoc) {
                SavedLocation *loc = (SavedLocation *)[NSEntityDescription
                                insertNewObjectForEntityForName:@"SavedLocation" inManagedObjectContext:context];
                loc.latitude = [NSNumber numberWithDouble:lastGPSLoc.coordinate.latitude];
                loc.longitude = [NSNumber numberWithDouble:lastGPSLoc.coordinate.longitude];
                point.location = loc;
            }
			NSError *error;
			// here's where the actual save happens, and if it doesn't we print something out to the console
			if (![managedObjectContext save:&error]) {
				NSLog(@"Problem saving: %@", [error localizedDescription]);
			}
		}
    } else {
        [super alertView:alertView didDismissWithButtonIndex:buttonIndex];
    }
}

- (IBAction) gotoPoints {
	PointsViewController * points = [[PointsViewController alloc] initWithNibName:@"PointsViewController" bundle:nil];
	[self.navigationController pushViewController:points animated:YES];
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	lastGPSLoc = nil;
	self.canRemoveFields = true;
	self.navigationItem.title = @"Data Entry";
	UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"Points" 
														style:UIBarButtonItemStylePlain target:self
																action:@selector(gotoPoints)];
	self.navigationItem.rightBarButtonItem = rightBtn;
	for(int i=0;i<[self.inputFieldsModel	count];i+=1) {
		[self insertField:[self.inputFieldsModel get:i] presetValue:@""];
	}
	[self reposition];
	[self.appManager setLocationDelegate:self];
	[self.appManager.locMgr startUpdatingLocation];
	self.gpsLabel.text = @"N/A";
}

- (void)locationUpdate:(CLLocation *)location {
	lastGPSLoc = location;
	self.gpsLabel.text = [NSString stringWithFormat: @"%.4lf %.4lf ", 
					 location.coordinate.latitude,
					 location.coordinate.longitude];
    NSLog(@"got loc update");
}

- (void)locationError:(NSError *)error {
	//locLabel.text = [error description];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
