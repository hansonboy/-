//
//  main.m
//  Regex 正则表达式
//
//  Created by wangjianwei on 16/1/18.
//  Copyright © 2016年 JW. All rights reserved.
//
#ifdef  DEBUG
#define JWLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define JWLog(xx, ...)
#endif
#import <Foundation/Foundation.h>
#import "RegexKitLite.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {

        NSString *str = [NSString stringWithFormat:@"[@哈-哈]AS#adf#F[哈哈]ASF[哈哈]#adf@asfadfjoipwe2341-422q1wr25341weqr1你好#http://asfasfopewiq.com"];
        //要使用\\进行转移
        
        NSString *emotionPattern = @"\\[[\u2E80-\u9FFF]*\\]";
        NSString *atPattern = @"@[\\w-]+";
        NSString *topicPattern = @"#[\\w-]+#";
        NSString *urlPattern = @"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
        NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",topicPattern,emotionPattern,atPattern,urlPattern];
        JWLog(@"%@",[str stringByMatching:pattern]);
        [str enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
            JWLog(@"%ld--%@---%@",captureCount,*capturedStrings,NSStringFromRange(*capturedRanges));
        }];
        
    }
    return 0;
}
void testRegex(){
    NSString *str = [NSString stringWithFormat:@"[@哈-哈]AS#adf#F[哈哈]ASF[哈哈]#adf@asfadfjoipwe2341-422q1wr25341weqr1你好#http://asfasfopewiq.com"];
    //要使用\\进行转移
    
    NSString *emotionPattern = @"\\[[\u2E80-\u9FFF]*\\]";
    NSString *atPattern = @"@[\\w-]+";
    NSString *topicPattern = @"#[\\w-]+#";
    NSString *urlPattern = @"(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@",topicPattern,emotionPattern,atPattern,urlPattern];
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray * result = [expression matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    [result enumerateObjectsUsingBlock:^(NSTextCheckingResult* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JWLog(@"%@---%@",NSStringFromRange(obj.range),[str substringWithRange:obj.range]);
    }];
}