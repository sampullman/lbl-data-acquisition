//
//  SavedFieldsView.h
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/20/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppManager.h"
#import "SavedFieldSet.h"

@class SavedFieldsView;

@protocol SavedFieldsViewDelegate <NSObject>
- (void)reportFieldSet:(SavedFieldsView *)fieldsView fieldSet:(NSMutableArray *)fieldSet;
@end

@interface SavedFieldsView : UIViewController 
        <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *savedFieldsView;
    AppManager * appManager;
    NSMutableArray *savedFieldSets;
    NSMutableArray *selectedCells;
}
@property (nonatomic, strong) IBOutlet UITableView *savedFieldsView;
@property (nonatomic, strong) AppManager *appManager;
@property (nonatomic, strong) NSMutableArray *savedFieldSets;
@property (nonatomic, strong) NSMutableArray *selectedCells;
@property (nonatomic, unsafe_unretained) id <SavedFieldsViewDelegate> delegate;

- (IBAction) selectFieldSets:(id)sender;
- (IBAction) deleteFieldSets:(id)sender;
- (IBAction) mergeFieldSets:(id)sender;
    
@end
