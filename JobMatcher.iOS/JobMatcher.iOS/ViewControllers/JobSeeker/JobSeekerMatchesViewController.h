//
//  JobSeekerMatchesViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/2/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobSeekerMatchesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray* jobOfferMatches;
@property (weak, nonatomic) IBOutlet UITableView *jobSeekerMatchesTableView;

@end
