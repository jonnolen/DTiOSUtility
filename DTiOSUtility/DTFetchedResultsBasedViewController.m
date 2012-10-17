//
//  PBFetchedResultsBasedViewController.m
//  
//
//  Created by Jonathan Nolen on 10/4/12.
//
//

#import "DTFetchedResultsBasedViewController.h"

@interface DTFetchedResultsBasedViewController()
-(void)setupFetchedResultsController;
-(void)initializeFetchedResultsController;
@end

@implementation DTFetchedResultsBasedViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupFetchedResultsController];
}

-(void)viewDidUnload{
    [super viewDidUnload];
    self.fetchedResultsController = nil;
}

-(void)setupFetchedResultsController{
    [self initializeFetchedResultsController];
    [self cleanFetchedResultsControllerCache];
    [self fetchResults];
}

-(void)initializeFetchedResultsController{
    self.fetchedResultsController = [self createFetchedResultsController];
    self.fetchedResultsController.delegate = self;
}

-(NSFetchedResultsController *)createFetchedResultsController{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(void)cleanFetchedResultsControllerCache{
    if (self.fetchedResultsController.cacheName){
        [NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
    }
}

-(void)fetchResults{
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error){
        NSLog(@"error: %@",error);
    }
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self dataWillChange];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self dataInsertedAtIndexPath:newIndexPath];
            break;
        case NSFetchedResultsChangeDelete:
            [self dataDeletedAtIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeUpdate:
            [self dataChangedAtIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self dataMovedFromIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self dataDidChange];
}
-(void)dataWillChange{
}
-(void)dataInsertedAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)dataDeletedAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)dataChangedAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)dataMovedFromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath{
}
-(void)dataDidChange{
}

-(NSUInteger)numberOfSections{
    return [self.fetchedResultsController.sections count];
}

-(NSUInteger)numberOfItemsInSection:(NSInteger)section{
    return [[self.fetchedResultsController.sections objectAtIndex:section] numberOfObjects];
}

-(id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

@end
