//
//  EditView.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface EditView : UIViewController

@property (nonatomic,strong) Database *database;

@property (weak, nonatomic) IBOutlet UITextField *editName;

@property (weak, nonatomic) IBOutlet UILabel *editDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *editDatePicker;

@property NSString *selectedName;

@property NSString *selectedDate;

- (IBAction)editDateChanged:(id)sender;

- (IBAction)btnUpdate:(id)sender;

- (IBAction)btnCancel:(id)sender;

@end
