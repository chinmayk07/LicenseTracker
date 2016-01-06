//
//  HomeScreen.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "AddDetails.h"
#import "EditView.h"

@interface HomeScreen : UITableViewController

@property (nonatomic,strong) Database *database;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (strong, nonatomic) IBOutlet UITableView *tblUpcomingList;

- (IBAction)btnEdit:(id)sender;

@end
