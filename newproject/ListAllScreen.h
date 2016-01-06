//
//  ListAllScreen.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface ListAllScreen : UITableViewController

@property (nonatomic,strong) Database *database;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;
@property (strong, nonatomic) IBOutlet UITableView *tblListDetails;


- (IBAction)btnEdit:(id)sender;
@end
