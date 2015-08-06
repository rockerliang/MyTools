//
//  BEToolsSinglton.h
//  IHFMedicImageNew
//
//  Created by ihefe26 on 15/7/30.
//  Copyright (c) 2015年 ihefe－hlh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKHttpClient.h"
#import "Reachability.h"

@interface BEToolsSinglton : NSObject

+ (instancetype)getInstance;

//获取当前时间  return:nsstring
-(NSString *)getNowDate;

//判断路径是否存在某文件
-(BOOL)isExistsForTargetFile:(NSString*)filePath;

//获取沙盒caches路径
-(NSString *)getCaches;

//删除路径文件/路径下所有文件
-(BOOL)deleteFilaByFilePath:(NSString *)filePath;

//根据传入的view截图,返回图片
-(UIImage *)capImageByView:(UIView *)capView;

//http 网络请求Get 根据条件Str1查询url满足str1条件下的所有str2字段
-(void)HtttpGet:(NSString *)url andCondition1:(NSString *)str1 andCondition1:(NSString *)str2;

//图片和NSdata转换 (NSdata转字符串返回)
-(NSString *)imageChangeToData:(UIImage *)image;

//判断网络连接状态
-(NSString *)canConnectNet;





@end
