//
//  RSSList.h
//  newproject
//
//  Created by Mac-Mini-3 on 28/12/15.
//  Copyright © 2015 Mac-Mini-3. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSDetails.h"

@interface RSSList : UITableViewController <NSXMLParserDelegate>


@property (nonatomic,strong) NSString *urllink;
@end
