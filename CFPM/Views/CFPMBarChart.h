//
//  CFPMBarChart.h
//  CFPM
//
//  Created by h.sayy on 16/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFPMBar.h"

@interface CFPMBarChart : UIView
//Plots
@property (strong, nonatomic) IBOutlet CFPMBar *bar1;
@property (strong, nonatomic) IBOutlet CFPMBar *bar2;
@property (strong, nonatomic) IBOutlet CFPMBar *bar3;
@property (strong, nonatomic) IBOutlet CFPMBar *bar4;
@property (strong, nonatomic) IBOutlet CFPMBar *bar5;
@property (strong, nonatomic) NSArray *plotDataArray;
@end
