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

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        _hasData = NO;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
        _hasData = NO;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
}

-(void)viewDidUnload{
    [super viewDidUnload];
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
    
    self.hasData = (self.fetchedResultsController.sections.count > 0);
}

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self dataWillChange];
}

-(void)controller:(NSFetchedResultsController *)controller
 didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
          atIndex:(NSUInteger)sectionIndex
    forChangeType:(NSFetchedResultsChangeType)type{
    
    switch(type){
        case NSFetchedResultsChangeInsert:
            [self sectionInserted:sectionIndex];
            break;
        case NSFetchedResultsChangeDelete:
            [self sectionDeleted:sectionIndex];
            break;
    }
    
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
    self.hasData = (BOOL)(self.fetchedResultsController.sections.count > 0);
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
-(void)sectionInserted:(NSUInteger)sectionIndex{
}
-(void)sectionDeleted:(NSUInteger)sectionIndex{    
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

-(void)reload{
    [self setupFetchedResultsController];
}

-(void)setHasData:(BOOL)hasData{
    if (_hasData != hasData) {
        _hasData = hasData;
        [self hasDataChanged];
    }
}
-(void)hasDataChanged{
    
}
@end
