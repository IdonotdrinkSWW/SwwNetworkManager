//
//  SwwNetworkManager.m
//  PersonalConsumeSave
//
//  Created by wbhsww on 2022/9/28.
//

#import "SwwNetworkManager.h"

@implementation SwwNetworkManager

static SwwNetworkManager *_manager = nil;
static dispatch_once_t onceToken;

static AFHTTPSessionManager *_httpManager = nil;

+ (void)requestWithRequstType:(SwwRequestType)requestType requestUrl:(NSString *)url params:(nullable NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure {
    [[self manager] requestWithRequstType:requestType requestUrl:url params:params success:success failure:failure];
}

- (void)requestWithRequstType:(SwwRequestType)requestType requestUrl:(NSString *)url params:(nullable NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure {
    switch (requestType) {
        case SwwRequestType_Get: {
            [_httpManager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id response = [self __parseDataWithTask:task data:responseObject];
                success(response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
        case SwwRequestType_Post: {
            [_httpManager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                id response = [self __parseDataWithTask:task data:responseObject];
                success(response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
        case SwwRequestType_Head: {
            [_httpManager HEAD:url parameters:params headers:nil success:^(NSURLSessionDataTask * _Nonnull task) {
                if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    success(response.allHeaderFields);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
        default:
            break;
    }
}

+ (void)uploadImageWithUrl:(NSString *)url params:(nullable NSDictionary *)params image:(NSData *)imgdata constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block uploadProgress:(void (^)(id progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure {
    [[self manager] uploadImageWithUrl:url params:params image:imgdata constructingBodyWithBlock:block uploadProgress:progress success:success failure:failure];
}
- (void)uploadImageWithUrl:(NSString *)url params:(NSDictionary *)params image:(NSData *)imgdata constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block uploadProgress:(void (^)(id progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure {
    [_httpManager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

- (id)__parseDataWithTask:(NSURLSessionDataTask * _Nonnull)task data:(id )data {
    NSError *error;
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    NSDictionary *jsonDic = [serializer responseObjectForResponse:task.response data:data error:&error];
    if (!error) {
        // ????????????json???????????????
        return jsonDic;
    } else {
        NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return stringData;
    }
}

+ (instancetype)manager {
    dispatch_once(&onceToken, ^{
        //???????????????allocWithZone,????????????self?????????????????????
        _manager = [[super allocWithZone:NULL] init];
        
        _httpManager = [AFHTTPSessionManager manager];
        _httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _httpManager.requestSerializer.timeoutInterval = 30;
//        [_mgr.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"charset=utf-8", nil];
    });
    return _manager;
}

//???????????????????????????????????????????????????alloc???????????????????????????init???????????????
//alloc?????????allocWithZone?????????????????????????????????sharedInstance???????????????alloc
//??????alloc????????????allocWithZone???????????????????????????sharedInstance??????alloc??????????????????????????????
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self manager];
}

//???????????????copy
- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

+ (void)attempDealloc {
    onceToken = 0; // ????????????0,GCD??????????????????????????????.????????????0.????????????????????????????????????shareInstance?????????,??????????????????.
    _manager = nil;
    _httpManager = nil;
}



@end
