    //
    //  CFPMAppDelegate.h
    //  CFPM
    //
    //  Created by h.sayy on 5/1/14.
    //  Copyright (c) 2014 h.sayy. All rights reserved.
    //

#import "CFPMRestManager.h"
#import "AFJSONRequestOperation.h"

@implementation CFPMRestManager

static inline NSString * DICT_KEY(int I) {
    NSString *key = @"";
    switch (I) {
        case 0:
            key = @"Escherichia";
            break;
        case 1:
            key = @"Streptococcus";
            break;
        case 2:
            key = @"Rothia";
            break;
        case 3:
            key = @"Other";
            break;
        default:
            break;
    }
    return key;
}

#pragma mark - SharedInstance

SINGLETON_GCD(CFPMRestManager);

- (void) startRestCallWithParam:(NSDictionary *)param
                        success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                        failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure{
    NSArray *keys = [param allKeys];
    if ([keys count] < 2) {
        return;
    }
    
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithArray:@[@"text/json",@"application/json", @"text/html", @"text/javascript", @"text/plain"]]];
    AFJSONRequestOperation *operation = nil;
        //Use Mock JSON from App bundle
    if (!REMOTE_HOST_REACHABLE) {
        NSURL *fileURL = nil;
        if ([[param objectForKey:@"req"] isEqualToString:PATIENT_INFO_DATA]) {
            fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:PATIENT_INFO_DATA ofType:@"json"]];
            
        }
        if ([[param objectForKey:@"req"] isEqualToString:BAR_CHART_DATA]) {
            fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:BAR_CHART_DATA ofType:@"json"]];
            
        }
        if ([[param objectForKey:@"req"] isEqualToString:SCATTER_PLOT_DATA]) {
            fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:SCATTER_PLOT_DATA ofType:@"json"]];
            
        }
        if ([[param objectForKey:@"req"] isEqualToString:PIE_CHART_DATA]) {
            fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:PIE_CHART_DATA ofType:@"json"]];
            
        }
        if ([[param objectForKey:@"req"] isEqualToString:ANTIBIOTIC_RESISTANCE_DATA]) {
            fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:ANTIBIOTIC_RESISTANCE_DATA ofType:@"json"]];
        }
        
        if ([[param objectForKey:@"req"] isEqualToString:PATIENT_OUTCOME_DATA]) {
            fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:PATIENT_OUTCOME_DATA ofType:@"json"]];
        }
        if (fileURL) {
            operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:fileURL cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300.0] success:success failure:failure] ;
        }
    }
    else{
        operation  = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:REMOTEURL(param) cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:300.0] success:success failure:failure] ;
    }
    if (operation) {
        [operation start];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Please Check Your Network"delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

- (void) getBarChartData:(void (^)(id data))block {
    [self startRestCallWithParam:@{@"req":BAR_CHART_DATA, PATIENT_ID:self.patientid} success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"result"] isEqualToString:@"true"]) {
            NSArray *list = [JSON objectForKey:@"list"];
            NSMutableArray *resistanceArray = [NSMutableArray array];
            NSMutableArray *strainArray = [NSMutableArray array];
            for(int i = 0; i < [list count]; i++){
                NSDictionary *item = [list objectAtIndex:i];
                [resistanceArray addObject:[item objectForKey:@"Resistance"] ];
                [strainArray addObject:[item objectForKey:@"Strain"] ];
            }
            block(@[resistanceArray, strainArray]);
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[JSON objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(@[error]);
    }];
}

- (void) getScatterPlotData:(void (^)(id data))block{
    [self startRestCallWithParam:@{@"req":SCATTER_PLOT_DATA, PATIENT_ID:self.patientid} success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"result"] isEqualToString:@"true"]) {
            block([JSON objectForKey:@"list"]);
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[JSON objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(@[error]);
    }];
}

- (void) getPieChartData:(void (^)(id data))block {
    [self startRestCallWithParam:@{@"req":PIE_CHART_DATA, PATIENT_ID:self.patientid} success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"result"] isEqualToString:@"true"]) {
            NSDictionary *list = [JSON objectForKey:@"list"];
            NSMutableDictionary *aDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *bDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *cDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *dDict = [NSMutableDictionary dictionary];
            double numberOfReadsA = 0.0;
            double othersA = 0.0f;
            double numberOfReadsB = 0.0;
            double othersB = 0.0f;
            double numberOfReadsC = 0.0;
            double othersC = 0.0f;
            double numberOfReadsD = 0.0;
            double othersD = 0.0f;
            int othersCutOff = 4;
//            NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
            NSArray *itemA = [list objectForKey:@"A"];
            NSMutableArray *plotA = [NSMutableArray array];
            for(int i = 0; i < [itemA count]; i++){
                if (i < othersCutOff) {
                    [plotA addObject:@{@"Plot":[NSNumber numberWithDouble:[[[itemA objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]], @"Species":[[itemA objectAtIndex:i] objectForKey:@"Species"]}];
                }
                else {
                    othersA += [[[itemA objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue];
                }
                numberOfReadsA += [[[itemA objectAtIndex:i] objectForKey:@"Number_Reads"] doubleValue];
            }
//            [plotA sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
//            [plotA addObject:[NSNumber numberWithDouble:othersA]];
            [plotA addObject:@{@"Plot":[NSNumber numberWithDouble:othersA], @"Species":@"Others"}];
            [aDict setObject:plotA forKey:@"plot"];
            [aDict setObject:[NSNumber numberWithDouble:numberOfReadsA] forKey:@"read"];
            
            NSArray *itemB = [list objectForKey:@"B"];
            NSMutableArray *plotB = [NSMutableArray array];
            for(int i = 0; i < [itemB count]; i++){
                if (i < othersCutOff) {
//                    [plotB addObject:[NSNumber numberWithDouble:[[[itemB objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]]];
                    [plotB addObject:@{@"Plot":[NSNumber numberWithDouble:[[[itemB objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]], @"Species":[[itemB objectAtIndex:i] objectForKey:@"Species"]}];
                }
                else {
                    othersB += [[[itemB objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue];
                }
                numberOfReadsB += [[[itemB objectAtIndex:i] objectForKey:@"Number_Reads"] doubleValue];
            }
//            [plotB sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
//            [plotB addObject:[NSNumber numberWithDouble:othersB]];
            [plotB addObject:@{@"Plot":[NSNumber numberWithDouble:othersB], @"Species":@"Others"}];
            [bDict setObject:plotB forKey:@"plot"];
            [bDict setObject:[NSNumber numberWithDouble:numberOfReadsB] forKey:@"read"];
        
            NSArray *itemC = [list objectForKey:@"C"];
            NSMutableArray *plotC = [NSMutableArray array];
            for(int i = 0; i < [itemC count]; i++){
                if (i < othersCutOff) {
//                    [plotC addObject:[NSNumber numberWithDouble:[[[itemC objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]]];
                    [plotC addObject:@{@"Plot":[NSNumber numberWithDouble:[[[itemC objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]], @"Species":[[itemC objectAtIndex:i] objectForKey:@"Species"]}];
                }
                else {
                    othersC += [[[itemC objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue];
                }
                numberOfReadsC += [[[itemC objectAtIndex:i] objectForKey:@"Number_Reads"] doubleValue];
            }
//            [plotC sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
//            [plotC addObject:[NSNumber numberWithDouble:othersC]];
            [plotC addObject:@{@"Plot":[NSNumber numberWithDouble:othersC], @"Species":@"Others"}];
            [cDict setObject:plotC forKey:@"plot"];
            [cDict setObject:[NSNumber numberWithDouble:numberOfReadsC] forKey:@"read"];
            
            NSArray *itemD = [list objectForKey:@"D"];
            NSMutableArray *plotD = [NSMutableArray array];
            for(int i = 0; i < [itemD count]; i++){
                if (i < othersCutOff) {
//                    [plotD addObject:[NSNumber numberWithDouble:[[[itemD objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]]];
                    [plotD addObject:@{@"Plot":[NSNumber numberWithDouble:[[[itemD objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue]], @"Species":[[itemD objectAtIndex:i] objectForKey:@"Species"]}];
                }
                else {
                    othersD += [[[itemD objectAtIndex:i] objectForKey:@"Fraction_Abundance"] doubleValue];
                }
                numberOfReadsD += [[[itemD objectAtIndex:i] objectForKey:@"Number_Reads"] doubleValue];
            }
//            [plotD sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
//            [plotD addObject:[NSNumber numberWithDouble:othersD]];
            [plotD addObject:@{@"Plot":[NSNumber numberWithDouble:othersD], @"Species":@"Others"}];
            [dDict setObject:plotD forKey:@"plot"];
            [dDict setObject:[NSNumber numberWithDouble:numberOfReadsD] forKey:@"read"];
            block(@[aDict, bDict, cDict, dDict]);
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[JSON objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(@[error]);
    }];
}

- (void) getAntibioticResistanceData:(void (^)(id data))block {
    [self startRestCallWithParam:@{@"req":ANTIBIOTIC_RESISTANCE_DATA, PATIENT_ID:self.patientid} success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"result"] isEqualToString:@"true"]) {
            NSArray *list = [JSON objectForKey:@"list"];
            NSMutableDictionary *aDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *bDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *cDict = [NSMutableDictionary dictionary];
            NSMutableDictionary *dDict = [NSMutableDictionary dictionary];
            int a = 0, b = 0, c = 0, d =0;
            for(int i = 0; i < [list count]; i++){
                NSDictionary *item = [list objectAtIndex:i];
                if ([[item objectForKey:@"HealthStat"] isEqualToString:@"A"]) {
                    NSDictionary *resitance = [NSDictionary dictionaryWithObjects:@[((NSString *)[item objectForKey:@"AminoG"]).length > 0 ? [item objectForKey:@"AminoG"] : @"0", ((NSString *)[item objectForKey:@"MacroL"]).length > 0 ? [item objectForKey:@"MacroL"] : @"0"] forKeys:@[@"AminoG", @"MacroL"]];
                    [aDict setObject:resitance forKey:DICT_KEY(a++)];
                }
                if ([[item objectForKey:@"HealthStat"] isEqualToString:@"B"]) {
                    NSDictionary *resitance = [NSDictionary dictionaryWithObjects:@[((NSString *)[item objectForKey:@"AminoG"]).length > 0 ? [item objectForKey:@"AminoG"] : @"0", ((NSString *)[item objectForKey:@"MacroL"]).length > 0 ? [item objectForKey:@"MacroL"] : @"0"] forKeys:@[@"AminoG", @"MacroL"]];
                    [bDict setObject:resitance forKey:DICT_KEY(b++)];
                }
                if ([[item objectForKey:@"HealthStat"] isEqualToString:@"C"]) {
                    NSDictionary *resitance = [NSDictionary dictionaryWithObjects:@[((NSString *)[item objectForKey:@"AminoG"]).length > 0 ? [item objectForKey:@"AminoG"] : @"0", ((NSString *)[item objectForKey:@"MacroL"]).length > 0 ? [item objectForKey:@"MacroL"] : @"0"] forKeys:@[@"AminoG", @"MacroL"]];
                    [cDict setObject:resitance forKey:DICT_KEY(c++)];
                }
                if ([[item objectForKey:@"HealthStat"] isEqualToString:@"D"]) {
                    NSDictionary *resitance = [NSDictionary dictionaryWithObjects:@[((NSString *)[item objectForKey:@"AminoG"]).length > 0 ? [item objectForKey:@"AminoG"] : @"0", ((NSString *)[item objectForKey:@"MacroL"]).length > 0 ? [item objectForKey:@"MacroL"] : @"0"] forKeys:@[@"AminoG", @"MacroL"]];
                    [dDict setObject:resitance forKey:DICT_KEY(d++)];
                }
            }
            block(@[aDict, bDict, cDict, dDict]);
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[JSON objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(@[error]);
    }];
}

- (void) getPatientOutComeDataWithBlock:(void (^)(id data))block {
    [self startRestCallWithParam:@{@"req":PATIENT_OUTCOME_DATA, PATIENT_ID:self.patientid} success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"result"] isEqualToString:@"true"]) {
            NSArray *list = [JSON objectForKey:@"list"];
            NSMutableArray *dateArray = [NSMutableArray array];
            NSMutableArray *physicalArray = [NSMutableArray array];
            NSMutableArray *respiratoryArray = [NSMutableArray array];
            NSMutableArray *UCSD_SOBQArray = [NSMutableArray array];
            for(int i = 0; i < [list count]; i++){
                NSDictionary *item = [list objectAtIndex:i];
                [dateArray addObject:[item objectForKey:@"Date"]];
                [physicalArray addObject:[NSNumber numberWithDouble:[[item objectForKey:@"Physical"] doubleValue]]];
                [respiratoryArray addObject:[NSNumber numberWithDouble:[[item objectForKey:@"Respiratory"] doubleValue]]];
                [UCSD_SOBQArray addObject:[NSNumber numberWithDouble:[[item objectForKey:@"UCSD_SOBQ"] doubleValue]]];
            }
            block(@[dateArray, physicalArray, respiratoryArray, UCSD_SOBQArray]);
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[JSON objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(@[error]);
    }];
}

- (void) getPatientInfoData:(void (^)(id data))block {
    [self startRestCallWithParam:@{@"req":ANTIBIOTIC_RESISTANCE_DATA, PATIENT_ID:self.patientid} success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if ([[JSON objectForKey:@"result"] isEqualToString:@"true"]) {
            
        }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[JSON objectForKey:@"msg"]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        block(@[error]);
    }];
}


@end
