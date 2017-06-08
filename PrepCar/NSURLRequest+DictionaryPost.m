


#import "NSURLRequest+DictionaryPost.h"
#import "JSON.h"
@implementation NSURLRequest (DictionaryPost)

+ (NSURLRequest *)postRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"Get"];
    if (parameters!=nil) {
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        NSString *jsonString = [jsonWriter stringWithObject:parameters];
        [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return request;
}


+ (NSURLRequest *)postRequestWithURLNew:(NSURL *)url parameters:(NSDictionary *)parameters {
    
    NSMutableString *body = [NSMutableString string];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    for (NSString *key in parameters) {
        NSString *val = [parameters objectForKey:key];
        if ([body length])
            [body appendString:@"&"];
        [body appendFormat:@"%@=%@", [[key description] urlEncodedUTF8String],
         [[val description] urlEncodedUTF8String]];
    }
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}


@end
