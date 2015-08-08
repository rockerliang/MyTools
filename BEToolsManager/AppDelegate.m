//
//  AppDelegate.m
//  BEToolsManager
//
//  Created by ihefe26 on 15/7/31.
//  Copyright (c) 2015年 zhangliang. All rights reserved.
//

#import "AppDelegate.h"
#import "BEToolsSinglton.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.i
    isOut = NO;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSString *cache = [[BEToolsSinglton getInstance] getCaches];
    
    BOOL isHasfile = [[BEToolsSinglton getInstance] isExistsForTargetFile:[NSString stringWithFormat:@"%@/%@",cache,@"aa.txt"]];
    if(isHasfile)
    {
        [self gotoMain];
    }else
    {
        [self gotoYindao];
    }
    return YES;
}

-(void)gotoMain
{
   // self.window.rootViewController =
    //如果第一次进入没有文件，我们就创建这个文件
    
    NSString *cache = [[BEToolsSinglton getInstance] getCaches];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    BOOL isHasfile = [[BEToolsSinglton getInstance] isExistsForTargetFile:[NSString stringWithFormat:@"%@/%@",cache,@"aa.txt"]];    //判断 我是否创建了文件，如果没创建 就创建这个文件（这种情况就运行一次，也就是第一次启动程序的时候）
    NSString *path1 = [NSString stringWithFormat:@"%@/%@",cache,@"aa.txt"];
    if (!isHasfile) {
        
        [manager createFileAtPath:path1 contents:nil attributes:nil];
    }
    ViewController *cont = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = cont;
}
-(void)gotoYindao
{
    NSArray *arr = [NSArray arrayWithObjects:@"ihefe",@"ihefe_rec",@"ihefe_biaoge", nil];
    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    scr.contentSize = CGSizeMake(self.window.frame.size.width * arr.count, self.window.frame.size.height);
    scr.pagingEnabled = YES;
    scr.delegate = self;
    [self.window addSubview:scr];
    for(int i = 0; i< arr.count; i ++)
    {
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.window.frame.size.width, 0, self.window.frame.size.width, self.window.frame.size.height)];
        imgview.image = [UIImage imageNamed:arr[i]];
        [scr addSubview:imgview];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self beingBackgroundUpdateTask];
    // 在这里加上你需要长久运行的代码
   // [self endBackgroundUpdateTask];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)beingBackgroundUpdateTask
{
    for (int i = 0; i < 20 ; i ++) {
        NSLog(@"%d",i);
    }
}

- (void)endBackgroundUpdateTask
{
    NSLog(@"the end");
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}


#pragma mark scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //这里是在滚动的时候判断 我滚动到哪张图片了，如果滚动到了最后一张图片，那么
    //如果在往下面滑动的话就该进入到主界面了，我这里利用的是偏移量来判断的，当
    //一共五张图片，所以当图片全部滑完后 又像后多滑了30 的时候就做下一个动作
    if (scrollView.contentOffset.x>2*self.window.frame.size.width+10) {
        
        [UIView animateWithDuration:1.5 animations:^{
            scrollView.alpha=0;//让scrollview 渐变消失
            
        }completion:^(BOOL finished) {
            [scrollView  removeFromSuperview];//将scrollView移除
            [self gotoMain];//进入主界面
            
        } ];

        
    }
}


@end
