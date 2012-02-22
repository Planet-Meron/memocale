//
//  MemoViewController.h
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/24.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoView.h"
#import "AppDelegate.h"


@interface MemoViewController : UIViewController<UITextFieldDelegate,NSFetchedResultsControllerDelegate,MemoViewDelegate>{
    
    NSDate *date;
    IBOutlet UITextField *txf_memo;
    MemoView *memoView;
    UIView *view_Input;
}

@property(retain , nonatomic, strong)NSDate *date;


- (void)backCalendar_year;
- (void)plus_memo;
- (void)undo;
- (void)input_memo;
- (void)load;
- (void)createNewObject:(NSString *)memo save_x:(float)x save_y:(float)y;
- (void)createMemo:(NSString *)memo put_x:(float)x put_y:(float)y atIndex:(NSIndexPath *)atIndex load:(BOOL)yes_or_no;


//NSFetchRequestController
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
