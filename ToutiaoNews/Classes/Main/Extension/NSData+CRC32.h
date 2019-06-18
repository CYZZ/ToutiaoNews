//
//  NSData+CRC32.h
//  ToutiaoNews
//
//  Created by chiyz on 2019/6/18.
//  Copyright © 2019 chiyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRC32)

-(int32_t)crc_32;

-(uLong)getCRC32;

@end

NS_ASSUME_NONNULL_END
