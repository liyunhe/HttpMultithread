//
//  YH_HttpTool.m
//  HttpMultithreaded
//
//  Created by Yun-He-Lee on 15/12/18.
//  Copyright © 2015年 Yun-He-Lee. All rights reserved.
//

#import "YH_HttpTool.h"
#import <UIKit/UIKit.h>
@implementation YH_HttpTool
//post Request
+(void)postRequstUrl:(NSString *)url RequestParams:(NSDictionary *)params Success:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))block{
    
//    dispatch_queue_t w = dispatch_queue_create(<#const char *label#>, <#dispatch_queue_attr_t attr#>);
    
    
   dispatch_queue_t q = dispatch_queue_create("chuanXing", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        NSURL *URL = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        
        NSString *parseParamsResult = [self parseParams:params];
        NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        NSOperationQueue *queue = [NSOperationQueue new];
            //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
        [NSURLConnection sendAsynchronousRequest:request
                                               queue:queue
                                   completionHandler:block];
                     });

    //设置Hppt Header
//     request addValue:<#(nonnull NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>
//    NSOperationQueue *queue = [NSOperationQueue new];
//    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:queue
//                           completionHandler:block];
}
// set parms
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        NSLog(@"post()方法参数解析结果：%@",result);
    }
    return result;
}
@end
