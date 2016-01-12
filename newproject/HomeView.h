//
//  HomeView.h
//  newproject
//
//  Created by Mac-Mini-3 on 12/01/16.
//  Copyright © 2016 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "AddDetails.h"
#import "EditView.h"

@interface HomeView : UITableViewController

@property (nonatomic,strong) Database *database;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;
@property (strong, nonatomic) IBOutlet UITableView *tblUpcomingList;

- (IBAction)btnEdit:(id)sender;

@end
