//
//  AntherView.h
//  BEToolsManager
//
//  Created by ihefe26 on 15/7/31.
//  Copyright (c) 2015年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol antherViewDelegate <NSObject>

-(BOOL)ishideView;

@end

typedef void(^sbbbbb)(BOOL success);

typedef BOOL (^learnBlock)(NSString *title);

@interface AntherView : UIView

@property (assign, nonatomic) id<antherViewDelegate> delegate;

@property (nonatomic ,strong)NSArray *arr;

@property (nonatomic, strong) learnBlock learnBlock;


@end
