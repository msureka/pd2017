//
//  AboutView6ViewController.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/29/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "AboutView6ViewController.h"

@interface AboutView6ViewController ()<UITextViewDelegate>
{
    NSUserDefaults *defaults;
}
@end

@implementation AboutView6ViewController
@synthesize HeadTopView,Desc_Txt,Save_Button;
- (void)viewDidLoad {
    [super viewDidLoad];
    defaults=[[NSUserDefaults alloc]init];
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor;
    borderBottom.frame = CGRectMake(0, HeadTopView.frame.size.height - 2, HeadTopView.frame.size.width, 2);
    [HeadTopView.layer addSublayer:borderBottom];
    Desc_Txt.clipsToBounds=YES;
    Desc_Txt.layer.cornerRadius=9.0f;
    [Desc_Txt becomeFirstResponder];
//    Desc_Txt.layer.borderColor=[UIColor lightGrayColor].CGColor;
//    Desc_Txt.layer.borderWidth=2.0f;
    
    NSString * lengths=[defaults valueForKey:@"description"];
    Desc_Txt.text=[defaults valueForKey:@"description"];
   
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (Desc_Txt.text.length==0)
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)BackView:(id)sender
{
    [defaults setObject:Desc_Txt.text forKey:@"description"];
    [defaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <=200;
}

@end
