//
//  PCKIndexedItems.h
//  PackingCheck
//
//  Created by nanfang on 8/27/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PCKIndexedItems : NSObject
-(id) initWithItems:(NSArray*)items;
-(NSArray*) indexNames;
-(int)indexOfName:(NSString*)name;
-(NSArray*) itemsAtIndexNumber:(int)indexNumber;
-(NSArray*) itemsAtIndexName:(NSString*)indexName;

@end
