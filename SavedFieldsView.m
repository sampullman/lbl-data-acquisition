//
//  SavedFieldsView.m
//  lbl-iphone-app
//
//  Created by John  Peterson on 2/20/13.
//  Copyright (c) 2013 Berkeley Lab. All rights reserved.
//

#import "SavedFieldsView.h"

@implementation SavedFieldsView

@synthesize appManager;
@synthesize delegate;
@synthesize savedFieldsView;
@synthesize savedFieldSets;
@synthesize selectedCells;


- (void) resetList {
    self.selectedCells = [[NSMutableArray alloc] init];
    for(int i=0;i<[self.savedFieldSets count];i+=1) {
        [self.selectedCells addObject:[NSNumber numberWithBool:false]];
    }
    [self.savedFieldsView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"number of saved field sets: %d", [self.savedFieldSets count]);
    return [self.savedFieldSets count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    bool notSelected = cell.accessoryType == UITableViewCellAccessoryNone;
    if (notSelected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.selectedCells replaceObjectAtIndex:indexPath.row
                        withObject:[NSNumber numberWithBool:notSelected]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"SavedFieldsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        //cell.accessoryType = UITableViewCellAccessoryNone;
    }
    SavedFieldSet *fieldSet = [self.savedFieldSets objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.appManager getFieldSetString:fieldSet];
    
    return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView 
         accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryNone;
}

- (NSMutableArray *) getSelected {
    NSMutableArray *selected = [[NSMutableArray alloc] init];
    for(int i=0;i<[self.selectedCells count];i+=1) {    
        NSNumber *sel = [self.selectedCells objectAtIndex:i];
        if([sel boolValue]) {
            [selected addObject:[self.savedFieldSets objectAtIndex:i]];
        }
    }
    NSLog(@"selected rows: %d", [selected count]);
    return selected;
}

- (IBAction) selectFieldSets:(id)sender {
    NSMutableArray *selected = [self getSelected];
    NSMutableArray *fieldSet = [[NSMutableArray alloc] init];
    if([selected count] > 0) {
        for(int i=0;i<[selected count];i+=1) {
            SavedFieldSet *set = [selected objectAtIndex:i];
            NSArray *fields = [[set fields] allObjects];
            for(int j=0;j<[fields count];j+=1) {
                [fieldSet addObject:[fields objectAtIndex:j]];
            }
        }
        [self.delegate reportFieldSet:self fieldSet:fieldSet];
    }
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction) deleteFieldSets:(id)sender {
    NSMutableArray *selected = [self getSelected];
    for(int i=0;i<[selected count];i+=1) {
        SavedFieldSet *set = [selected objectAtIndex:i];
        [self.appManager deleteFieldSet:set];
        [self.savedFieldSets removeObject:set];
    }
    [self resetList];
}

- (IBAction) mergeFieldSets:(id)sender {
    NSMutableArray *selected = [self getSelected];
    if([selected count] > 0) {
        SavedFieldSet *merger = [selected objectAtIndex:0];
        for(int i=1;i<[selected count];i+=1) {
            SavedFieldSet *set = [selected objectAtIndex:i];
            NSArray *fields = [[set fields] allObjects];
            for(int j=0;j<[fields count];j+=1) {
                [merger addFieldsObject:[fields objectAtIndex:j]];
            }
            [self.appManager deleteFieldSet:set];
            [self.savedFieldSets removeObject:set];
        }
        [self resetList];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.appManager = [AppManager getInstance];
    self.savedFieldSets = [self.appManager getFieldSets];
    [self resetList];
	
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Saved Fields";
}

@end
