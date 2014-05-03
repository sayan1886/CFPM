    //
    //  CFPMAppDelegate.h
    //  CFPM
    //
    //  Created by h.sayy on 5/1/14.
    //  Copyright (c) 2014 h.sayy. All rights reserved.
    //

#ifndef CFPM_CFPMConstants_h
#define CFPM_CFPMConstants_h

#import "CPTColor+CFPMExtension.h"

#define ANTI_BIOTIC @[@"Gentamicin", @"Tocramycin", @"CiProfloxacin", @"Piperacillin", @"Ceftazidime", @"Cefotaxime", @"Meropenem"]

#define  Escherichia_coli [CPTColor orangeColor]
#define  Streptococcus_parasanguinis [CPTColor merunColor]
#define  Rothia_mucilaginosa [CPTColor greenColor]
#define  Veillonellas_parvula [CPTColor yellowColor]
#define  Streptococcus_salivarius [CPTColor blueColor]
#define  Streptococcus_mitis [CPTColor cyanColor]
#define  Paracoccus_denitrificans [CPTColor magentaColor]
#define  Stentrophomonas_maltophilia [CPTColor purpleColor]
#define  Prevotella_melaninogenica [CPTColor brownColor]
#define  Rothia_dentocariosa [CPTColor redColor]
#define  Streptococcus_pneumoniae [CPTColor grayColor]
#define  Streptococcus_oralis [CPTColor darkGrayColor]
#define  Pseudomonas_aeruginosa [CPTColor violetColor]
#define Others [CPTColor whiteColor]

    //developer mode 0 , prodcution mode 1
#define PRODUCTION 0
    //To Use mock json from local bunlde use 0 and for remote call use 1
#define REMOTE_HOST_REACHABLE 1

#if PRODUCTION  // production version
    #define BASE_URL @"http://www.cfpmapp.org/mk_api/mk_phone.php"
#else //deve version
    #define BASE_URL @"http://192.168.1.100/mk_api/mk_phone.php"
#endif

#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif

    //construct web service path
static inline NSURL * REMOTEURL(NSDictionary *param){
    NSArray *keys = [param allKeys];
    NSString *urlString = [NSString stringWithFormat:@"%@?",BASE_URL];
    for (int i = 1; i <= [keys count]; i++) {
        if (i != [keys count]) {
            urlString = [NSString stringWithFormat:@"%@%@=%@&",urlString,[keys objectAtIndex:(i -1) ],[param objectForKey:[keys objectAtIndex:(i -1) ]]];
        }
        else{
            urlString = [NSString stringWithFormat:@"%@%@=%@",urlString,[keys objectAtIndex:(i -1) ],[param objectForKey:[keys objectAtIndex:(i -1) ]]];
        }
    }
    return[NSURL URLWithString:urlString];
}

    //color for Specise in pie chart

static inline CPTColor * COLOR(NSString *species){
    CPTColor *color = [CPTColor clearColor];
    if ([species isEqualToString:@"Escherichia coli"]) {
        color = Escherichia_coli;
    }
    else if ([species isEqualToString:@"Streptococcus parasanguinis"]) {
        color = Streptococcus_parasanguinis;
    }
    else if ([species isEqualToString:@"Rothia mucilaginosa"]) {
        color = Rothia_mucilaginosa;
    }
    else if ([species isEqualToString:@"Veillonellas parvula"]) {
        color = Veillonellas_parvula;
    }
    else if ([species isEqualToString:@"Streptococcus salivarius"]) {
        color = Streptococcus_salivarius;
    }
    else if ([species isEqualToString:@"Streptococcus mitis"]) {
        color = Streptococcus_mitis;
    }
    else if ([species isEqualToString:@"Paracoccus denitrificans"]) {
        color = Paracoccus_denitrificans;
    }
    else if ([species isEqualToString:@"Stentrophomonas maltophilia"]) {
        color = Stentrophomonas_maltophilia;
    }
    else if ([species isEqualToString:@"Prevotella melaninogenic"]) {
        color = Prevotella_melaninogenica;
    }
    else if ([species isEqualToString:@"Rothia dentocariosa"]) {
        color = Rothia_dentocariosa;
    }
    else if ([species isEqualToString:@"Streptococcus pneumoniae"]) {
       color =  Streptococcus_pneumoniae ;
    }
    else if ([species isEqualToString:@"Streptococcus oralis"]) {
        color = Streptococcus_oralis;
    }
    else if ([species isEqualToString:@"Pseudomonas aeruginosa"]) {
        color = Pseudomonas_aeruginosa;
    }
    else{
        color = Others;
    }
    return color;
}

    //param for webs service
#define PATIENT_INFO_DATA @"patient_info"

#define BAR_CHART_DATA @"bar_chart"

#define SCATTER_PLOT_DATA @"scatter_plot"

#define PIE_CHART_DATA @"pie_graph"

#define ANTIBIOTIC_RESISTANCE_DATA @"antibiotic_resistance"

#define PATIENT_OUTCOME_DATA @"patient_outcome"

#define PATIENT_ID @"patient_id"


    //Height and Width bar plot
#define BarWidth 60
#define BarHeight 200
    //color 
#define MERUN_COLOR  [UIColor colorWithRed:165.0f/255.0f green:65.0f/255.0f blue:43.0f/255.0f alpha:1.0]
#define YELLOW_COLOR  [UIColor colorWithRed:210.0f/255.0f green:180.0f/255.0f blue:80.0f/255.0f alpha:1.0]
#define ORANGE_COLOR  [UIColor colorWithRed:174.0f/255.0f green:114.0f/255.0f blue:60.0f/255.0f alpha:1.0]

#define ECOLI @"coli"
#define STREPTOCOCCUS @"Streptococcus"
#define P_AERUGINOSA @"aeruginosa"

    //Restistant Model Height and Width
#define RestistantChartWidth 150
#define RestistantChartHeight 165

#endif
