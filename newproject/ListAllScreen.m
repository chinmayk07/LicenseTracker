//
//  ListAllScreen.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "ListAllScreen.h"
#import "ListAllSearch.h"

@interface ListAllScreen () <UISearchResultsUpdating>

@property (nonatomic,strong) UISearchController *searchCOntroller1;
@property (nonatomic,strong) NSMutableArray *searchResults1;

@end

@implementation ListAllScreen
{
    NSMutableArray *arrayList, *arrayListDate;
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
    //arrayList = [self.database listDetails];
    
    [self displayResult];
    
    UINavigationController *searchList = [[self storyboard] instantiateViewControllerWithIdentifier:@"ListAllSearchNavController"];
    
    self.searchCOntroller1 = [[UISearchController alloc] initWithSearchResultsController:searchList];
    
    self.searchCOntroller1.searchResultsUpdater = self;
    
    self.searchCOntroller1.searchBar.frame = CGRectMake(self.searchCOntroller1.searchBar.frame.origin.x, self.searchCOntroller1.searchBar.frame.origin.y, self.searchCOntroller1.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchCOntroller1.searchBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tblListDetails reloadData];
    [self reloadInputViews];
    [self displayResult];
    
    NSLog(@"LIST ALL VIEW");
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tblListDetails reloadData];
    [self displayResult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayResult {
    
    NSDictionary *licenseList = [[NSDictionary alloc]init];
    licenseList = [self.database listDetails];
    NSLog(@"LICENSELISTINDICTIONARY : %@",licenseList);
    NSArray *dictKeys = [licenseList allKeys];
    NSArray *dictValues = [licenseList allValues];
    if([dictKeys count]==0) {
        
        [self displayAlert:@"License List is Empty"];
    }
    else {
        arrayList = [[NSMutableArray alloc]initWithArray:dictValues];
        arrayListDate = [[NSMutableArray alloc]initWithArray:dictKeys];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [arrayList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
    cell.textLabel.text = [arrayList objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [arrayListDate objectAtIndex:indexPath.row];
    
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
    if(self.tblListDetails.editing) {
        
    }
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = self.searchCOntroller1.searchBar.text;
    
    [self updateFilteredContentForNAme1:searchString];
    
    if(self.searchCOntroller1.searchResultsController) {
        
        UINavigationController *navcontrollerl = (UINavigationController *)self.searchCOntroller1.searchResultsController;
        
        ListAllSearch *las = (ListAllSearch *)navcontrollerl.topViewController;
        
        las.seachListResults = self.searchResults1;
        
        [las.tableView reloadData];        
    }
}

- (void)updateFilteredContentForNAme1:(NSString *)data2 {
    
    if(data2 == nil) {
        self.searchResults1 = [arrayList mutableCopy];
    }
    else {
        NSMutableArray *searchResults = [[NSMutableArray alloc]init];
        
        for(NSString *data in arrayList) {
            NSLog(@"DATA : %@",data);
            NSLog(@"ARRAYLIST : %@",arrayList);
            
            if([data containsString:[NSString stringWithFormat:@"%@",data2]]) {
                
                NSString *strn = [NSString stringWithFormat:@"%@",data];
                [searchResults addObject:strn];
                NSLog(@"SEARCHHHH : %@",searchResults);
            }
            
            self.searchResults1 = searchResults;
            NSLog(@"SEARCH RESULTS : %@",self.searchResults1);
        }
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
    
    NSString *title = self.btnEdit.title;
    NSLog(@"%@",title);
    if([title isEqualToString:@"Edit"]) {
        [self.tblListDetails setEditing:YES animated:YES];
        self.tblListDetails.allowsSelectionDuringEditing=YES;
        self.btnEdit.title = @"Done";
    }
    else {
        [self.tblListDetails setEditing:NO animated:YES];
        self.btnEdit.title = @"Edit";
    }    
}

- (void)deletedata:(int)rownumber {
    
    NSLog(@"DELETE FUnCTION %d",rownumber);
    
    NSString *a = [arrayList objectAtIndex:rownumber];
    
    NSLog(@"NAME TO BE DELETED IS : %@",a);
    
    [self.database deleteData:a];
    [arrayList removeObjectAtIndex:rownumber];
    [self.tblListDetails reloadData];
    NSLog(@"OK Action %d",rownumber);
    
    
}

-(void) displayAlert: (NSString *) msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ALERT" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSLog(@"OKAY ACTION");
        [self deletedata:value];              
        
    }];
    UIAlertAction *cancleaction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
        [self.tblListDetails reloadData];
        
        NSLog(@"Cancled Action");
    }];
    
    [alert addAction:defaultaction];
    [alert addAction:cancleaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


@end
