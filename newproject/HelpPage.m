//
//  HelpPage.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "HelpPage.h"
#import "TOWebViewController.h"

@interface HelpPage ()

@end

@implementation HelpPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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

- (IBAction)btnHelp:(id)sender {
    
    
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.facebook.com/sjinnovation"]];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    //NSURL *URL = [NSURL URLWithString:@"https://www.facebook.com/sjinnovation"];
    
    //OPENING IN SAFARI BROWSER
    //if([[UIApplication sharedApplication] canOpenURL:URL]) {
    //    [[UIApplication sharedApplication] openURL:URL];
    //}
}
@end
