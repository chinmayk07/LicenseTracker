//
//  RSSList.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "RSSList.h"
#import "RSSDetails.h"
#import "TableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RSSList ()
{
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSMutableString *imagelink, *description, *contentLink;
    NSString *element, *resultString, *resultString1, *ActualUrl, *url1, *preMatch,*desc;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation RSSList
{
    NSCache *imageCache;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    feeds = [[NSMutableArray alloc]init];
    
    dispatch_async( dispatch_get_global_queue(0, 0), ^{
        
        [self.activityIndicator startAnimating];
        
        NSLog(@"NSURL : %@",self.urllink);
        NSURL *url = [NSURL URLWithString:self.urllink];
        parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        
        [parser setDelegate:self];
        [parser setShouldResolveExternalEntities:NO];
        //[parser parse];
        
        // call the result handler block on the main queue (i.e. main thread) */
        dispatch_async( dispatch_get_main_queue(), ^{
            // running synchronously on the main thread now -- call the handler
            [parser parse];
            [self.activityIndicator stopAnimating];
        });
    });

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    RSSDetails *dvc = segue.destinationViewController;
    
    if ([[segue identifier] isEqualToString:@"RssDetails"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey:@"link"];
        NSInteger row = indexPath.row;
        NSInteger last = feeds.count;
        
        NSString *data =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];      
        
        dvc.DetailModal = [feeds copy];
        dvc.selectedLink = row;        
        dvc.url = data;
        dvc.lastlink = last;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return feeds.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"DID SELECT : %ld",(long)[indexPath row]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = (int)[indexPath row];
    
    /*for(int i=0; i<row ; i++) {
     NSLog(@"NAMESATINDEX : %@ ",[self.tableView ])
     }*/
    
    NSLog(@" ROW : %d",row);
    
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.cellTitle.text = [[feeds objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.cellDescription.text = [[feeds objectAtIndex:indexPath.row]objectForKey:@"description"];
    
    //NSLog(@"DESCRIPTION : %@",cell.cellDescription.text);
    
    //fetching image from URL
    NSURL *img = [NSURL URLWithString:[[feeds objectAtIndex:indexPath.row]objectForKey:@"imagelink"]];
    NSData *data = [NSData dataWithContentsOfURL:img];
    UIImage *image = [UIImage imageWithData:data];
    
    
    //SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //[manager downloadImageWithURL:img options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
       // if (image) {
            
            //cell.cellImageView.image = image;
       // }
    //}];
    
    
    if(![[img absoluteString] isEqualToString:@""]) {
        cell.cellImageView.image = image;
        //[cell.cellImageView sd_setImageWithURL:img placeholderImage:[UIImage imageNamed:@"NoImage"] options:SDWebImageRefreshCached];
    }
    else
    {
        cell.cellImageView.image = [UIImage imageNamed:@"NoImage"];
    }
    return cell;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if([element isEqualToString:@"item"]) {
        
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        imagelink = [[NSMutableString alloc] init];
        contentLink = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        resultString = [[NSString alloc] init];
        ActualUrl = [[NSString alloc] init];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
        
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.:/-"] invertedSet];
        resultString = [[link componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        //NSLog (@"Result: %@", resultString);
    }
    else if ([element isEqualToString:@"content:encoded"]) {
        [contentLink appendString:string];
        if([contentLink rangeOfString:@"<img"].location != NSNotFound )
        {
            //NSLog(@"Contains : %@",contentLink);
            NSRange firstRange = [contentLink rangeOfString:@"src=\""];
            NSRange secondRange = [[contentLink substringFromIndex:firstRange.location] rangeOfString:@"alt"];
            NSString *hashtagWord = [contentLink substringWithRange:NSMakeRange(firstRange.location, secondRange.location)];
            //NSLog(@"hashtagWord: %@", hashtagWord);
            
            NSString *match = @"src=\"";
            NSString *postMatch;
            
            NSScanner *scanner = [NSScanner scannerWithString:hashtagWord];
            [scanner scanString:match intoString:nil];
            postMatch = [hashtagWord substringFromIndex:scanner.scanLocation];
           // NSLog(@"POSTMATCHHHHHHHH %@",postMatch);
            
            
            /*NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.:/-"] invertedSet];
             resultString1 = [[postMatch componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
             NSLog (@"Result 1: %@", resultString1);*/
            
            
            ActualUrl = [postMatch stringByAppendingString:@".jpg"];
            //ActualUrl = hashtagWord;
            //NSLog(@"HSFJKAHASHDKHASKHDKJASH %@",ActualUrl);
            
            NSString *match1 = @"\"";
            NSString *preMatch1;
            
            NSScanner *scanner1 = [NSScanner scannerWithString:ActualUrl];
            [scanner1 scanUpToString:match1 intoString:&preMatch1];
            
            //NSLog(@"PREMATCH : %@",preMatch1);
            ActualUrl = [NSString stringWithFormat:@"%@",preMatch1];
            
            //NSLog(@"URL 1 : %@",url1);
            
         
        }
    }
    else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
        
        //NSLog(@"DESCRIPTION STRING : %@",description);
        
        
    }
}


-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:resultString forKey:@"link"];
        
        // NSLog(@"URL 1 : %@",url1);
        
        //[item setObject:contentLink forKey:@"content:encoded"];
        [item setObject:ActualUrl forKey:@"imagelink"];
        [item setObject:description forKey:@"description"];
        
        //NSLog(@"RSS FEED :%@",item);
        [feeds addObject:[item copy]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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

@end
