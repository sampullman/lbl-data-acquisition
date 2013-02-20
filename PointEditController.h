//
//  PointEditController.h
//  lbl-iphone-app
//
//  Created by John Peterson on 11/14/12.
//  Copyright 2012 Berkeley Lab. All rights reserved.
//

#import "UIFieldViewController.h"
#import <UIKit/UIKit.h>
#import "SavedPoint.h"
#import "AppManager.h"

@interface PointEditController : UIFieldViewController {
	SavedPoint *point;
	IBOutlet UILabel *dateLabel;
	IBOutlet UILabel *locLabel;
	IBOutlet UIButton *resendButton;
}
@property (nonatomic, strong) SavedPoint *point;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UILabel *locLabel;
@property (nonatomic, strong) IBOutlet UIButton *resendButton;

@end
