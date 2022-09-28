//
//  SwwNetworkManager.h
//  PersonalConsumeSave
//
//  Created by wbhsww on 2022/9/28.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SwwRequestType) {
    SwwRequestType_Get = 0,
    SwwRequestType_Post = 1,
    /*
     返回所有的头字段，与get请求得到的响应相同，但是没有响应体
     使用举例：在下载一个大文件之前，先获取其大小（头字段中可查看，需要后端增加Content-Length字段，单位是字节），再决定是否要下载，以此可以节约宽带资源
     */
    SwwRequestType_Head = 2,
};

@interface SwwNetworkManager : NSObject

+ (void)requestWithRequstType:(SwwRequestType)requestType requestUrl:(NSString *)url params:(nullable NSDictionary *)params success:(void (^)(id  responseObject))success failure:(void (^)(NSError * error))failure;
- (void)requestWithRequstType:(SwwRequestType)requestType requestUrl:(NSString *)url params:(nullable NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

// 上传图片
+ (void)uploadImageWithUrl:(NSString *)url params:(nullable NSDictionary *)params image:(NSData *)imgdata constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block uploadProgress:(void (^)(id progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;
- (void)uploadImageWithUrl:(NSString *)url params:(nullable NSDictionary *)params image:(NSData *)imgdata constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block uploadProgress:(void (^)(id progress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError * error))failure;

+ (instancetype _Nonnull)manager;
+ (void)attempDealloc;

@end

NS_ASSUME_NONNULL_END
