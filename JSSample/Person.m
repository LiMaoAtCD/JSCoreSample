//
//  Person.m
//  JSSample
//
//  Created by limao on 2017/5/18.
//  Copyright © 2017年 limao. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

+ (instancetype) createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    Person *person = [[Person alloc] init];
    person.firstName = firstName;
    person.lastName = lastName;
    return person;
}

@end
