//
//  DataSourse.m
//  iFridge
//
//  Created by Vladius on 5/15/15.
//  Copyright (c) 2015 Vladius. All rights reserved.
//

#import "DataSourse.h"


#define URL @"https://api.edamam.com/search?q=dinner&app_id=098aa935&app_key=e6f6e485b0222cf1b48439a164562270"

@implementation DataSourse

+(void)getData:(void(^)())handler{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        NSError *error;
        NSDictionary *queryForRecipes = [NSJSONSerialization JSONObjectWithData:data
                                                                options:0
                                                                  error:&error];
        
        if (error) NSLog(@"downloading info failed with error: %@", error);
        
        NSArray *recipes = [[NSArray alloc] initWithArray:[queryForRecipes valueForKeyPath:@"hits"]];
        for (NSDictionary *recipe in recipes) {
            [Recipe createRecipeWithInfo:[recipe valueForKey:@"recipe"]
                  inManagedObiectContext:((AppDelegate*)([UIApplication sharedApplication]).delegate).managedObjectContext];
        }
        handler();
    });
    
}
@end
