//
//  LanguagesView5ViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "LanguagesView5ViewController.h"

@interface LanguagesView5ViewController ()
{
    NSArray * Array_Gender;
    NSString * CheckStr,*borderLine;
    NSUserDefaults * defauls;
    NSMutableArray * Array_languge,*Array_addlanguges;
}

@end

@implementation LanguagesView5ViewController
@synthesize HeadTopView,Table_Gender,cell_Gender;
- (void)viewDidLoad {
    [super viewDidLoad];
    defauls=[[NSUserDefaults alloc]init];
    
    Array_languge=[[NSMutableArray alloc]init];
    Array_addlanguges=[[NSMutableArray alloc]init];
    
    NSString * arryString=[defauls valueForKey:@"language"];
    NSArray *arr = [arryString componentsSeparatedByString:@","];
    if (![arryString isEqualToString:@""])
    {
        
        Array_addlanguges = [NSMutableArray arrayWithArray:arr];
        NSLog(@"Array_addlangugesArray_addlanguges==%@",Array_addlanguges);
        
        
    }
   

  borderLine=@"yes";
//    if ([[defauls valueForKey:@"English"] isEqualToString:@"yes"])
//    {
//      [Array_languge insertObject:@"yes" atIndex:0];
//        
//    }
//    else
//    {
//    [Array_languge insertObject:@"no" atIndex:0];
//          [defauls setObject:@"no" forKey:@"English"];
//    }
//    if ([[defauls valueForKey:@"Arabic"] isEqualToString:@"yes"])
//    {
//        [Array_languge insertObject:@"yes" atIndex:1];
//       
//    }
//    else
//    {
//     [Array_languge insertObject:@"no" atIndex:1];
//         [defauls setObject:@"no" forKey:@"Arabic"];
//    }
//    if ([[defauls valueForKey:@"French"] isEqualToString:@"yes"])
//    {
//        [Array_languge insertObject:@"yes" atIndex:2];
//    }
//    else
//    {
//        [Array_languge insertObject:@"no" atIndex:2];
//         [defauls setObject:@"no" forKey:@"French"];
//    };
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width,2);
    [HeadTopView.layer addSublayer:borderBottom];
    Array_Gender=[[NSArray alloc]initWithObjects:@"English",@"Arabic",@"French",@"Chinese",@"Spanish",@"Bengali",@"Hindi",@"Russian",@"Portuguese",@"Japanese",@"German",@"Javanese",@"Korean",@"Turkish",@"Vietnamese",@"Telugu",@"Marathi",@"Tamil",@"Urdu",@"Italian",@"Gujarati",@"Polish",@"Ukrainian",@"Persian",@"Malayalam",@"Kannada",@"Oriya",@"Panjabi",@"Romanian",@"Maithili",@"Azerbaijani",@"Hausa",@"Burmese",@"Dutch",@"Yoruba",@"Thai", nil];
    
    Table_Gender.delegate=self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 46)];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20, 28)];
    labelView.textColor=[UIColor lightGrayColor];
    labelView.text=@"Select your languages:";
    labelView.backgroundColor=[UIColor clearColor];
    [headerView addSubview:labelView];
    Table_Gender.tableHeaderView = headerView;
    [Table_Gender reloadData];
    CheckStr=@"yes";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackView:(id)sender
{
    NSString *string=[[NSString alloc]init];
    if (Array_addlanguges.count!=0)
    {
          string = [Array_addlanguges componentsJoinedByString:@","];
    }
    NSLog(@"Languge Arraystring==%@",string);
    [defauls setObject:string forKey:@"language"];
    [defauls synchronize];
;
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
    cell_Gender.EmojjiImg.hidden=YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.row == 0 )
    {
        cell_Gender.borderLineTop.hidden=NO;
      
    }
    else
    {
       cell_Gender.borderLineTop.hidden=YES;
         cell_Gender.borderLineBoottom.hidden=NO;
    }
    
    
    if ([Array_addlanguges containsObject:[Array_Gender objectAtIndex:indexPath.row]])
    {
        cell_Gender.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    else
    {
        cell_Gender.accessoryType = UITableViewCellAccessoryNone;
    }
    
//            if (indexPath.row==0)
//            {
//                if ([[Array_languge objectAtIndex:0] isEqualToString:@"yes"]) {
//                
//                 cell_Gender.accessoryType = UITableViewCellAccessoryCheckmark;
//                }
//                else
//                {
//                  cell_Gender.accessoryType = UITableViewCellAccessoryNone;
//                }
//            }
//            if (indexPath.row==1)
//            {
//                if ([[Array_languge objectAtIndex:1] isEqualToString:@"yes"]) {
//                    
//                    cell_Gender.accessoryType = UITableViewCellAccessoryCheckmark;
//                }
//                else
//                {
//                    cell_Gender.accessoryType = UITableViewCellAccessoryNone;
//                }
//            }
//            if (indexPath.row==2)
//            {
//                if ([[Array_languge objectAtIndex:2] isEqualToString:@"yes"]) {
//                    
//                    cell_Gender.accessoryType = UITableViewCellAccessoryCheckmark;
//                }
//                else
//                {
//                    cell_Gender.accessoryType = UITableViewCellAccessoryNone;
//                }
//                borderLine=@"no";
//            }
//   

    return cell_Gender;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    NSInteger indexValue = [Array_addlanguges indexOfObject:[Array_Gender objectAtIndex:indexPath.row]];
    if (Array_addlanguges.count<=2)
    {
        if ([Array_addlanguges containsObject:[Array_Gender objectAtIndex:indexPath.row]])
        {
            
            [Array_addlanguges removeObjectAtIndex:indexValue];
        }
        else
        {
            [Array_addlanguges addObject:[Array_Gender objectAtIndex:indexPath.row]];
        }
        
    }
    else
    {
        if ([Array_addlanguges containsObject:[Array_Gender objectAtIndex:indexPath.row]])
        {
            [Array_addlanguges removeObjectAtIndex:indexValue];
        }
    }
    NSLog(@"Array_addlanguges==%lu",(unsigned long)Array_addlanguges.count);
    NSLog(@"Array_addlanguges==%@",Array_addlanguges);
       [Table_Gender reloadData];
    
    
    
    
    
    
//                 if (indexPath.row==0)
//                {
//                    if (Array_languge.count==0)
//                    {
//                     [Array_languge insertObject:@"yes" atIndex:0];
//                    }
//                    else
//                    {
//                        if ([[Array_languge objectAtIndex:0] isEqualToString:@"yes"])
//                        {
//                            [Array_languge removeObjectAtIndex:0];
//                              [Array_languge insertObject:@"no" atIndex:0];
//                            [defauls setObject:@"no" forKey:@"English"];
//                        }
//                        else
//                        if ([[Array_languge objectAtIndex:0] isEqualToString:@"no"])
//                        {
//                            [Array_languge removeObjectAtIndex:0];
//                              [Array_languge insertObject:@"yes" atIndex:0];
//                            [defauls setObject:@"yes" forKey:@"English"];
//                        }
//                    }
//                    
//                }
//                if (indexPath.row==1)
//                {
//                    
//                    if (Array_languge.count==0)
//                    {
//                        [Array_languge insertObject:@"yes" atIndex:1];
//                    }
//                    else
//                    {
//                        if ([[Array_languge objectAtIndex:1] isEqualToString:@"yes"])
//                        {
//                            [Array_languge removeObjectAtIndex:1];
//                            [Array_languge insertObject:@"no" atIndex:1];
//                            [defauls setObject:@"no" forKey:@"Arabic"];
//                        }
//                        else
//                            if ([[Array_languge objectAtIndex:1] isEqualToString:@"no"])
//                            {
//                                [Array_languge removeObjectAtIndex:1];
//                                [Array_languge insertObject:@"yes" atIndex:1];
//                                 [defauls setObject:@"yes" forKey:@"Arabic"];
//                            }
//                    }
//
//                   
//                }
//                if (indexPath.row==2)
//                {
//                    if (Array_languge.count==0)
//                    {
//                        [Array_languge insertObject:@"yes" atIndex:2];
//                    }
//                    else
//                    {
//                        if ([[Array_languge objectAtIndex:2] isEqualToString:@"yes"])
//                        {
//                            [Array_languge removeObjectAtIndex:2];
//                            [Array_languge insertObject:@"no" atIndex:2];
//                             [defauls setObject:@"no" forKey:@"French"];
//                        }
//                        else
//                            if ([[Array_languge objectAtIndex:2] isEqualToString:@"no"])
//                            {
//                                [Array_languge removeObjectAtIndex:2];
//                                [Array_languge insertObject:@"yes" atIndex:2];
//                                [defauls setObject:@"yes" forKey:@"French"];
//                            }
//                    }
//
//                    
//                }

    
   
   
    
    
   
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   // [Table_Gender cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//}

@end
