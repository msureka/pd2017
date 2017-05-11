//
//  NameView1ViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "NameView1ViewController.h"

@interface NameView1ViewController ()<UITextFieldDelegate>
{
    NSUserDefaults *defauls;
}
@end

@implementation NameView1ViewController
@synthesize HeadTopView,Fname_Txt,Lname_Txt,Save_Button;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    defauls=[[NSUserDefaults alloc]init];
    [Fname_Txt becomeFirstResponder];
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width,2);
    [HeadTopView.layer addSublayer:borderBottom];
    Fname_Txt.clipsToBounds=YES;
    //    Fname_Txt.layer.cornerRadius=Fname_Txt.frame.size.height/2;
    
    Lname_Txt.clipsToBounds=YES;
    Fname_Txt.delegate=self;
    //    Lname_Txt.layer.cornerRadius=Lname_Txt.frame.size.height/2;
    NSString * lengths=[defauls valueForKey:@"fname"];
    if (lengths.length==0)
    {
        Save_Button.enabled=NO;
        [Save_Button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    else
    {
        Save_Button.enabled=YES;
        [Save_Button setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.9] forState:UIControlStateNormal];
        Fname_Txt.text=[defauls valueForKey:@"fname"];
    }
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackView:(id)sender
{
    if (![Fname_Txt.text isEqualToString:@""] )
    {
        [defauls setObject:Fname_Txt.text forKey:@"fname"];
       
        [defauls synchronize];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (IBAction)TextFielAction:(id)sender
{
    if (Fname_Txt.text.length==0)
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    

    if (textField == Fname_Txt) {
        int lengtha = [Fname_Txt.text length];
        NSLog(@"lenghta = %d",lengtha);
        if (lengtha >=14 && ![string isEqualToString:@""])
        {
            Fname_Txt.text = [Fname_Txt.text substringToIndex:14];
            return NO;
        }
        return YES;
    }
    return YES;
}
@end
