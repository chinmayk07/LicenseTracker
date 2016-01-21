//
//  EditView.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "EditView.h"

@interface EditView ()

@end

@implementation EditView
{
    NSString *name, *expiryDate;
    NSString *datechanged;
}

- (Database *)database {
    if(!_database) {
        _database = [[Database alloc]init];
    }
    return _database;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.database createOrOpenDB];
    
    name = self.selectedName;
    expiryDate = self.selectedDate;
    NSLog(@"DATE : %@",expiryDate);
    
    NSDateFormatter *datef = [[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateNEW = [datef dateFromString:expiryDate];
    [self.editDatePicker setDate:dateNEW];
    
    
    self.editName.text = name;
    self.editDate.text = expiryDate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.editName endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) Notify {
    NSDate *fireDate = [[NSDate alloc]init];
    fireDate = self.editDatePicker.date;
    NSLog(@"The orginal date is %@",fireDate);
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *dateComp = [cal components:(NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond)
                                        fromDate:fireDate];
    [dateComp setHour: -24];
    [dateComp setMinute:0];
    [dateComp setSecond:+20];
    
    NSDate *dd = [cal dateByAddingComponents:dateComp toDate:fireDate options:0];
    NSLog(@"The modified date is %@",dd);
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setFireDate:dd];
    
    NSString *alert1 = @"HI ";
    alert1 = [alert1 stringByAppendingString:self.editName.text];
    alert1 = [alert1 stringByAppendingString:@" Will Expire tommorrow"];
    [notification setAlertBody:alert1];
    [notification setAlertAction:@"View in App"];
    
    NSUInteger nextBadgeNumber = [[[UIApplication sharedApplication]scheduledLocalNotifications]count]+1;
    [notification setApplicationIconBadgeNumber:nextBadgeNumber];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    NSString *display = [NSDateFormatter localizedStringFromDate:dd dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterFullStyle];
    self.editDate.text = display;
    
}



- (IBAction)editDateChanged:(id)sender {
    
    NSDateFormatter *datef = [[NSDateFormatter alloc]init];
    [datef setDateFormat:@"yyyy-MM-dd"];
    datechanged = [datef stringFromDate:self.editDatePicker.date];
    self.editDate.text = datechanged;
}

- (IBAction)btnUpdate:(id)sender {
    
    if([self.editName.text isEqualToString:@""])
    {
        [self displayAlert:@"Licence Name is Mandatory..!"];
    }
    else
    {
        NSDate *now = [NSDate date];
        NSComparisonResult result = [now compare:self.editDatePicker.date];
        
        if(result == 1)
        {
            [self displayAlert:@"Invalid Expiry Date"];
        }
        else
        {
            [self Notify];
            
            int reslt = [self.database updateData:name uLicenseName:self.editName.text uexpiryDate:datechanged];
            if(reslt == 1) {
                
                NSLog(@"UPDATEING NAME : %@ ",self.editName.text);
                NSLog(@"UPDATING DATE : %@ ",self.editDate.text);
                
                [self displayAlert:@"Data Updated Successfully"];
                self.editName.text=@"";
                self.editDate.text=@"";
                [self.editDatePicker setDate:[NSDate date]];
            }
        }
    }

    
}

- (IBAction)btnCancel:(id)sender {
    
    self.editName.text = [NSString stringWithFormat:@""];
    self.editDate.text = [NSString stringWithFormat:@""];
    [self.tabBarController setSelectedIndex:1];
    
    //EditView *ev = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeScreenView"];
    
    //[self presentViewController:ev animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) displayAlert: (NSString *) msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ALERT" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    
    }];
    
    [alert addAction:defaultaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
