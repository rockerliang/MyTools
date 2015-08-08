//
//  ViewController.m
//  BEToolsManager
//
//  Created by ihefe26 on 15/7/31.
//  Copyright (c) 2015年 zhangliang. All rights reserved.
//

#import "ViewController.h"
#import "BEToolsSinglton.h"

@interface ViewController ()
{
    AntherView *a;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

     a = [[AntherView alloc] init];
    a.frame = CGRectMake(100, 100, 100, 100);
    a.delegate = self;
    [self.view addSubview:a];
    
    [self setValue:[UIColor redColor] forKey:@"viewColor"];
    [self addObserver:self forKeyPath:@"viewColor" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.view1.backgroundColor = [self valueForKey:@"viewColor"];
     
    
    a.learnBlock = ^(NSString *title)
    {
        NSLog(@"%@-----",title);
        return YES;
    };

  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)todoSomething
{
    if(_btn1.selected)
    {
        NSLog(@"防止多次点击");
        return;
    }
    _btn1.selected = YES;
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
        dispatch_async(dispatch_get_main_queue(), ^{
            [_btn1 setTitle:@"4444" forState:UIControlStateNormal];
            [self setValue:[UIColor greenColor] forKey:@"viewColor"];
            _btn1.selected = NO;
        });
        
    });
    NSLog(@"3");
    _view1.backgroundColor = [UIColor greenColor];
    [_btn1 setTitle:@"33333" forState:UIControlStateNormal];
    
    
    sbbbbb aa = a.arr[0];
    aa(YES);
}


- (IBAction)duoxianchengBtn:(id)sender {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething) object:nil];
    [self performSelector:@selector(todoSomething) withObject:nil afterDelay:1.0f];
   }

-(BOOL)ishideView
{
    NSLog(@"something....OK");
    return YES;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"viewColor"])
    {
        self.view1.backgroundColor = [self valueForKey:@"viewColor"];
    }
}
@end
