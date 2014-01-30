//
//  DTFetchedResultsTableViewController.h
//  
//
//  Created by Jonathan Nolen on 10/4/12.
//
//

#import "DTFetchedResultsBasedViewController.h"

@interface DTFetchedResultsTableViewController : DTFetchedResultsBasedViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
