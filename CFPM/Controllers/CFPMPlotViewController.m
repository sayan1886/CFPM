//
//  CFPMPlotViewController.m
//  CFPM
//
//  Created by h.sayy on 5/1/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMPlotViewController.h"

#import "AFJSONRequestOperation.h"
#import "CFPMPlotDetailsViewController.h"

#import "CFPMBarChart.h"
#import "CFPMBar.h"
#import "CFPMPatientOutcome.h"
#import "CFPMAntibioticResistance.h"
#import "CFPMMicrobalProfile.h"
#import "CFPMFevGraph.h"

@interface CFPMPlotViewController ()
{
    CPTPieChart *piePlot;
    BOOL piePlotIsRotating;
    
    NSMutableArray *dataForChart, *dataForPlot;
}

@property (strong, nonatomic) IBOutlet UIView *barChart;
@property (strong, nonatomic) IBOutlet UIView *pieChart;
@property (strong, nonatomic) IBOutlet UIView *fevGraph;
@property (strong, nonatomic) IBOutlet UIView *resistanceChart;
@property (strong, nonatomic) IBOutlet UIView *lineGraph;
@property (weak, nonatomic) IBOutlet UIScrollView *viewScroller;
@end

@implementation CFPMPlotViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Patient Information";
    
    [[CFPMRestManager sharedCFPMRestManager] getBarChartData:^(id data) {
            //        NSLog(@"Data : %@",data);
        if ([[((NSArray *)data) objectAtIndex:0] isKindOfClass:[NSError class]]) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:((NSError *)[((NSArray *)data) objectAtIndex:0]).localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
        CFPMBarChart *barGraph = [[CFPMBarChart alloc] initWithFrame:CGRectMake(0, 0, 600, 200)];
        [barGraph setPlotDataArray:data];
        [barGraph setTag:101];
        [self doubleTapGestureOnView:barGraph];
        [self.barChart addSubview:barGraph];
    }];
    
    [[CFPMRestManager sharedCFPMRestManager] getScatterPlotData:^(id data) {
            //        NSLog(@"Data : %@",data);
        if ([[((NSArray *)data) objectAtIndex:0] isKindOfClass:[NSError class]]) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:((NSError *)[((NSArray *)data) objectAtIndex:0]).localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
        CFPMFevGraph *fev = [[CFPMFevGraph alloc] initWithFrame:CGRectMake(0, 0, 600, 200)];
        [fev setPlotDataArray:data];
        [fev setTag:101];
        [self doubleTapGestureOnView:fev];
        [[self fevGraph] addSubview:fev];
    }];
    
    [[CFPMRestManager sharedCFPMRestManager] getPieChartData:^(id data) {
            //        NSLog(@"Data : %@",data);
        if ([[((NSArray *)data) objectAtIndex:0] isKindOfClass:[NSError class]]) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:((NSError *)[((NSArray *)data) objectAtIndex:0]).localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
        CFPMMicrobalProfile *profile = [[CFPMMicrobalProfile alloc] initWithFrame:CGRectMake(0, 0, 700, 175)];
        [profile setPlotDataArray:data];
        [profile setTag:101];
        [self doubleTapGestureOnView:profile];
        [[self pieChart] addSubview:profile];
    }];
    
    [[CFPMRestManager sharedCFPMRestManager] getAntibioticResistanceData:^(id data) {
            //        NSLog(@"Data : %@",data);
        if ([[((NSArray *)data) objectAtIndex:0] isKindOfClass:[NSError class]]) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:((NSError *)[((NSArray *)data) objectAtIndex:0]).localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
        CFPMAntibioticResistance *antibioticResistance = [[CFPMAntibioticResistance alloc] initWithFrame:CGRectMake(0, 0, 720, 165)];
        [antibioticResistance setPlotDataArray:data];
        [antibioticResistance setTag:101];
        [self doubleTapGestureOnView:antibioticResistance];
        [self.resistanceChart addSubview:antibioticResistance];
    }];
    
    [[CFPMRestManager sharedCFPMRestManager] getPatientOutComeDataWithBlock:^(id data) {
            //        NSLog(@"Data : %@",data);
        if ([[((NSArray *)data) objectAtIndex:0] isKindOfClass:[NSError class]]) {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:((NSError *)[((NSArray *)data) objectAtIndex:0]).localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            return;
        }
        CFPMPatientOutcome *patient_outcome = [[CFPMPatientOutcome alloc] initWithFrame:CGRectMake(0, 0, 600, 200)];
        patient_outcome.plotDataArray = data;
        [patient_outcome setTag:101];
        [self doubleTapGestureOnView:patient_outcome];
        [[self lineGraph] addSubview:patient_outcome];
    }];
    
    [[self viewScroller] setContentSize:CGSizeMake(768, 1420)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Gesture

- (void) doubleTapGestureOnView:(UIView *)view{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [view addGestureRecognizer:doubleTap];
}

- (void) handleDoubleTap:(UIGestureRecognizer *) gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateEnded:{
            CFPMPlotDetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"CFPMPlotDetailsViewController"];
            CGRect viewFrame = CGRectMake(9, 262, 750, 300);
            NSArray *dataArray = nil;
            if ([gesture.view isKindOfClass:[CFPMBarChart class]]) {
                viewFrame = CGRectMake(100, 262, 750, 300);
                dataArray = [((CFPMBarChart *)[gesture view]) plotDataArray];
                CFPMBarChart *barChart = [[CFPMBarChart alloc] initWithFrame:viewFrame];
                [barChart setPlotDataArray:dataArray];
                [[details view] addSubview:barChart];
            }
            else if ([gesture.view isKindOfClass:[CFPMFevGraph class]]) {
                dataArray = [((CFPMFevGraph *)[gesture view]) plotDataArray];
                CFPMFevGraph *fev = [[CFPMFevGraph alloc] initWithFrame:viewFrame];
                [fev setPlotDataArray:dataArray];
                [[details view] addSubview:fev];
            }
            else if ([gesture.view isKindOfClass:[CFPMMicrobalProfile class]]){
                viewFrame = CGRectMake(40, 262, 750, 300);
                dataArray = [((CFPMMicrobalProfile *)[gesture view]) plotDataArray];
                CFPMMicrobalProfile *profile = [[CFPMMicrobalProfile alloc] initWithFrame:viewFrame];
                [profile setPlotDataArray:dataArray];
                [[details view] addSubview:profile];
            }
            else if ([gesture.view isKindOfClass:[CFPMPatientOutcome class]]){
                dataArray = [((CFPMPatientOutcome *)[gesture view]) plotDataArray];
                CFPMPatientOutcome *outcome = [[CFPMPatientOutcome alloc] initWithFrame:viewFrame];
                [outcome setPlotDataArray:dataArray];
                [[details view] addSubview:outcome];
            }
            else{
                dataArray = [((CFPMAntibioticResistance *)[gesture view]) plotDataArray];
                CFPMAntibioticResistance *resist = [[CFPMAntibioticResistance alloc] initWithFrame:viewFrame];
                [resist setPlotDataArray:dataArray];
                [[details view] addSubview:resist];
            }
            
            [self presentViewController:details animated:NO completion:nil];
        }
            break;
            
        default:
            break;
    }
}

@end
