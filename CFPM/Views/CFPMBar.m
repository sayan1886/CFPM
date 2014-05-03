//
//  CFPMBar.m
//  CFPM
//
//  Created by h.sayy on 16/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMBar.h"
#import "PopOverView.h"

@implementation CFPMBar

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMBarChart" owner:self options:nil];
    self = [nibViews objectAtIndex:1];
    [self setFrame:frame];
    [self setAutoresizesSubviews:YES];
    if (self) {
        // Initialization code
        [self addTapGesture];
    }
    return self;
}

- (void) addTapGesture {
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture1 setNumberOfTapsRequired:1];
    [tapGesture1 setNumberOfTouchesRequired:1];
    [[self medicine1] addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture2 setNumberOfTapsRequired:1];
    [tapGesture2 setNumberOfTouchesRequired:1];
    [[self medicine2] addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture3 setNumberOfTapsRequired:1];
    [tapGesture3 setNumberOfTouchesRequired:1];
    [[self medicine3] addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture4 setNumberOfTapsRequired:1];
    [tapGesture4 setNumberOfTouchesRequired:1];
    [[self medicine4] addGestureRecognizer:tapGesture4];
    
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture5 setNumberOfTapsRequired:1];
    [tapGesture5 setNumberOfTouchesRequired:1];
    [[self medicine5] addGestureRecognizer:tapGesture5];
    
    UITapGestureRecognizer *tapGesture6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture6 setNumberOfTapsRequired:1];
    [tapGesture6 setNumberOfTouchesRequired:1];
    [[self medicine6] addGestureRecognizer:tapGesture6];
    
    UITapGestureRecognizer *tapGesture7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture7 setNumberOfTapsRequired:1];
    [tapGesture7 setNumberOfTouchesRequired:1];
    [[self medicine7] addGestureRecognizer:tapGesture7];
}

//- (id) initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        // Initialization code
////        [[NSBundle mainBundle] loadNibNamed:@"CustomView" owner:self options:nil];
////        [self addSubview:self.toplevelSubView];
//    }
//    return self;
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
    NSString *medicine = @"";
    switch ([sender view].tag) {
        case 100:
            medicine = [ANTI_BIOTIC objectAtIndex:6];
            break;
        case 101:
            medicine = [ANTI_BIOTIC objectAtIndex:5];
            break;
        case 102:
            medicine = [ANTI_BIOTIC objectAtIndex:4];
            break;
        case 103:
            medicine = [ANTI_BIOTIC objectAtIndex:3];
            break;
        case 104:
            medicine = [ANTI_BIOTIC objectAtIndex:2];
            break;
        case 105:
            medicine = [ANTI_BIOTIC objectAtIndex:1];
            break;
        case 106:
            medicine = [ANTI_BIOTIC objectAtIndex:0];
            break;
            
        default:
            break;
    }
    [PopoverView showPopoverAtPoint:[[sender view] center] inView:self withTitle:nil withStringArray:@[medicine] delegate:nil];
}
@end
