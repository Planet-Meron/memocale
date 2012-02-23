//
//  AppDelegate.h
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/22.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MemoTableViewController;
@class MemoViewController;

#import "MemoTableViewController.h"
#import "MemoViewController.h"

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

//@property (strong, nonatomic) MemoViewController *memoVc;
@property (strong, nonatomic) MemoTableViewController *memoTableViewController;

@end
