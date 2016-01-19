//
//  RssView.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "RssView.h"
#import "RSSList.h"

@interface RssView ()
{
    NSString *segueIdentifier, *link;
}

@end

@implementation RssView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//RssDetails

- (IBAction)click:(id)sender {
    
    segueIdentifier = [NSString stringWithFormat:@"RssLists"];
    
    switch ([sender tag]) {
        case 1:
            NSLog(@"Button 1 pressed");
            link = [NSString stringWithFormat:@"http://www.ozarkareanetwork.com/category/app-feed/feed/rss2"];
            break;
            
        case 2:
            NSLog(@"Button 2 pressed");
            link = [NSString stringWithFormat:@"http://www.ozarkareanetwork.com/category/sports/feed/rss2"];
            [self performSegueWithIdentifier:segueIdentifier sender:self];
            break;
            
        case 3:
            NSLog(@"Button 3 pressed");
            link = [NSString stringWithFormat:@"http://www.ozarkareanetwork.com/category/obits/feed/rss2"];
            [self performSegueWithIdentifier:segueIdentifier sender:self];
            break;
            
        case 4:
            NSLog(@"Button 4 pressed");
            link = [NSString stringWithFormat:@"http://www.ozarkareanetwork.com/category/birthdays-anniversaries/feed/rss2"];
            [self performSegueWithIdentifier:segueIdentifier sender:self];
            break;
            
        default:
            break;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    RSSList *rssvc = segue.destinationViewController;
    NSLog(@"%@",segue.identifier);
    
    if([[segue identifier]isEqualToString:segueIdentifier]) {
        
        NSString *string = link;
        
        NSString *data = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        rssvc.urllink = data;
    }
    
}

@end
