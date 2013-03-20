//
//  UIFieldViewController.h
//  lbl-iphone-app
//
//  Created by John Peterson on 1/19/13.
//  Copyright 2013 Berkeley Lab. All rights reserved.
//
#import "AppManager.h"
#import "InputFieldsModel.h"
#import <CoreData/CoreData.h>
#import "SavedPoint.h"
#import "SavedField.h"

@interface UIFieldViewController : UIViewController <UITextFieldDelegate> {
	AppManager *appManager;
	float nextFieldY;
	bool canRemoveFields;
	NSMutableArray *fields;
	NSMutableArray *values;
	NSMutableArray *autoIncs;
	InputFieldsModel *inputFieldsModel;
	IBOutlet UIScrollView *mainView;
	NSMutableArray *removeButtons;
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, strong) AppManager *appManager;
@property (nonatomic, strong) IBOutlet UIScrollView *mainView;
@property (nonatomic, strong) InputFieldsModel *inputFieldsModel;
@property (assign) float nextFieldY;
@property (assign) bool canRemoveFields;
@property (nonatomic, strong) NSMutableArray *fields;
@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSMutableArray *autoIncs;
@property (nonatomic, strong) NSMutableArray *removeButtons;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (IBAction) addField;
- (IBAction) removeField:(id)sender;

- (void) removeAllFields;
- (void) insertField:(NSString *)fieldName presetValue:(NSString *)presetValue
             autoIncOn:(bool)autoIncOn;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void) reposition;
- (IBAction) hiddenButtonPress;
- (void) hideKeyboardBrute;

@end
