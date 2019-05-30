//
//  RHTableView.m
//  UITableViewDemo
//
//  Created by river on 2019/5/28.
//  Copyright © 2019 richinfo. All rights reserved.
//

#import "RHTableView.h"

@implementation RHTableView

- (void)layoutSubviews{
    
    [super layoutSubviews];
//此处可以判断是否需要显示滚动条，例如数据少的时候，不显示
    [self.subviews enumerateObjectsUsingBlock:^( id obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView = obj;
            imageView.alpha = 1 ;
        }
    }];
    UIView * view = [self.subviews lastObject];
    if (view.frame.origin.x < 0) {
        CGRect frame = view.frame;
        frame.origin.x = 0;
        view.frame = frame;
    }
    
}

@end
