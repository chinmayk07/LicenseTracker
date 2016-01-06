//
//  LogView.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Database.h"

@interface LogView : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) Database *database;

@property (weak, nonatomic) IBOutlet UILabel *lblcurrentDate;
@property (weak, nonatomic) IBOutlet UITableView *tblLogView;

- (IBAction)btnLog:(id)sender;

@end
