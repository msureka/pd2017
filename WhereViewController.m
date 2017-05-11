//
//  WhereViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 1/4/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "WhereViewController.h"
#import "DiscoverViewController.h"
@class DiscoverViewController;

@interface WhereViewController ()
{
    NSArray * Array_Gender,*Array_Gender1;
    NSString * Borderline;
    NSUserDefaults * defaults;
}


@end

@implementation WhereViewController
@synthesize HeadTopView,Table_Gender,cell_Gender;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    Borderline=@"yes";
    [HeadTopView.layer addSublayer:borderBottom];
    Array_Gender=[[NSArray alloc]initWithObjects:@"My city only",@"My country",@"Anywhere in the world!", nil];
     Array_Gender1=[[NSArray alloc]initWithObjects:@"CITY",@"COUNTRY",@"GLOBAL", nil];
    Table_Gender.delegate=self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 46)];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20, 28)];
    labelView.textColor=[UIColor lightGrayColor];
    labelView.text=@"Discover people from";
    labelView.backgroundColor=[UIColor clearColor];
    [headerView addSubview:labelView];
    Table_Gender.tableHeaderView = headerView;
    [Table_Gender reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackView:(id)sender
{
    if ([[defaults valueForKey:@"switchPressed"] isEqualToString:@"YES"])
    {
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [defaults setObject:@"no" forKey:@"switchPressed"];
        
        [defaults setObject:@"YES" forKey:@"SavePressed"];

        
    }
    else
    {
        
        [self.navigationController popViewControllerAnimated:YES];
       
    }


    
   // [self.navigationController popViewControllerAnimated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Array_Gender.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 48;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mycellid1=@"Cell_Gender";
    
    cell_Gender = (GenderViewTableViewCell*)[Table_Gender dequeueReusableCellWithIdentifier:mycellid1 forIndexPath:indexPath];
    
    
    if (cell_Gender == nil)
    {
        
        cell_Gender = [[GenderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:mycellid1];
    }
    cell_Gender.Names.text=[Array_Gender objectAtIndex:indexPath.row];
    cell_Gender.EmojjiImg.hidden=YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([Borderline isEqualToString:@"yes"])
    {
        
    
    if (indexPath.row == 0  )
    {
        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
        topLineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [cell_Gender.contentView addSubview:topLineView];
    }
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell_Gender.bounds.size.height-1, self.view.bounds.size.width, 1)];
    bottomLineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [cell_Gender.contentView addSubview:bottomLineView];
    }
    if (indexPath.row == 2 )
    {
        Borderline=@"no";
    }
    if ([[Array_Gender1 objectAtIndex:indexPath.row] isEqualToString:[defaults valueForKey:@"distance"]])
    {
        cell_Gender.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else
    {
        cell_Gender.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell_Gender;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    [Table_Gender cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    [defaults setObject:[Array_Gender1 objectAtIndex:indexPath.row] forKey:@"distance"];
    [defaults synchronize];
    [Table_Gender reloadData];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
// //   [Table_Gender cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//}

@end
