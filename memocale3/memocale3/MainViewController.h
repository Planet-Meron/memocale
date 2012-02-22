//
//  MainViewController.h
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallendarView_year.h"
#import "MemoViewController.h"
#import "AppDelegate.h"

@interface MainViewController : UIViewController<CalendarViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

#pragma mark あとで消す
- (void)conform;

@end
