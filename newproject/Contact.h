//
//  Contact.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface Contact : UIViewController <MFMailComposeViewControllerDelegate>

- (IBAction)btnMail:(id)sender;
- (IBAction)btnCall1:(id)sender;
- (IBAction)btnCall2:(id)sender;

@end
