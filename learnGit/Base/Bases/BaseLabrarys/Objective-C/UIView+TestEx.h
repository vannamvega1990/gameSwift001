//
//  UIView+TestEx.h
//  VegaFintech
//
//  Created by tran dinh thong on 8/9/21.
//  Copyright © 2021 Vega. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView ()

- (CGRect)rectWithTwoPoints:(CGPoint)p1 andWith:(CGPoint)p2 {
    return CGRectMake(MIN(p1.x, p2.x), MIN(p1.y, p2.y), fabs(p1.x - p2.x), fabs(p1.y - p2.y));
}

- (NSArray<__kindof UIView *> *)loadableSubviews {
    NSMutableArray<UIView *> *views = [[NSMutableArray alloc] init];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [views addObject:view];
        } else if ([view isKindOfClass:[UIImageView class]]) {
            [views addObject:view];
        }
    }
    return views;
}

@end

//@implementation UIView ()
//
//
//
//@end

NS_ASSUME_NONNULL_END
