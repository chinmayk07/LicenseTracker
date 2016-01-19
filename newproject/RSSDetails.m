//
//  RSSDetails.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "RSSDetails.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface RSSDetails ()
{
    NSInteger rowvalue,rowvalue1,rowvalue2,rowvalue3;
    NSArray *linkdetails;
    NSArray *REQUIREDDATA;
    NSString *asdfgh;
    NSURL *myURL;
    NSURLRequest *request;
    NSDictionary *rsslist;
}

@end

@implementation RSSDetails

- (void)viewDidLoad {
    [super viewDidLoad];// Do any additional setup after loading the view.
    
    //NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    //myURL = [NSURL URLWithString:[self.url stringByAddingPercentEncodingWithAllowedCharacters:set]];
    //request = [NSURLRequest requestWithURL:myURL];
    //[self.webView loadRequest:request];
    
    rowvalue = self.selectedLink;
    linkdetails = self.DetailModal;
    
    [self assignData:rowvalue];
        
    rowvalue1 = rowvalue +1;
    NSLog(@"ROWVALUE : %ld",(long)rowvalue);
    
    NSLog(@"SELECTED ROW DETAILS %@",[linkdetails objectAtIndex:rowvalue]);
    
    //NSLog(@"ARRAY %lu",(unsigned long)linkdetails.count);
    self.articleNo.text = [NSString stringWithFormat:@"Article %ld / %lu ",(long)rowvalue1,(unsigned long)[linkdetails count]];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
   // [self.webView addGestureRecognizer:swipeLeft];
    //[self.webView addGestureRecognizer:swipeRight];
}

/*- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_webView stopLoading];
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextButton:(id)sender {
    
    
    /* NSLog(@"Before NEXT : %ld",(long)rowvalue1);
     rowvalue2=rowvalue1 +1;
     NSLog(@"After NEXT : %ld",(long)rowvalue2);
     
     REQUIREDDATA = [linkdetails objectAtIndex:rowvalue1];
     
     asdfgh = [REQUIREDDATA valueForKey:@"link"];
     NSLog(@"REQUIRED  : %@",asdfgh);
     
     NSURL *myURL = [NSURL URLWithString:[asdfgh stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
     [self.webView loadRequest:request];
     
     
     NSLog(@"REQUIRED DATA : %@",REQUIREDDATA);
     self.articleNo.text = [NSString stringWithFormat:@"Article %ld ",(long)rowvalue2];*/
    
    [self next];
}

- (IBAction)previousBtn:(id)sender {
    
    
    /*NSLog(@"Before PREV : %ld",(long)rowvalue1);
     rowvalue2 = rowvalue1 - 1;
     rowvalue3 = rowvalue1 - 2;
     NSLog(@"After PREV : %ld",(long)rowvalue3);
     REQUIREDDATA = [linkdetails objectAtIndex:rowvalue3];
     
     asdfgh = [REQUIREDDATA valueForKey:@"link"];
     
     NSURL *myURL = [NSURL URLWithString:[asdfgh stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
     NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
     [self.webView loadRequest:request];
     
     NSLog(@"REQUIRED DATA : %@",REQUIREDDATA);
     
     self.articleNo.text = [NSString stringWithFormat:@"Article %ld ",(long)rowvalue2];*/
    
    [self previous];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        //[self.detailImageView goForward];
        
        /*rowvalue2 = rowvalue1 + 1;
         NSLog(@"%ld",(long)rowvalue);
         
         REQUIREDDATA = [linkdetails objectAtIndex:rowvalue1];
         
         asdfgh = [REQUIREDDATA valueForKey:@"link"];
         NSLog(@"REQUIRED  : %@",asdfgh);
         
         NSURL *myURL = [NSURL URLWithString:[asdfgh stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
         [self.webView loadRequest:request];
         
         NSLog(@"REQUIRED DATA : %@",REQUIREDDATA);
         self.articleNo.text = [NSString stringWithFormat:@"Article %ld ",(long)rowvalue2];*/
        
        [self next];
    
    }
    
    if(swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        //[self.detailImageView goBack];
        
        /*rowvalue2 = rowvalue1 - 1;
         rowvalue3 = rowvalue1 - 2;
         NSLog(@"%ld",(long)rowvalue);
         REQUIREDDATA = [linkdetails objectAtIndex:rowvalue3];
         
         asdfgh = [REQUIREDDATA valueForKey:@"link"];
         
         NSURL *myURL = [NSURL URLWithString:[asdfgh stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
         NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
         [self.webView loadRequest:request];
         
         
         
         NSLog(@"REQUIRED DATA : %@",REQUIREDDATA);
         
         self.articleNo.text = [NSString stringWithFormat:@"Article %ld ",(long)rowvalue2];*/
        
        [self previous];
        
    }
}

- (void)next {
    
    NSLog(@"Before NEXT : %ld",(long)rowvalue);
    rowvalue=rowvalue +1;
    rowvalue2 = rowvalue +1;
    NSLog(@"After NEXT : %ld",(long)rowvalue);
    NSLog(@"After NEXT new : %ld",(long)rowvalue2);
    
    if(rowvalue >= [self lastlink]) {
        [self displayAlert:@"This is the Last Article"];
    }
    else
    {
        
        
        [self assignData:rowvalue];
        
        NSLog(@"REQUIRED DATA : %@",REQUIREDDATA);
        self.articleNo.text = [NSString stringWithFormat:@"Article %ld / %lu ",(long)rowvalue2, (unsigned long)[linkdetails count]];
    }
}

- (void)assignData:(NSInteger)row {
    
    linkdetails = self.DetailModal;
    
    NSString *string = [linkdetails[row] objectForKey:@"description"];
    NSString *string1 = [linkdetails[row] objectForKey:@"Publish Date"];
    NSString *string2 = [linkdetails[row] objectForKey:@"title"];
    NSString *string3 = [linkdetails[row] objectForKey:@"imagelink"];
    
    NSLog(@"DESCRIPTION : %@",string);
    NSLog(@"Publish Date: %@",string1);
    NSLog(@"Title : %@",string2);
    NSLog(@"ImageLink : %@",string3);

    
    self.articleTitle.text = string2;
    self.articleDescription.text = string;
    self.articleDate.text = string1;
    
    NSURL *img = [NSURL URLWithString:string3];
   
    if([string3 isEqualToString:@""]) {
        
        self.articleImage.image = [UIImage imageNamed:@"NoImage"];
        
    }
    else {
        [self.articleImage sd_setImageWithURL:img placeholderImage:[UIImage imageNamed:@"NoImage"] options:SDWebImageRefreshCached];
    }
}

- (void)previous {
    
    NSLog(@"Before PREV : %ld",(long)rowvalue);
    rowvalue = rowvalue - 1;
    NSLog(@"After PREV : %ld",(long)rowvalue);
    rowvalue2 = rowvalue + 1;
    
    
    if(rowvalue < 0) {
        [self displayAlert:@"This is the First Article"];
    }
    else
    {
        [self assignData:rowvalue];
        
        NSLog(@"REQUIRED DATA : %@",REQUIREDDATA);
        
        self.articleNo.text = [NSString stringWithFormat:@"Article %ld / %lu",(long)rowvalue2,(unsigned long)[linkdetails count]];
        
    }
    
}

-(void) displayAlert: (NSString *) msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ALERT" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deallocate {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    //[self.webView loadHTMLString:@"" baseURL:nil];
    //[self.webView stopLoading];
    //self.webView.delegate = nil;
    //NSLog(@"RSS Details deallocation");
}


@end
