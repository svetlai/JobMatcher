//
//  ChatViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/3/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *messagesTableView;
@property NSInteger jobSeekerId;
@property NSInteger recruiterId;
@end
