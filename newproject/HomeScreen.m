//
//  HomeScreen.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "HomeScreen.h"
#import "HomeSearch.h"

@interface HomeScreen () <UISearchResultsUpdating>

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *searchResults;

@end

@implementation HomeScreen
{
    NSMutableArray *upComingArray;
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
    //upComingArray = [self.database listDetails];
    
    //[self.tblUpcomingList reloadData];
    
    NSLog(@"UPCOMING ARRAY : %@",upComingArray);
    [self getDate];
    
    UINavigationController *searchHome = [[self storyboard]instantiateViewControllerWithIdentifier:@"HomeSearchNavController"];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchHome];
    
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x,self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self getDate];
    [self.tblUpcomingList reloadData];
    [self reloadInputViews];
    
    NSLog(@"HOME VIEW");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getDate
{
    NSDate *now = [[NSDate alloc]init];
    NSDateFormatter *formatedDate = [[NSDateFormatter alloc]init];
    [formatedDate setDateFormat:@"yyyy-MM-dd"];
    NSString *datechanged = [formatedDate stringFromDate:now];
    NSDate *weekLater = [now dateByAddingTimeInterval:+7*24*60*60];
    NSString *formatedWeekLaterDate = [formatedDate stringFromDate:weekLater];
    
    upComingArray = [[NSMutableArray alloc]init];
    
    upComingArray = [self.database listUpcomingDetails: datechanged fromDate:formatedWeekLaterDate];
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = self.searchController.searchBar.text;
    
    [self updateFilteredContentForName:searchString];
    
    if(self.searchController.searchResultsController) {
        
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
        
        HomeSearch *vc = (HomeSearch *)navController.topViewController;
        
        vc.searchResults = self.searchResults;
        
        [vc.tableView reloadData];
    }   
}

- (void)updateFilteredContentForName:(NSString *)data {
    
    if (data == nil) {
        
        self.searchResults = [upComingArray mutableCopy];
    }
    else {
        NSMutableArray *searchResults = [[NSMutableArray alloc]init];
        
        for(NSString *data1 in upComingArray) {
            NSLog(@"DATA 1 : %@",data1);
            NSLog(@"ARRAY : %@",upComingArray);
            
            if([data1 containsString:[NSString stringWithFormat:@"%@",data]]) {
                NSString *strn = [NSString stringWithFormat:@"%@", data1];
                [searchResults addObject:strn];
                NSLog(@"SEARCHHHH : %@",searchResults);
            }
            
            self.searchResults = searchResults;
            NSLog(@"SEARCH RESULTS : %@",self.searchResults);
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return[upComingArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Database *aPerson = [upComingArray objectAtIndexedSubscript:indexPath.row];
    
    cell.textLabel.text = aPerson.name;
    cell.detailTextLabel.text = aPerson.expiryDate;
    
    NSLog(@"Name = %@",aPerson.name);
    NSLog(@"Expiry = %@",aPerson.expiryDate);
    
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self displayAlert:@"Confirm Delete"];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        value = (int)indexPath.row;
    }  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.tblUpcomingList.editing) {
        
    }
}


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

-(void) displayAlert: (NSString *) msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ALERT" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        Database *a = [upComingArray objectAtIndex:value];
        [self.database deleteData:a.name];
        [upComingArray removeObjectAtIndex:value];
        [self.tblUpcomingList reloadData];
        NSLog(@"OK Action %d",value);

        
    }];
    UIAlertAction *cancleaction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
        [self.tblUpcomingList reloadData];
        
        NSLog(@"Cancled Action");
    }];
    
    [alert addAction:defaultaction];
    [alert addAction:cancleaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
