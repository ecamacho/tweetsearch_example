//
//  RKUViewController.h
//  TweetSearch
//
//  Created by Erick Camacho on 24/10/12.
//  Copyright (c) 2012 Erick Camacho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKUViewController : UIViewController <UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *results;

- (IBAction)search:(id)sender;

@end
