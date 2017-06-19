//
//  NewPlayDateCreateViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 6/15/17.
//  Copyright © 2017 Spiel's Macmini. All rights reserved.
//

#import "NewPlayDateCreateViewController.h"
#import "InviteSprintTagUserViewController.h"
@interface NewPlayDateCreateViewController ()<UITextViewDelegate>
{
   
}
@end

@implementation NewPlayDateCreateViewController
@synthesize HeadTopView,label_day,label_date,label_time,label_placeholder,textview_disc,textfield_meetup,Picker_date,Button_invite,textfield_location;
- (void)viewDidLoad
{
    [super viewDidLoad];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.10f].CGColor;
    
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    [textfield_meetup becomeFirstResponder];
    textfield_location.delegate=self;
    
    Button_invite.enabled=NO;
    [Button_invite setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    Picker_date.date = [NSDate date];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    NSDate *currDate = [NSDate date];
    
    // minimum date date picker
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-12];
    
    [Picker_date setMinimumDate:currDate];
   
    
   
    [df setDateFormat:@"yyyy-MM-dd h:mm:ss a"];
    

    
    [Picker_date addTarget:self
                   action:@selector(LabelChange1:)
         forControlEvents:UIControlEventValueChanged];
    
    
    
    NSDateFormatter *showdf,*showdftime,*showdfday;
    showdf = [[NSDateFormatter alloc]init];
    [showdf setDateFormat:@"d-LLLL-yyyy"];
    
    showdftime= [[NSDateFormatter alloc]init];
    [showdftime setDateFormat:@"h:mm a"];
    
    showdfday= [[NSDateFormatter alloc]init];
    [showdfday setDateFormat:@"EEEE"];
    
    label_date.text = [NSString stringWithFormat:@"%@",
                       [showdf stringFromDate:Picker_date.date]];
    
    label_time.text =[NSString stringWithFormat:@"%@",
                      [showdftime stringFromDate:Picker_date.date]];
    
    label_day.text =[NSString stringWithFormat:@"%@",
                     [showdfday stringFromDate:Picker_date.date]];

    
    
    
  //  Picker_date.backgroundColor=[UIColor lightGrayColor];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
     textfield_location.delegate=self;
}
- (IBAction)Invite_Button:(id)sender
{
    InviteSprintTagUserViewController * set=[self.storyboard instantiateViewControllerWithIdentifier:@"InviteSprintTagUserViewController"];
    set.label_time1=label_time.text;
    set.label_day1=label_day.text;
    set.label_date1=[NSString stringWithFormat:@"%@",Picker_date.date];;
    set.textfield_meetup1=textfield_meetup.text;
    set.textfield_location1=textfield_location.text;
    set.textview_disc1=textview_disc.text;
    
[self.navigationController pushViewController:set animated:YES];
    
}
- (IBAction)Cancel_Button:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
 
    
//    UIDatePicker *datePicker=[[UIDatePicker alloc]init];
//    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    
    
    
}
- (void)LabelChange1:(UIDatePicker *)datePicker
{
    
#pragma mark - Date DD MM YYYY
    
    NSDateFormatter *showdf,*showdftime,*showdfday;
    showdf = [[NSDateFormatter alloc]init];
    [showdf setDateFormat:@"d-LLLL-yyyy"];
    
    showdftime= [[NSDateFormatter alloc]init];
     [showdftime setDateFormat:@"h:mm a"];
   
    showdfday= [[NSDateFormatter alloc]init];
    [showdfday setDateFormat:@"EEEE"];
    
    label_date.text = [NSString stringWithFormat:@"%@",
                          [showdf stringFromDate:datePicker.date]];
    
    label_time.text =[NSString stringWithFormat:@"%@",
                      [showdftime stringFromDate:datePicker.date]];
    
    label_day.text =[NSString stringWithFormat:@"%@",
                     [showdfday stringFromDate:datePicker.date]];
    
    
   
    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    if (textView.text.length==0)
//    {
//     
//        label_placeholder.hidden=YES;
//        
//    }

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0)
    {
    
        label_placeholder.hidden=NO;
        
    }
    else
    {
     label_placeholder.hidden=YES;
    }

 
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0)
    {
      label_placeholder.hidden=NO;
    }
    else
    {
      label_placeholder.hidden=YES;
       
    }
  
}
- (IBAction)TextField_Actions:(id)sender
{
    if (textfield_location.text.length==0 || textfield_meetup.text.length==0)
    {
        Button_invite.enabled=NO;
        [Button_invite setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    else
    {
        Button_invite.enabled=YES;
        [Button_invite setBackgroundColor:[UIColor colorWithRed:255/255.0  green:242/255.0 blue:82/255.0 alpha:1]];
    }
    
    
    
}
@end
