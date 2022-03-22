////
////  UIView+Skeleton.m
////  VegaFintech
////
////  Created by tran dinh thong on 8/9/21.
////  Copyright © 2021 Vega. All rights reserved.
////
//
//#import "UIView+Skeleton.h"
//
//@interface UIView (Skeleton)
//
///**
// * If this is YES, then the skeleton loading layers and animation need to be shown.
// * If this is NO, then the normal view should be shown. No skeleton loading layers should be shown.
// */
//
//
//@end
//
//@implementation UIView (Skeleton)
//
//- (NSArray<__kindof UIView *> *)loadableSubviews {
//    NSMutableArray<UIView *> *views = [[NSMutableArray alloc] init];
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[UILabel class]]) {
//            [views addObject:view];
//        } else if ([view isKindOfClass:[UIImageView class]]) {
//            [views addObject:view];
//        }
//    }
//    return views;
//}
//
//- (void)setLoading:(BOOL)loading {
//    //self->_loading = loading;
//    
//    //[self rectWithTwoPoints:CGPointZero andWith:CGPointZero];
//    //self.loading123 = YES;
//    //UIView *v = [[UIView alloc] init];
//    //CGRect rg = [v rectWithTwoPoints:CGPointZero andWith:CGPointZero];
//    
//    
//    NSArray<__kindof UIView *> *loadingViews = [self loadableSubviews];
//    
//    //if (loading) {
//        //display the skeleton loading layers
//
//        UIColor *backgroundColor = [UIColor colorWithRed:(210.0/255.0) green:(210.0/255.0) blue:(210.0/255.0) alpha:1.0];
//        UIColor *highlightColor = [UIColor colorWithRed:(235.0/255.0) green:(235.0/255.0) blue:(235.0/255.0) alpha:1.0];
//        CALayer *skeletonLayer = [CALayer layer];
//        skeletonLayer.backgroundColor = backgroundColor.CGColor;
//        skeletonLayer.name = @"skeletonLayer";
//        skeletonLayer.anchorPoint = CGPointZero;
//        skeletonLayer.frame = UIScreen.mainScreen.bounds;
//        
//        for (UIView *loadingView in loadingViews) {
//            CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
//            
//            //gradientLayer.colors = @[backgroundColor, highlightColor, backgroundColor];
//            
//            gradientLayer.colors = @[(id)backgroundColor.CGColor, (id)highlightColor.CGColor, (id)backgroundColor.CGColor];
//            
//            
//            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
//            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
//            gradientLayer.frame = UIScreen.mainScreen.bounds;
//            gradientLayer.name = @"skeletonGradient";
//            
//            loadingView.layer.mask = skeletonLayer;
//            [loadingView.layer addSublayer:skeletonLayer];
//            [loadingView.layer addSublayer:gradientLayer];
//            loadingView.clipsToBounds = YES;
//            
//            CGFloat width = UIScreen.mainScreen.bounds.size.width;
//            
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//            animation.duration = 3.0;
//
//            //TODO: is there maybe something wrong with the y coordinate here?
//            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-width, gradientLayer.frame.origin.y)];
//            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(width, gradientLayer.frame.origin.y)];
//            animation.repeatCount = CGFLOAT_MAX;
//            animation.autoreverses = NO;
//            animation.fillMode = kCAFillModeForwards;
//            
//            [gradientLayer addAnimation:animation forKey:@"gradientShimmer"];
//        }
////    } else {
////        //remove the skeleton loading layers
////
////        for (UIView *loadingView in loadingViews) {
////            for (NSInteger x = loadingView.layer.sublayers.count - 1; x >= 0; x--) {
////                CALayer *sublayer = loadingView.layer.sublayers[x];
////                if ([sublayer.name isEqualToString:@"skeletonLayer"] || [sublayer.name isEqualToString:@"skeletonGradient"]) {
////                    [sublayer removeFromSuperlayer];
////                }
////            }
////        }
////    }
//}
//
//
////
////
////- (void)setLoading:(BOOL)loading1 {
////    //self->_
////    self.loading = loading1;
////
////    NSArray<__kindof UIView *> *loadingViews = [self loadableSubviews];
////
////    if (self.loading) {
////        //display the skeleton loading layers
////
////        UIColor *backgroundColor = [UIColor colorWithRed:(210.0/255.0) green:(210.0/255.0) blue:(210.0/255.0) alpha:1.0];
////        UIColor *highlightColor = [UIColor colorWithRed:(235.0/255.0) green:(235.0/255.0) blue:(235.0/255.0) alpha:1.0];
////        CALayer *skeletonLayer = [CALayer layer];
////        skeletonLayer.backgroundColor = backgroundColor.CGColor;
////        skeletonLayer.name = @"skeletonLayer";
////        skeletonLayer.anchorPoint = CGPointZero;
////        skeletonLayer.frame = UIScreen.mainScreen.bounds;
////
////        for (UIView *loadingView in loadingViews) {
////            CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
////
////            //gradientLayer.colors = @[backgroundColor, highlightColor, backgroundColor];
////
////            gradientLayer.colors = @[(id)backgroundColor.CGColor, (id)highlightColor.CGColor, (id)backgroundColor.CGColor];
////
////
////            gradientLayer.startPoint = CGPointMake(0.0, 0.5);
////            gradientLayer.endPoint = CGPointMake(1.0, 0.5);
////            gradientLayer.frame = UIScreen.mainScreen.bounds;
////            gradientLayer.name = @"skeletonGradient";
////
////            loadingView.layer.mask = skeletonLayer;
////            [loadingView.layer addSublayer:skeletonLayer];
////            [loadingView.layer addSublayer:gradientLayer];
////            loadingView.clipsToBounds = YES;
////
////            CGFloat width = UIScreen.mainScreen.bounds.size.width;
////
////            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
////            animation.duration = 3.0;
////
////            //TODO: is there maybe something wrong with the y coordinate here?
////            animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-width, gradientLayer.frame.origin.y)];
////            animation.toValue = [NSValue valueWithCGPoint:CGPointMake(width, gradientLayer.frame.origin.y)];
////            animation.repeatCount = CGFLOAT_MAX;
////            animation.autoreverses = NO;
////            animation.fillMode = kCAFillModeForwards;
////
////            [gradientLayer addAnimation:animation forKey:@"gradientShimmer"];
////        }
////    } else {
////        //remove the skeleton loading layers
////
////        for (UIView *loadingView in loadingViews) {
////            for (NSInteger x = loadingView.layer.sublayers.count - 1; x >= 0; x--) {
////                CALayer *sublayer = loadingView.layer.sublayers[x];
////                if ([sublayer.name isEqualToString:@"skeletonLayer"] || [sublayer.name isEqualToString:@"skeletonGradient"]) {
////                    [sublayer removeFromSuperlayer];
////                }
////            }
////        }
////    }
////}
//
//- (CGRect)rectWithTwoPoints:(CGPoint)p1 andWith:(CGPoint)p2 {
//    return CGRectMake(MIN(p1.x, p2.x), MIN(p1.y, p2.y), fabs(p1.x - p2.x), fabs(p1.y - p2.y));
//}
//@end
