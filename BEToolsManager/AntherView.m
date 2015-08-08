//
//  AntherView.m
//  BEToolsManager
//
//  Created by ihefe26 on 15/7/31.
//  Copyright (c) 2015年 zhangliang. All rights reserved.
//

#import "AntherView.h"

@implementation AntherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.frame = CGRectMake(0, 0, 100, 100);
        self.backgroundColor = [UIColor redColor];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 20,20)];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor greenColor];
        [self addSubview:btn];
    }
    [self nslogSomething:^(BOOL success) {
        NSLog(@"11111");
    }];
    return self;
}

-(void)nslogSomething:(sbbbbb)sbBlock
{
    _arr = [[NSArray alloc] initWithObjects:sbBlock, nil];
}


-(void)btnAction
{
    BOOL ishide =  [_delegate ishideView];
    BOOL isti =  self.learnBlock(@"learnBlock....");
}


@end
