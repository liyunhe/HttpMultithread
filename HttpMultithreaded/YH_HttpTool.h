//
//  YH_HttpTool.h
//  HttpMultithreaded
//
//  Created by Yun-He-Lee on 15/12/18.
//  Copyright © 2015年 Yun-He-Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YH_HttpTool : NSObject
+(void)postRequstUrl:(NSString *)url RequestParams:(NSDictionary *)params Success:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))block;
@end
