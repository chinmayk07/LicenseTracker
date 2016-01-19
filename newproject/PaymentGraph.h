//
//  PaymentGraph.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "BEMSimpleLineGraphView.h"

@interface PaymentGraph : UIViewController <BEMSimpleLineGraphDataSource,BEMSimpleLineGraphDelegate>

@property (nonatomic,strong) Database *database;
@property (nonatomic,strong) NSMutableArray *arrayOfValues;
@property (nonatomic,strong) NSMutableArray *arrayOfDates;


@property (weak, nonatomic) IBOutlet UILabel *upDownPercent;
@property (weak, nonatomic) IBOutlet UILabel *timeSincePayment;
@property (weak, nonatomic) IBOutlet UILabel *daysmonthyearlbl;

- (IBAction)btn7Days:(id)sender;
- (IBAction)btn1Month:(id)sender;
- (IBAction)btn1Year:(id)sender;

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *paymentGraph;


@end
