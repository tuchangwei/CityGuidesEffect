//
//  VLSCrollView.h
//  Weather
//
//  Created by vale on 8/12/14.
//  Copyright (c) 2014 Vale. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VLSCrollViewDelegate

-(void)completeLayoutSubView;

@end
@interface VLSCrollView : UIScrollView
@property (nonatomic,weak) id <VLSCrollViewDelegate> delegate1;
@end
