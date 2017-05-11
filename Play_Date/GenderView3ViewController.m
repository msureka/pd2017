//
//  GenderView3ViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "GenderView3ViewController.h"

@interface GenderView3ViewController ()
{
    NSArray * Array_Gender,*Array_Gender11;
    NSUserDefaults * defaults;
    NSString *borderLine;
}
@end

@implementation GenderView3ViewController
@synthesize HeadTopView,Table_Gender,cell_Gender;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults=[[NSUserDefaults alloc]init];
    borderLine=@"yes";
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    Array_Gender=[[NSArray alloc]initWithObjects:@"Boy \U0001F466",@"Girl \U0001F467", nil];
      Array_Gender11=[[NSArray alloc]initWithObjects:@"Boy",@"Girl", nil];
    
    
    Table_Gender.delegate=self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 46)];

    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20, 28)];
    labelView.textColor=[UIColor lightGrayColor];
    labelView.text=@"I am a";
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
   // cell_Gender.EmojjiImg.hidden=YES;
  
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([borderLine isEqualToString:@"yes"])
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
     if (indexPath.row == 1)
     {
        borderLine=@"no";
     }
    if ([[Array_Gender11 objectAtIndex:indexPath.row] isEqualToString:[defaults valueForKey:@"gender"]])
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
    [defaults setObject:[Array_Gender11 objectAtIndex:indexPath.row] forKey:@"gender"];
    [defaults synchronize];
    [Table_Gender reloadData];
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
// //   [Table_Gender cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//}
@end
