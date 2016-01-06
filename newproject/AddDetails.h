//
//  AddDetails.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"

@interface AddDetails : UIViewController

@property (nonatomic,strong) Database *database;

@property (weak, nonatomic) IBOutlet UITextField *licenceName;

@property (weak, nonatomic) IBOutlet UILabel *expiryDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)dateChanged:(id)sender;

- (IBAction)btnSave:(id)sender;

- (IBAction)btnCancel:(id)sender;



@end
