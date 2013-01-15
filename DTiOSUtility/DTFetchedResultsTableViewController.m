//
//  PBFetchedResultsTableViewController.m
//  
//
//  Created by Jonathan Nolen on 10/4/12.
//
//

#import "DTFetchedResultsTableViewController.h"

@implementation DTFetchedResultsTableViewController

@synthesize tableView;

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewDidUnload{
    [super viewDidUnload];
    self.tableView = nil;
}

-(void)reload{
    [super reload];
    [self.tableView reloadData];
}

-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)dataWillChange{
    [self.tableView beginUpdates];
}
-(void)dataInsertedAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
}
-(void)dataDeletedAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
}
-(void)dataChangedAtIndexPath:(NSIndexPath *)indexPath{
    [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
            atIndexPath:indexPath];
}
-(void)dataMovedFromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath{
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
}
-(void)dataDidChange{
    [self.tableView endUpdates];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self numberOfItemsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self numberOfSections];
}

@end
