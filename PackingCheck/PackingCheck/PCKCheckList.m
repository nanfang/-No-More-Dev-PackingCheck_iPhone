//
//  PCKCheckList.m
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 tukeQ.com. All rights reserved.
//

#import "PCKCheckList.h"

@implementation PCKCheckList
@synthesize name=_name, listId=_listId, imageName=_imageName;
- (id)initWithId:(NSInteger)listId name:(NSString*)name imageName:(NSString*)imageName
{
    self = [super init];
    if (self) {
        self.listId = listId;
        self.name = name;
        self.imageName = imageName;
    }
    return self;

}
@end
