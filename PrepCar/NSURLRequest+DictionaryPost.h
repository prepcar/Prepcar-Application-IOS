

#import <Foundation/Foundation.h>

@interface NSURLRequest (DictionaryPost)

+ (NSURLRequest *)postRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters;
+ (NSURLRequest *)postRequestWithURLNew:(NSURL *)url parameters:(NSDictionary *)parameters;
@end

@interface NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String;

@end

@implementation NSString (URLEncoding)

- (NSString *)urlEncodedUTF8String {
    return (id)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(0, (CFStringRef)self, 0,
                                                                         (CFStringRef)@";/?:@&=$+{}<>,", kCFStringEncodingUTF8));
}

@end