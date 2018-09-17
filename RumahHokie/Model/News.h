//
//  News.h
//  RumahHokie
//
//  Created by Hadron Megantara on 17/09/18.
//  Copyright © 2018 Hadron Megantara. All rights reserved.
//

#ifndef News_h
#define News_h

@interface News : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSURL *image;
@property (nonatomic, retain) NSURL *imageList;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *deskripsi;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *cookie;

@end

#endif /* News_h */
