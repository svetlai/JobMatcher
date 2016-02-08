//
//  RecruiterMatchesViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/5/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruiterMatchesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray* recruiterMatches;
@property (weak, nonatomic) IBOutlet UITableView *recruiterMatchesTableView;


@end
