//
//  MemoTableViewController.h
//  memocale3
//
//  Created by 石橋 弦樹 on 12/01/04.
//  Copyright (c) 2012年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "AppDelegate.h"

@interface MemoTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>

@property(nonatomic, retain)NSDate *date;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
