//
//  DataSourse.h
//  iFridge
//
//  Created by Vladius on 5/15/15.
//  Copyright (c) 2015 Vladius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "Recipe+Cat.h"
#import "AppDelegate.h"

@interface DataSourse : NSObject

+ (void)getData:(void(^)())handler;
@end
