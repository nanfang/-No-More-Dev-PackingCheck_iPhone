//
//  PCKIndexedItems.m
//  PackingCheck
//
//  Created by nanfang on 8/27/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKIndexedItems.h"
#import "PCKModel.h"

@interface PCKIndexedItems (){
    NSMutableOrderedSet* _indexNames;
    NSMutableDictionary * _indexedItems;
}
@end

@implementation PCKIndexedItems

-(id) initWithItems:(NSArray*)items
{
    self = [super init];
    if (self) {
        _indexNames = [NSMutableOrderedSet orderedSet];
        _indexedItems = [NSMutableDictionary dictionary];
        
        for (id<PCKIndexed> item in items) {
            NSString* indexName = [item indexName];
            [_indexNames addObject:indexName];
            
            if(![_indexedItems objectForKey:indexName]){
                [_indexedItems setObject:[NSMutableArray array] forKey:indexName];
            }
            [[_indexedItems objectForKey:indexName]addObject:item];
            
        }
        
        [_indexNames sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
            return [obj1 compare:obj2];
        }];
    }
    return self;
}

-(int)indexOfName:(NSString*)name
{
    int count = 0;
    for(NSString *_name in _indexNames){
        if([_name isEqual:name]){
            return count;
        }
        count++;
    }
    return -1;
}


-(NSString*)nameAtIndex:(int)indexNumber
{
    return [_indexNames objectAtIndex:indexNumber];
}

-(NSArray*) indexNames
{
    return [_indexNames array];
}



-(NSArray*) itemsAtIndexNumber:(int)indexNumber
{
    return [_indexedItems objectForKey:[self nameAtIndex:indexNumber]];
}


-(NSArray*) itemsAtIndexName:(NSString*)indexName
{
    return [_indexedItems objectForKey:indexName];
}

@end
