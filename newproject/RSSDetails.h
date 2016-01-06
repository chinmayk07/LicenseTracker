//
//  RSSDetails.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSDetails : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong,nonatomic) NSArray *DetailModal;

@property (copy,nonatomic) NSString *url;

@property NSInteger selectedLink;

@property NSInteger lastlink;


- (IBAction)nextButton:(id)sender;

- (IBAction)previousBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *articleNo;

@end
