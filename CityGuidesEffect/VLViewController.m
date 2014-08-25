//
//  VLViewController.m
//  CityGuidesEffect
//
//  Created by vale on 8/25/14.
//  Copyright (c) 2014 vale. All rights reserved.
//

#import "VLViewController.h"
#import "VLSCrollView.h"
@interface VLViewController ()<VLSCrollViewDelegate>
@property (weak, nonatomic) IBOutlet VLSCrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic) BOOL isScrollingByHand;
@end

@implementation VLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.scrollView.delegate1 = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark - VLSCrollViewDelegate
-(void)completeLayoutSubView
{
    if (self.isScrollingByHand)
    {
        CGRect visibleBounds = [self.scrollView convertRect:[self.scrollView bounds] toView:self.containerView];
        [self adjustCoverViewsTransformWithVisibleBounds:visibleBounds];
    }
    else
    {
        self.isScrollingByHand = YES;
    }
   
}
- (void)adjustCoverViewsTransformWithVisibleBounds:(CGRect)visibleBounds {
    float coverAngle = M_PI_4;
    // adjust scale and transform of all the visible views
    CGFloat visibleBoundsCenterX = CGRectGetMidX(visibleBounds);
    for (UIView *cityWeatherView in self.containerView.subviews) {
        
        
        UIView *coverView = cityWeatherView;
        
        CGFloat distance = coverView.center.x - visibleBoundsCenterX;
        CGFloat distanceThreshold = cityWeatherView.frame.size.width;
        if (distance <= -distanceThreshold) {
            
            coverView.layer.transform = [self transform3DWithRotation:coverAngle scale:1.0 perspective:(-1.0/500.0)];
            coverView.layer.zPosition = -10000.0;
            
            
        } else if (distance < 0.0 && distance > -distanceThreshold) {
            
            CGFloat percentage = fabsf(distance)/distanceThreshold;
            coverView.layer.transform = [self transform3DWithRotation:coverAngle*percentage scale:1.0 perspective:(-1.0/500.0)];
            coverView.layer.zPosition = -10000.0;
            
        } else if (distance == 0.0) {
            
            coverView.layer.transform = [self transform3DWithRotation:0.0 scale:1.0 perspective:(1.0/500.0)];
            coverView.layer.zPosition = 10000.0;
            
        } else if (distance > 0.0 && distance < distanceThreshold) {
            
            CGFloat percentage = fabsf(distance)/distanceThreshold;
            coverView.layer.transform = [self transform3DWithRotation:-coverAngle*percentage scale:1.0 perspective:(-1.0/500.0)];
            coverView.layer.zPosition = -10000.0;
            
        } else if (distance >= distanceThreshold) {
            
            coverView.layer.transform = [self transform3DWithRotation:-coverAngle scale:1.0 perspective:(-1.0/500.0)];
            coverView.layer.zPosition = -10000.0;
      
        }
        
    }
}

- (CATransform3D)transform3DWithRotation:(CGFloat)angle
                                   scale:(CGFloat)scale
                             perspective:(CGFloat)perspective {
    CATransform3D rotateTransform = CATransform3DIdentity;
    rotateTransform.m34 = perspective;
    //绕y轴旋转
    rotateTransform = CATransform3DRotate(rotateTransform, angle, 0.0, 1.0, 0.0);
    //绕z轴旋转
    rotateTransform = CATransform3DRotate(rotateTransform, -angle*0.2, 0.0f,0.0f, 1.0f);
    
    rotateTransform = CATransform3DTranslate(rotateTransform, 0, angle>0?angle*120:angle*-120,  0.0f);
    
    CATransform3D scaleTransform = CATransform3DIdentity;
    //缩放xy平面
    scaleTransform = CATransform3DScale(scaleTransform, scale, scale, 1.0);
    
    return CATransform3DConcat(rotateTransform, scaleTransform);
}
@end
