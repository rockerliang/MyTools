//
//  ViewController.h
//  BEToolsManager
//
//  Created by ihefe26 on 15/7/31.
//  Copyright (c) 2015年 zhangliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AntherView.h"


@interface ViewController : UIViewController <antherViewDelegate>
{
    UIColor *viewColor;
}


@property (weak, nonatomic) IBOutlet UIButton *btn1;

- (IBAction)duoxianchengBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (assign,nonatomic) NSInteger a;

@end

