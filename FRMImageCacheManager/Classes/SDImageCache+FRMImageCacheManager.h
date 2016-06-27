//
//  SDImageCache+FarmisCatalog.h
//  Farmis
//
//  Created by Vilmantas on 05/05/16.
//  Copyright © 2016 Rento Media. All rights reserved.
//

#import "SDImageCache.h"

@interface SDImageCache (FRMImageCacheManager)
+ (SDImageCache *)sharedImageCacheWithNamespace:(NSString *)ns;
@end
