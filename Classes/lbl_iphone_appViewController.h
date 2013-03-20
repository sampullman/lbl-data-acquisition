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
#import "SavedFieldsView.h"

@interface lbl_iphone_appViewController : UIFieldViewController 
        <NSFetchedResultsControllerDelegate, CoreLocationControllerDelegate,
        SavedFieldsViewDelegate> {
	IBOutlet UILabel *gpsLabel;
	IBOutlet UIButton *addFieldButton;
	IBOutlet UIButton *submitButton;
    NSMutableArray *fieldsToLoad;
}
@property (nonatomic, strong) IBOutlet UILabel *gpsLabel;
@property (nonatomic, strong) IBOutlet UIButton *addFieldButton;
@property (nonatomic, strong) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) NSMutableArray *fieldsToLoad;

- (IBAction) submitPoint;
- (IBAction) gotoPoints;
- (IBAction) saveFields;
- (IBAction) loadFields;

@end

