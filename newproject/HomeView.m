//
//  HomeView.m
//  newproject
//
//  Created by Mac-Mini-3 on 12/01/16.
//  Copyright © 2016 Mac-Mini-3. All rights reserved.
//

#import "HomeView.h"
#import "HomeSearch.h"

@interface HomeView () <UISearchResultsUpdating>

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *searchResults;

@end

@implementation HomeView
{
    NSMutableArray *upcomingArrayName, *upcomingArrayDate;
    NSString *editNameHome, *editDateHome;
    int value;
}

- (Database *)database {
    if(!_database) {
        _database = [[Database alloc]init];
    }
    return _database;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.database createOrOpenDB];
    
    [self.tblUpcomingList reloadData];
    [self getResult];
    
    UINavigationController *search = [[self storyboard]instantiateViewControllerWithIdentifier:@"HomeSearchNavController"];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:search];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y
                                                       , self.searchController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tblUpcomingList reloadData];
    [self reloadInputViews];
    [self getResult];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tblUpcomingList reloadData];
    [self getResult];
}

- (void)getResult {
    
    NSDate *now = [[NSDate alloc]init];
    NSDateFormatter *formatedDate = [[NSDateFormatter alloc]init];
    [formatedDate setDateFormat:@"yyyy-MM-dd"];
    NSString *datechanged = [formatedDate stringFromDate:now];
    NSDate *weekLater = [now dateByAddingTimeInterval:+7*24*60*60];
    NSString *formatedWeekLaterDate = [formatedDate stringFromDate:weekLater];
    
    NSDictionary *homeDict = [[NSDictionary alloc]init];
    
    homeDict = [self.database listUpcomingDetails:datechanged fromDate:formatedWeekLaterDate];
    
    NSLog(@"HOMEDICT : %@",homeDict);
    
    NSArray *dictKeys = [homeDict allKeys];
    NSArray *dictValues = [homeDict allValues];
    if([dictKeys count]==0) {
        [self displayAlert:@"License List is Empty"];
        [self.tblUpcomingList reloadData];
    }
    else {
        upcomingArrayName = [[NSMutableArray alloc]initWithArray:dictValues];
        upcomingArrayDate = [[NSMutableArray alloc]initWithArray:dictKeys];
        NSLog(@"UPCOMINGARRAYIN HOME : %@",upcomingArrayName);
        NSLog(@"UPCOMINGARRAY NAME : %@",upcomingArrayDate);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [upcomingArrayName count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *identifier = @"Cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
     
     cell.textLabel.text = [upcomingArrayName objectAtIndex:indexPath.row];
     cell.detailTextLabel.text = [upcomingArrayDate objectAtIndex:indexPath.row];
     //NSLog(@"CELL TEXT : %@",cell.textLabel.text);
     //NSLog(@"CELL DESC : %@",cell.detailTextLabel.text);
     // Configure the cell...
     
     return cell;
 }

 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
     // Return NO if you do not want the specified item to be editable.
     return YES;
 }

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self displayAlert:@"Confirm Delete"];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        value = (int)indexPath.row;
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = self.searchController.searchBar.text;
    [self updateFilteredContentForName1:searchString];
    
    if(self.searchController.searchResultsController) {
        
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
        HomeSearch *hms = (HomeSearch *)navController.topViewController;
        
        hms.searchResults = self.searchResults;
        
        [hms.tableView reloadData];
    }
}

- (void)updateFilteredContentForName1:(NSString *)data1 {
    
    if(data1 == nil) {
        self.searchResults = [upcomingArrayName mutableCopy];
    }
    else {
        
        NSMutableArray *searchResults1 = [[NSMutableArray alloc]init];
        
        for(NSString *data in upcomingArrayName) {
            NSLog(@"DATA : %@",data);
            NSLog(@"ARRAYLIST : %@",upcomingArrayName);
            
            if([data containsString:[NSString stringWithFormat:@"%@",data1]]) {
                
                NSString *str = [NSString stringWithFormat:@"%@",data];
                [searchResults1 addObject:str];
                NSLog(@"SEARRCHHH : %@",searchResults1);
            }
            
            self.searchResults = searchResults1;
            NSLog(@"SEARCH RESULTS : %@",self.searchResults);
        }
    }
}

- (IBAction)btnEdit:(id)sender {
    
    NSString *title = self.editBtn.title;
    NSLog(@"%@",title);
    if([title isEqualToString:@"Edit"]) {
        [self.tblUpcomingList setEditing:YES animated:YES];
        self.tblUpcomingList.allowsSelectionDuringEditing = YES;
        self.editBtn.title = @"Done";
    }
    else {
        [self.tblUpcomingList setEditing:NO animated:YES];
        self.editBtn.title = @"Edit";
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.tblUpcomingList.editing) {
        
        EditView *ev = [self.storyboard instantiateViewControllerWithIdentifier:@"editView"];
        
        NSLog(@"INDEXPATH OF SELECTED ROW : %ld",(long)indexPath.row);
        editNameHome = [upcomingArrayName objectAtIndex:indexPath.row];
        editDateHome = [upcomingArrayDate objectAtIndex:indexPath.row];
        NSLog(@"EDIT NAME : %@",editNameHome);
        NSLog(@"EDIT DATE : %@",editDateHome);
        
        ev.selectedName = editNameHome;
        ev.selectedDate = editDateHome;
        
        [self presentViewController:ev animated:YES completion:nil];
        
    }
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)deletedata:(int)rownumber {
    
    NSLog(@"DELETE FUnCTION %d",rownumber);
    
    NSString *a = [upcomingArrayName objectAtIndex:rownumber];
    
    NSLog(@"NAME TO BE DELETED IS : %@",a);
    
    [self.database deleteData:a];
    [upcomingArrayName removeObjectAtIndex:rownumber];
    [self.tblUpcomingList reloadData];
    NSLog(@"OK Action %d",rownumber);
    
    
}


-(void) displayAlert: (NSString *) msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ALERT" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleaction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
        [self.tblUpcomingList reloadData];
        
        NSLog(@"Cancled Action");
    }];
    
    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        NSLog(@"OKAY ACTION");
        [self deletedata:value];
        
    }];
    
    [alert addAction:cancleaction];
    [alert addAction:okaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
