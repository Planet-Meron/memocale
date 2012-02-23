//
//  MainViewController.m
//  memocale3
//
//  Created by 石橋 弦樹 on 11/12/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *appView =[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    CallendarView_year *callendarView_year = [[CallendarView_year alloc] initWithFrame:appView.bounds fontName:@"AmericanTypewriter" delegate:self];
    
    
    appView.backgroundColor = [UIColor whiteColor];
    self.view = appView;
    
    [self.view addSubview:callendarView_year];
    
    
}

//トップボタン
- (void)conform
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.memoTableViewController.managedObjectContext = appDelegate.managedObjectContext;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:appDelegate.memoTableViewController];
    [nav setNavigationBarHidden:NO];
    [self.view addSubview:nav.view];

    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //タブバー
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320.0f, 44.0f)];
    toolBar.barStyle = UIBarStyleBlack;
    
    //タブバーボタン
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"週" style:UIBarButtonItemStyleBordered target:self action:@selector(conform)];
    NSArray *items =[NSArray arrayWithObjects:btn, nil];
    toolBar.items = items;
    [self.view addSubview:toolBar];
    
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

#pragma mark - 追加
- (void)dayButtonPressed:(DayButton *)button{
    
    //AppDelegate
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    //画面遷移(MemoView)
    MemoViewController *memoVc = [[MemoViewController alloc] init];
    memoVc.date = button.buttonDate;//日付代入
    memoVc.managedObjectContext = appDelegate.managedObjectContext;
    memoVc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:memoVc animated:YES];
    

    
}

- (void)nextButtonPressed{
    
}

- (void)prevButtonPressed{
    
}

@end
