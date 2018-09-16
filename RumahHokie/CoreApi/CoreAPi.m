//
//  CoreAPi.m
//  RumahHokie
//
//  Created by Hadron Megantara on 16/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef enum
{
    CoreApiMethodGET = 0,
    CoreApiMethodPOST,
    CoreApiMethodPUT,
    CoreApiMethodDELETE
} CoreApiMethod;

@interface CoreApi : NSObject

+ (AFHTTPSessionManager *) genericGETRequestTo:(NSString *)url
                                         param:(NSDictionary *)param
                                        header:(NSDictionary *)header
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSString *message))failure;

+ (AFHTTPSessionManager *) genericPOSTRequestTo:(NSString *)url
                                          param:(NSDictionary *)param
                                         header:(NSDictionary *)header
                                     serializer:(id)serializer
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSString *message))failure;

+ (AFHTTPSessionManager *) genericPUTRequestTo:(NSString *)url
                                         param:(NSDictionary *)param
                                        header:(NSDictionary *)header
                                    serializer:(id)serializer
                                       success:(void (^)(id responseObject))success
                                       failure:(void (^)(NSString *message))failure;

+ (AFHTTPSessionManager *) genericDELETERequestTo:(NSString *)url
                                            param:(NSDictionary *)param
                                           header:(NSDictionary *)header
                                       serializer:(id)serializer
                                          success:(void (^)(id responseObject))success
                                          failure:(void (^)(NSString *message))failure;

@end

@class CoreApiInterface;
@protocol CoreApiInterfaceDelegate

- (void) coreApiInterface:(CoreApiInterface *)interface finish:(id)result;
- (void) coreApiInterface:(CoreApiInterface *)interface failed:(NSString *)message;

@end

@interface CoreApiInterface : NSObject

@property (nonatomic, retain) NSString *rawPath;
@property (nonatomic, retain) NSString *path;
@property (nonatomic, retain) AFHTTPSessionManager *currentManager;
@property (nonatomic, retain) id <CoreApiInterfaceDelegate> delegate;
@property (nonatomic) BOOL onGoing;
@property (nonatomic) CoreApiMethod method;
@property (nonatomic, retain) id rawResult;

+ (id) instance;

- (void) start;
- (void) stop;
- (NSDictionary *)param;
- (NSDictionary *)header;
- (id)serializer;
- (void) onSuccess:(id)result;
- (void) onFailed:(NSString *)message;

@end
