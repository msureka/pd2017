//
//  DOBView2ViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "DOBView2ViewController.h"

@interface DOBView2ViewController ()<UITextFieldDelegate>
{
    NSUserDefaults *defauls;
}

@end

@implementation DOBView2ViewController
@synthesize HeadTopView;
//@synthesize datePicker;
@synthesize datelabel,datelabel_Button,datelabel_txt,Save_Button;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    defauls=[[NSUserDefaults alloc]init];

    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    
     datelabel_txt.delegate=self;
    datelabel_txt.clipsToBounds=YES;
    datelabel_txt.layer.cornerRadius=datelabel_txt.frame.size.height/2;
    
    
       NSDateFormatter *df = [[NSDateFormatter alloc] init];
       [df setDateFormat:@"yyyy-MM-dd "];
    
    
    NSDateFormatter *showdf = [[NSDateFormatter alloc]init];
    [showdf setDateFormat:@"dd-MM-yyyy"];
    
    
    datelabel_txt.text=[NSString stringWithFormat:@"%@",
                        [showdf stringFromDate:[NSDate date]]];
    Save_Button.enabled=YES;
    
    NSString *dateString = datelabel_txt.text;

    NSDate *date = [showdf dateFromString:dateString];
    
    // Convert date object into desired format
    [showdf setDateFormat:@"yyyy-MM-dd"];
    NSString *newDateString = [showdf stringFromDate:date];
    
//    [defauls setObject:newDateString forKey:@"DOB"];
    
    NSLog(@"datetext= %@",datelabel_txt.text);
    NSLog(@"def = %@",[defauls valueForKey:@"DOB"]);
    
    

    NSString * lengths=[defauls valueForKey:@"DOB"];
    if (lengths.length==0)
    {
//        Save_Button.enabled=NO;
//        [Save_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        
        NSDate *date=[df dateFromString:[df stringFromDate:[NSDate date]]];
        NSDateFormatter *showdf = [[NSDateFormatter alloc]init];
        [showdf setDateFormat:@"dd-MM-yyyy"];

        
        datelabel_txt.text=[NSString stringWithFormat:@"%@",[showdf stringFromDate:date]];
        

    }
    else
    {
//        Save_Button.enabled=YES;
//        [Save_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        
      //  datelabel_txt.text=[defauls valueForKey:@"DOB"];
        
        NSString *defDate = [defauls valueForKey:@"DOB"];
        
        NSDateFormatter *showdf = [[NSDateFormatter alloc]init];
        [showdf setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [showdf dateFromString:defDate];
        
        [showdf setDateFormat:@"dd-MM-yyyy"];
        NSString *newDateString = [showdf stringFromDate:date];
        
        datelabel_txt.text = newDateString;
        
        
    }
   
    
    

   

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(IBAction)BackView:(id)sender
{
    if (![datelabel_txt.text isEqualToString:@""] )
    {
        
        NSDateFormatter *showdf = [[NSDateFormatter alloc]init];
        [showdf setDateFormat:@"dd-MM-yyyy"];
        
        NSString *dateString = datelabel_txt.text;
        
        NSDate *date = [showdf dateFromString:dateString];
        
        // Convert date object into desired format
        [showdf setDateFormat:@"yyyy-MM-dd"];
        NSString *newDateString = [showdf stringFromDate:date];

    
        [defauls setObject:newDateString forKey:@"DOB"];
                [defauls synchronize];
        
        NSLog(@"back =%@",[defauls valueForKey:@"DOB"]);

    }

    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [datelabel_txt becomeFirstResponder];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [datelabel_txt becomeFirstResponder];

    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    datePicker.date = [NSDate date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    NSDate *currDate = [NSDate date];
    
    // minimum date date picker
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-12];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currDate options:0];
    
    [datePicker setMaximumDate:currDate];
    
    [datePicker setMinimumDate:minDate];
    
    
     [df setDateFormat:@"yyyy-MM-dd "];
    
   // [df setDateFormat:@"dd-MM-yyyy"];
    
    
    
    
    NSString * lengths=[defauls valueForKey:@"DOB"];
    if (lengths.length==0) {
        
        NSDate *date=[df dateFromString:[df stringFromDate:[NSDate date]]];
        [datePicker setDate:date];
    }
    
       else
    {
        NSDate *date=[df dateFromString:[defauls valueForKey:@"DOB"]];
        [datePicker setDate:date];
    }

    
    [datePicker addTarget:self
                   action:@selector(LabelChange1:)
         forControlEvents:UIControlEventValueChanged];
    datePicker.backgroundColor=[UIColor lightGrayColor];
    [datelabel_txt setInputView:datePicker];
    
  }
- (void)LabelChange1:(UIDatePicker *)datePicker
{
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//   // df.dateStyle = NSDateFormatterMediumStyle;
//    //   df.dateStyle = NSDateFormatterShortStyle;
//       [df setDateFormat:@"yyyy-MM-dd "];
    
#pragma mark - Date DD MM YYYY
    
    NSDateFormatter *showdf = [[NSDateFormatter alloc]init];
    [showdf setDateFormat:@"dd-MM-yyyy"];
    
    
//    
//    datelabel_txt.text = [NSString stringWithFormat:@"%@",
//                          [df stringFromDate:datePicker.date]];
    
    datelabel_txt.text = [NSString stringWithFormat:@"%@",
                          [showdf stringFromDate:datePicker.date]];
    
    
    
    
    

    
    
    if (datelabel_txt.text.length==0)
    {
        Save_Button.enabled=NO;
        [Save_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
       
    }
    else
    {
        Save_Button.enabled=YES;
        [Save_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
       
    }
    

 
    
}


@end
