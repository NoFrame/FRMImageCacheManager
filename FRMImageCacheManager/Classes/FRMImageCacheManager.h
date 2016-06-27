//
//  ImageCacheManager.h
//  Farmis
//
//  Created by Vilmantas on 05/05/16.
//  Copyright © 2016 Rento Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FRMImageCacheNamespaceType.h"
@import SDWebImage;

@interface FRMImageCacheManager : NSObject

@property (strong, nonatomic) SDImageCache *iCache;
@property (strong, nonatomic) SDWebImageDownloader *iDownloader;

- (instancetype)initWithType:(FRMImageCacheNamespace)type;

+ (void)performImageFetchWithUrl:(id)url WithType:(FRMImageCacheNamespace)type ProgressBlock:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock CompletionBlock:(void (^)(BOOL success, UIImage *image))completionBlock;

- (void)performImageFetchWithUrl:(id)url ProgressBlock:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock CompletionBlock:(void (^)(BOOL success, UIImage *image))completionBlock;

@end
