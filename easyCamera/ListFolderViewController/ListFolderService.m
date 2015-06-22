//
//  ListFolderService.m
//  easyCamera
//
//  Created by ATam on 6/12/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ListFolderService.h"
#import <CoreData/CoreData.h>
#import <MagicalRecord/MagicalRecord.h>
#import "FolderModel.h"

@interface ListFolderService ()<NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation ListFolderService

- (instancetype)init{
    self = [super init];
    if (self) {
        self.listModelFolder = [[NSArray alloc] init];
    }
    return self;
}

-(NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    }
    return _managedObjectContext;
}

- (void)fetchDatabase {
    // Initialize Fetch Request
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Folder"];
    
    // Add Sort Descriptors
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"createDate" ascending:YES]]];
    
    // Initialize Fetched Results Controller
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    // Configure Fetched Results Controller
    [self.fetchedResultsController setDelegate:self];
    
    // Perform Fetch
    NSError *error = nil;
    [self.fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Unable to perform fetch.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    NSArray *listFolder = [self.fetchedResultsController fetchedObjects];
    NSMutableArray *listFolderModel = [[NSMutableArray alloc] init];
    for (NSInteger index=0; index<listFolder.count; index++) {
        FolderModel *model = [[FolderModel alloc] initWithFolderEntity:[listFolder objectAtIndex:index]];
        [listFolderModel addObject:model];
    }
    self.listModelFolder = listFolderModel;
    if (self.didFinishFetchResults) {
        self.didFinishFetchResults();
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithArray:self.listModelFolder];
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            FolderModel *model = [[FolderModel alloc] initWithFolderEntity:anObject];
            [arrayTemp addObject:model];
            self.listModelFolder = arrayTemp;
            
            if (self.resultsChangeInsert) {
                self.resultsChangeInsert([NSArray arrayWithObject:newIndexPath]);
            }
            break;
        }
        case NSFetchedResultsChangeDelete: {
            if (self.resultsChangeDelete) {
                self.resultsChangeDelete([NSArray arrayWithObject:indexPath]);
            }
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            if (self.resultsChangeUpdate) {
                self.resultsChangeUpdate([NSArray arrayWithObject:indexPath]);
            }
            break;
        }
        case NSFetchedResultsChangeMove: {
            if (self.resultsChangeDelete) {
                self.resultsChangeDelete([NSArray arrayWithObject:indexPath]);
            }
            if (self.resultsChangeInsert) {
                self.resultsChangeInsert([NSArray arrayWithObject:newIndexPath]);
            }
            break;
        }
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (self.willChangeContent) {
        self.willChangeContent();
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.didChangeContent) {
        self.didChangeContent();
    }
}

- (void)addFolder {
    NSString *uuid = [[[NSUUID UUID] UUIDString] lowercaseString];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Folder *folder = [Folder MR_createEntityInContext:localContext];
        folder.uuid = uuid;
        folder.name = uuid;
        folder.createDate = [NSDate date];
    }];
}
@end
