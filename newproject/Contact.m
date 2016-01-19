//
//  Contact.m
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import "Contact.h"

@interface Contact ()

@end

@implementation Contact

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

- (IBAction)btnMail:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        //Email subject
        NSString *emailTitle = @"Test App";
        
        //Email content
        NSString *messageBody = @"Test app programming Result";
        
        //to address
        NSArray *toRecipents = [NSArray arrayWithObject:@"merlynferns@gmail.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        [mc setToRecipients:toRecipents];
        
        [self presentViewController:mc animated:YES completion:NULL];
        
    }
    else {
        
        [self displayAlert:@"User Account not logged in"];
        
    }
}

- (IBAction)btnCall1:(id)sender {
    
    [self canOpenUrl:@"tel://417-256-3131"];
}

- (IBAction)btnCall2:(id)sender {
    
    [self canOpenUrl:@"tel://888-485-9390"];
}

- (void) canOpenUrl :(NSString *)url {
    
    NSURL *callUrl = [NSURL URLWithString:url];
    
    if([[UIApplication sharedApplication] canOpenURL:callUrl])
    {
        [[UIApplication sharedApplication] openURL:callUrl];
    }
    else
    {
        //[self displayAlert:@"This Function is available in iPhone/iPad"];
    }
    
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail Cancelled");
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"Mail Saved");
            break;
            
        case MFMailComposeResultSent:
            NSLog(@"Mail Sent");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure : %@",[error localizedDescription]);
            break;
            
        default:
            break;
    }
    //close the mail interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) displayAlert: (NSString *) msg
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ALERT" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultaction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultaction];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
