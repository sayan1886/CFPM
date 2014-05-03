//
//  CFPMViewController.m
//  CFPM
//
//  Created by h.sayy on 5/1/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMViewController.h"
#import "CFPMPlotViewController.h"

@interface CFPMViewController ()

@property (strong, nonatomic) IBOutlet UITextField *textField;

- (IBAction)buttonTapped:(UIButton *)sender;

@end

@implementation CFPMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Patient ID";
    NSString *textString = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [[CFPMRestManager sharedCFPMRestManager] setPatientid:textString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(UIButton *)sender
{
    [self.textField resignFirstResponder];
    
    NSString *textString = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.textField.text = textString;
    
    if (0 == textString.length)
        {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Patient ID" message:@"Please give patient ID." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        [self.textField becomeFirstResponder];
        return;
        }
    
    CFPMPlotViewController *plotVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CFPMPlotViewController"];
    plotVC.patientID = textString;
    [[CFPMRestManager sharedCFPMRestManager] setPatientid:textString];
    [self.navigationController pushViewController:plotVC animated:YES];
}

@end
