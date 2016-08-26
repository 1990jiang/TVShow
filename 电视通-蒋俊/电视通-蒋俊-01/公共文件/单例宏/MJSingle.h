//
//  MJSingle.h
//  FMDB和单例的结合使用
//
//  Created by 蒋俊 on 16/7/2.
//  Copyright © 2016年 蒋俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"


@interface MJSingle : NSObject

/**数据库实例*/
@property (nonatomic , strong) FMDatabase *db;



singleton_h(MJSingle)

@end
