//
//  BaseSkeletonView.h
//  VegaFintech
//
//  Created by tran dinh thong on 8/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

#ifndef BaseSkeletonView_h
#define BaseSkeletonView_h

#import <UIKit/UIKit.h>

@interface BaseSkeletonView : UIView

- (void)setLoading:(BOOL)loading;

//@property (assign, nonatomic, getter=isLoading) BOOL loading;
@end

#endif /* BaseSkeletonView_h */
