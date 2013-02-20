//
//  lbl_iphone_appViewController.h
//  lbl-iphone-app
//
//  Created by John Peterson on 11/13/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.

#import "UIFieldViewController.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>
#import "InputFieldsModel.h"
#import "SavedPoint.h"
#import "SavedField.h"
#import "CoreLocationControllerDelegate.h"

@interface lbl_iphone_appViewController : UIFieldViewController <NSFetchedResultsControllerDelegate, CoreLocationControllerDelegate> {
	IBOutlet UILabel *gpsLabel;
	IBOutlet UIButton *addFieldButton;
	IBOutlet UIButton *submitButton;
}
@property (nonatomic, strong) IBOutlet UILabel *gpsLabel;
@property (nonatomic, strong) IBOutlet UIButton *addFieldButton;
@property (nonatomic, strong) IBOutlet UIButton *submitButton;

- (IBAction) submitPoint;
- (IBAction) gotoPoints;

@end

