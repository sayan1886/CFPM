//
//  CFPMMicrobalProfile.h
//  CFPM
//
//  Created by h.sayy on 18/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFPMMicrobalProfile : UIView
@property (strong, nonatomic) IBOutlet UIView *pieChart1;
@property (strong, nonatomic) IBOutlet UIView *pieChart2;
@property (strong, nonatomic) IBOutlet UIView *pieChart3;
@property (strong, nonatomic) IBOutlet UIView *pieChart4;
@property (strong, nonatomic) NSArray *plotDataArray;
@end
