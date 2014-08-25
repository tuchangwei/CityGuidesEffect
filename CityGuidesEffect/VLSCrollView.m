//
//  VLSCrollView.m
//  Weather
//
//  Created by vale on 8/12/14.
//  Copyright (c) 2014 Vale. All rights reserved.
//

#import "VLSCrollView.h"

@implementation VLSCrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self.delegate1 completeLayoutSubView];
    
}
@end
