//
//  PointsViewController.h
//  lbl-iphone-app
//
//  Created by John Peterson on 11/14/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "lbl_iphone_appAppDelegate.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SavedPoint.h"
#import "AppManager.h"
#import "PointEditController.h"


@interface PointsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	AppManager *appManager;
	NSMutableArray *savedPoints;
	IBOutlet UITableView *pointsView;
}
@property (nonatomic, strong) AppManager *appManager;
@property (nonatomic, strong) NSMutableArray *savedPoints;
@property (nonatomic, strong) IBOutlet UITableView *pointsView;

- (IBAction)sendPoints;

@end
