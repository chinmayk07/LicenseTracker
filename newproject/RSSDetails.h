//
//  RSSDetails.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSDetails : UIViewController

@property (strong,nonatomic) NSArray *DetailModal;

@property (copy,nonatomic) NSString *url;

@property NSInteger selectedLink;

@property NSInteger lastlink;


@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleDate;
@property (weak, nonatomic) IBOutlet UITextView *articleDescription;


- (IBAction)nextButton:(id)sender;

- (IBAction)previousBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *articleNo;

@end
