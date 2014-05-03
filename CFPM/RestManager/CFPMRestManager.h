    //
    //  CFPMAppDelegate.h
    //  CFPM
    //
    //  Created by h.sayy on 5/1/14.
    //  Copyright (c) 2014 h.sayy. All rights reserved.
    //

#import <Foundation/Foundation.h>

@interface CFPMRestManager : NSObject

@property (nonatomic, strong) NSString *patientid;

+ (instancetype ) sharedCFPMRestManager;

- (void) startRestCallWithParam:(NSDictionary *)param
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure;

- (void) getBarChartData:(void (^)(id data))block;

- (void) getScatterPlotData:(void (^)(id data))block;

- (void) getPieChartData:(void (^)(id data))block;

- (void) getAntibioticResistanceData:(void (^)(id data))block;

- (void) getPatientOutComeDataWithBlock:(void (^)(id data))block;

- (void) getPatientInfoData:(void (^)(id data))block;

@end
