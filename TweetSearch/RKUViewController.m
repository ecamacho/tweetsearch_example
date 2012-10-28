//
//  RKUViewController.m
//  TweetSearch
//
//  Created by Erick Camacho on 24/10/12.
//  Copyright (c) 2012 Erick Camacho. All rights reserved.
//

#import "RKUViewController.h"

#import "AFNetworking.h"

@interface RKUViewController ()

@end

@implementation RKUViewController

@synthesize searchTextField;
@synthesize results;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender
{
  NSLog(@"Searching %@", self.searchTextField.text);
  [self.searchTextField resignFirstResponder];
  [self searchTwitterForString:self.searchTextField.text];
}

- (void)searchTwitterForString:(NSString *)searchString
{
  NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@",
                                     searchString]];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    NSLog(@"results %@", JSON);
    self.results = [JSON objectForKey:@"results"];    
    [self.tableView reloadData];
  } failure:nil];
  [operation start];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *MyIdentifier = @"TwitterResultCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:MyIdentifier];
  }
  cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
  cell.textLabel.numberOfLines = 4;
  NSDictionary *tweet = [self.results objectAtIndex:indexPath.row];
  cell.textLabel.text = [tweet objectForKey:@"text"];
  NSString *avatarURL = [tweet objectForKey:@"profile_image_url"];
  [cell.imageView setImageWithURL:[NSURL URLWithString:avatarURL]];
  cell.detailTextLabel.text = [tweet objectForKey:@"from_user"];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 100;
}
@end
