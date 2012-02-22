//
//  MemoViewController.m
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/24.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import "MemoViewController.h"

#import "Action.h"

@implementation MemoViewController
@synthesize date=date;



//fetchedRequestController
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //Property背景
        UIColor *backpatternImage = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"square-paper.png"]];
        self.view.backgroundColor = backpatternImage;
        [backpatternImage release];

        //生成
        NSLog(@"toota self");
        //txf_memo = [[UITextField alloc] initWithFrame:CGRectMake(view_Input.bounds.origin.x+10.0f, view_Input.bounds.origin.y+40.0f, view_Input.frame.size.width-10*2, 25)];
    }
    //生成
    NSLog(@"seisei");
    //txf_memo = [[UITextField alloc] initWithFrame:CGRectMake(view_Input.bounds.origin.x+10.0f, view_Input.bounds.origin.y+40.0f, view_Input.frame.size.width-10*2, 25)];

    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

#pragma mark イニシャライズ&ロード
- (void)load{
    NSLog(@"- (void)load");
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    NSInteger ns_number_memo = [sectionInfo numberOfObjects];
    int number_memo = ns_number_memo;
    NSLog(@"fetchresurtscotroller %@",self.fetchedResultsController);
    for (int i=0; i<number_memo; i++) {
        NSInteger ii = i;
        NSIndexPath *path = [NSIndexPath indexPathForRow:ii inSection:0];
        NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:path];
        NSNumber *ns_putting_x = [managedObject valueForKey:@"x"];
        NSNumber *ns_putting_y = [managedObject valueForKey:@"y"];
        float putting_x = [ns_putting_x floatValue];
        float putting_y = [ns_putting_y floatValue];
        [self createMemo:[managedObject valueForKey:@"memoText"] put_x:putting_x put_y:putting_y atIndex:path load:YES];
    }
    
     
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    //ToolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 44.0f)];
    toolBar.barStyle = UIBarStyleBlack;
    
    //BarButtonItem
    UIBarButtonItem *btn_back = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector(backCalendar_year)];
    UIBarButtonItem *btn_plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:@selector(plus_memo)];
    UIBarButtonItem *btn_undo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:nil action:@selector(undo)];
    
    //date
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy年M月d日";
    NSString *string_date = [df stringFromDate:date];
    float string_width = 150;
    float string_height = 30;
    UILabel *lbl_date = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, string_width, string_height)];
    lbl_date.textAlignment = UITextAlignmentCenter;
    lbl_date.backgroundColor = [UIColor clearColor];
    lbl_date.textColor = [UIColor whiteColor];
    lbl_date.text = string_date;
    UIBarButtonItem *bbi_date = [[UIBarButtonItem alloc] initWithCustomView:lbl_date];
    bbi_date.width = string_width;
    
    
    NSArray *items =[NSArray arrayWithObjects:bbi_date, btn_back,btn_plus,btn_undo, nil];
    toolBar.items = items;
    [self.view addSubview:toolBar];
    
//    //coredata
//    __managedObjectContext = [self managedObjectContext];
    
    //initialize
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%@",[date description]);
    
    //ToolBar
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 44.0f)];
    toolBar.barStyle = UIBarStyleBlack;
    
    //BarButtonItem
    UIBarButtonItem *btn_back = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStyleBordered target:self action:@selector(backCalendar_year)];
    UIBarButtonItem *btn_plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:@selector(plus_memo)];
    UIBarButtonItem *btn_undo = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemUndo target:nil action:@selector(undo)];
    

    //date
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy年M月d日";
    NSString *string_date = [df stringFromDate:date];
    float string_width = 150;
    float string_height = 30;
    UILabel *lbl_date = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, string_width, string_height)];
    lbl_date.textAlignment = UITextAlignmentCenter;
    lbl_date.backgroundColor = [UIColor clearColor];
    lbl_date.textColor = [UIColor whiteColor];
    lbl_date.text = string_date;
    UIBarButtonItem *bbi_date = [[UIBarButtonItem alloc] initWithCustomView:lbl_date];
    bbi_date.width = string_width;

    
    NSArray *items =[NSArray arrayWithObjects:bbi_date, btn_back,btn_plus,btn_undo, nil];
    toolBar.items = items;
    [self.view addSubview:toolBar];
    
    [self fetchedResultsController];
    
    [self load];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - 
- (void)backCalendar_year{
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)createMemo:(NSString *)memo put_x:(float)x put_y:(float)y atIndex:(NSIndexPath *)atIndex load:(BOOL)yes_or_no
{
    //memoView生成
    CGRect memo_rect = CGRectMake(x, y, 100, 30);
    memoView = [[MemoView alloc] initWithFrame:memo_rect];
    memoView.lbl_memo.text = memo;
    memoView.delegate = self;
    
    if (yes_or_no == YES) {
        memoView.atIndex = atIndex;
    }else{
    //atIndexが被らないように
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults integerForKey:@"memo_atIndex"]) {
        [defaults setInteger:0 forKey:@"memo_atIndex"];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[defaults integerForKey:@"memo_atIndex"] inSection:0];
        memoView.atIndex = path;
    }else{
        [defaults setInteger:[defaults integerForKey:@"memo_atIndex"]+1 forKey:@"memo_atIndex"];
        NSIndexPath *path = [NSIndexPath indexPathForRow:[defaults integerForKey:@"memo_atIndex"] inSection:0];
        memoView.atIndex = path;
    }
    }
    [self.view addSubview:memoView]; 
}

- (void)a{
    
//    //memoView生成
//    CGRect memo_rect = CGRectMake(50, 50, 100, 30);
//    memoView = [[MemoView alloc] initWithFrame:memo_rect];
//    [self.view addSubview:memoView];
    [self createMemo:nil put_x:50 put_y:50 atIndex:nil load:NO];
    
    //inputView
    float input_View_width = 300;
    float input_View_height = 250;
    view_Input = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-input_View_width)/2.0, 20.0f, input_View_width, input_View_height)];
    view_Input.backgroundColor = [UIColor blackColor];
    view_Input.alpha = 0.8;
    
    //入力フィールド
    txf_memo = [[UITextField alloc] initWithFrame:CGRectMake(view_Input.bounds.origin.x+10.0f, view_Input.bounds.origin.y+40.0f, view_Input.frame.size.width-10*2, 25)];
    txf_memo.backgroundColor = [UIColor redColor];  
    txf_memo.borderStyle = UITextBorderStyleBezel;
    [txf_memo becomeFirstResponder];
    [view_Input addSubview:txf_memo];
    
    //テキストフィールドデリゲート
    txf_memo.delegate = self;
    
    //画面に追加
    [self.view addSubview:view_Input];
}

- (void)undo{
    
}

- (void)input_memo{

}

- (void)delete_memoView{
    [view_Input removeFromSuperview];
    [view_Input release];
    [txf_memo release];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self delete_memoView];
    
    
    //memo代入
    memoView.lbl_memo.text = textField.text;
//    [self createNewObject:memoView.lbl_memo.text];
    [self createNewObject:memoView.lbl_memo.text save_x:memoView.frame.origin.x save_y:memoView.frame.origin.y];
    
    
    return YES;
}

//保存
- (void)array_save:(NSMutableArray *)toyBox_to{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:toyBox_to forKey:[date description]];
    //NSLog(@"count is %@",[toyBox_to count]);
}

- (void)dealloc{
    
    [super dealloc];
    [memoView release];
    [self release];

}

#pragma mark - CoreData関連


- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Action" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:NO] autorelease];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"] autorelease];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    



/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = [[managedObject valueForKey:@"timeStamp"] description];
//    
//}

- (void)insertNewObject
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)createNewObject:(NSString *)memo save_x:(float)x save_y:(float)y
{  
    NSLog(@"- (void)createNewObject:(NSString *)memo");  
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    //アトリビュートの代入・保存
    [newManagedObject setValue:memo forKey:@"memoText"];
    [newManagedObject setValue:date forKey:@"timeStamp"];

    
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }  
}

//MemoViewのDelegate
- (void)moveMemo:(CGPoint)origin number:(NSIndexPath *)atIndex
{
    NSLog(@"- (void)moveMemo:(CGPoint)origin number:(NSIndexPath *)atIndex");
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSManagedObject *newManagedObject = [self.fetchedResultsController objectAtIndexPath:atIndex];
    float x = origin.x;
    float y = origin.y;
    [newManagedObject setValue:[NSNumber numberWithFloat:x] forKey:@"x"];
    [newManagedObject setValue:[NSNumber numberWithFloat:y] forKey:@"y"];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
