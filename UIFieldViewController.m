//
//  UIFieldViewController.m
//  lbl-iphone-app
//
//  Created by John Peterson on 1/19/13.
//  Copyright 2013 Berkeley Lab. All rights reserved.
//

#import "UIFieldViewController.h"
#import "PointsViewController.h"

@implementation UIFieldViewController

@synthesize mainView;
@synthesize inputFieldsModel;
@synthesize nextFieldY;
@synthesize canRemoveFields;
@synthesize fields;
@synthesize values;
@synthesize autoIncs;
@synthesize removeButtons;
@synthesize fetchedResultsController, managedObjectContext;
@synthesize appManager;

UITextField *textField;
UIAlertView *addFieldAlert;

- (IBAction) hiddenButtonPress {
	[self hideKeyboardBrute];
}

- (void) hideKeyboardBrute {
	for(int i=0;i<[[self values] count];i+=1) {
		[[[self values] objectAtIndex:i] resignFirstResponder];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	//[textField resignFirstResponder];
    if(addFieldAlert) {
        NSLog(@"alert tag: %d", addFieldAlert.tag);
        [addFieldAlert dismissWithClickedButtonIndex:1 animated:true];
        addFieldAlert = nil;
    }
    return YES;
}

- (void) reposition {
}

- (IBAction) addField {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Add Field" message:@"Field Name\n\n\n"
												   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
	[alert setTag:1];
    textField = [[UITextField alloc] init];
    [textField setDelegate:self];
    [textField setBackgroundColor:[UIColor whiteColor]];
    textField.borderStyle = UITextBorderStyleLine;
    textField.frame = CGRectMake(15, 75, 255, 30);
    textField.font = [UIFont fontWithName:@"ArialMT" size:20];
    textField.textAlignment = UITextAlignmentCenter;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    [textField becomeFirstResponder];
    addFieldAlert = alert;
    [alert addSubview:textField];
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if([alertView tag] == 1) {
		NSString* detailString = textField.text;
		//[textField release];
        NSLog(@"button ind: %d, strlen: %d", buttonIndex, [detailString length]);
		if ([detailString length] <= 0 || buttonIndex == 0) {
			return;
		}
		if (buttonIndex == 1) {
			[self.inputFieldsModel addField:detailString];
			[self insertField:detailString presetValue:@""];
			[self reposition];
		}
	}
}
	
- (void) insertField:(NSString *)fieldName presetValue:(NSString *)presetValue {
	UILabel *field = [[UILabel alloc] init];
	field.backgroundColor = [UIColor clearColor];
	field.text = fieldName;
	field.frame = CGRectMake(40.0, self.nextFieldY, 90.0, 40.0);
	[self.mainView addSubview:field];
    
    UIButton *autoInc = [[UIButton alloc] init];
    [autoInc addTarget:self action:@selector(checkboxButton:)
      forControlEvents:UIControlEventTouchUpInside];
    [autoInc setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [autoInc setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateSelected];
    [autoInc setImage:[UIImage imageNamed:@"checkbox-pressed.png"] forState:UIControlStateHighlighted];
    [autoInc setTag:[self.removeButtons count]];
    autoInc.frame = CGRectMake(140, self.nextFieldY, 40, 40);
    [self.mainView addSubview:autoInc];
    
	UITextField *value = [[UITextField alloc]init];
    value.borderStyle = UITextBorderStyleRoundedRect;
	[value setBorderStyle:UITextBorderStyleRoundedRect];
	value.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	value.frame = CGRectMake(190.0, self.nextFieldY, 110.0, 40.0);
	value.delegate = self;
	value.text = presetValue;
	[self.mainView addSubview:value];
	if(self.canRemoveFields) {
		UIButton *remove = [[UIButton alloc] init];
		
		[remove addTarget:self 
				   action:@selector(removeField:) 
		 forControlEvents:UIControlEventTouchUpInside];
		[remove setImage:[UIImage imageNamed:@"ex.png"] forState:UIControlStateNormal];
		[remove setTag:[self.removeButtons count]];
		remove.frame = CGRectMake(0.0, self.nextFieldY, 40.0, 40.0);
		[self.mainView addSubview:remove];
		[self.removeButtons addObject:remove];
	}
	[self.values addObject:value];
	[self.fields addObject:field];
    [self.autoIncs addObject:autoInc];
	CGRect frame = [self.mainView frame];
	frame.size.height += 50;
	self.mainView.frame = frame;
	self.nextFieldY += 50;
}


- (IBAction)checkboxButton:(id)sender{
    //int tag = [(UIButton *)sender tag];
    [sender setSelected:![sender isSelected]];
}
	
- (IBAction) removeField:(id)sender {
    self.nextFieldY = [AppManager getFieldYInit];
    int tag = [(UIButton *)sender tag];
    for(int i=0;i<[self.removeButtons count];i+=1) {
        [[self.values objectAtIndex:tag] removeFromSuperview];
        [[self.fields objectAtIndex:tag] removeFromSuperview];
        [[self.removeButtons objectAtIndex:tag] removeFromSuperview];
        [[self.autoIncs objectAtIndex:tag] removeFromSuperview];
    }
    [self.inputFieldsModel removeField:tag];
    [self.values removeObjectAtIndex:tag];
    [self.fields removeObjectAtIndex:tag];
    [self.autoIncs removeObjectAtIndex:tag];
    [self.removeButtons removeObjectAtIndex:tag];
    for(int i=0;i<[self.inputFieldsModel count];i+=1) {
        [[self.removeButtons objectAtIndex:i] setTag:i];
        UIButton *remove = [self.removeButtons objectAtIndex:i];
        UILabel *label = [self.fields objectAtIndex:i];
        UITextField *field = [self.values objectAtIndex:i];
        UIButton *autoInc = [self.autoIncs objectAtIndex:i];
        [self.mainView addSubview:remove];
        [self.mainView addSubview:field];
        [self.mainView addSubview:label];
        [self.mainView addSubview:autoInc];
        remove.frame = CGRectMake(0.0, self.nextFieldY, 40.0, 40.0);
        field.frame = CGRectMake(190.0, self.nextFieldY, 110.0, 40.0);
        label.frame = CGRectMake(40.0, self.nextFieldY, 90.0, 40.0);
        autoInc.frame = CGRectMake(140, self.nextFieldY, 40, 40);
        self.nextFieldY += 50.0;
    }
    [self reposition];
}
	
- (void)viewDidLoad {
	[super viewDidLoad];
	self.appManager = [AppManager getInstance];
    self.nextFieldY = [AppManager getFieldYInit]; 
	self.inputFieldsModel = [InputFieldsModel getInstance];
	self.values = [[NSMutableArray alloc] init];
	self.fields = [[NSMutableArray alloc] init];
    self.autoIncs = [[NSMutableArray alloc] init];
	self.removeButtons = [[NSMutableArray alloc] init];
}


@end
