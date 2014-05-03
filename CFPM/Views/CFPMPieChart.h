//
//  CFPMPieChart.h
//  CFPM
//
//  Created by h.sayy on 18/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPMPieChart : UIView
@property (strong, nonatomic) IBOutlet UILabel *numberOfReads;
@property (nonatomic,retain) NSDictionary *plotData;
@end
