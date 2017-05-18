//
//  ViewController.m
//  JSSample
//
//  Created by limao on 2017/5/18.
//  Copyright © 2017年 limao. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JSContext *context = [[JSContext alloc] init];
    
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"JS Error: %@", exception);
    };
    


//    [context evaluateScript:@"var num = 5 + 5"];
//    [context evaluateScript:@"var names = ['Grace', 'Ada', 'Margaret']"];
//    [context evaluateScript:@"var triple = function(value) { return value * 3 }"];
//    JSValue *tripleNum = [context evaluateScript:@"triple(num)"];
//    NSLog(@"Tripled: %d", [tripleNum toInt32]);
//    
//    JSValue *names = context[@"names"];
//    JSValue *initialName = names[0];
//    NSLog(@"The first name: %@", [initialName toString]);
//    
//    
//    JSValue *tripleFunction = context[@"triple"];
//    JSValue *result = [tripleFunction callWithArguments:@[@5] ];
//    NSLog(@"Five tripled: %d", [result toInt32]);
//    
//    
//    context[@"simplifyString"] = ^(NSString *input) {
//        NSMutableString *mutableString = [input mutableCopy];
//        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, NO);
//        CFStringTransform((__bridge CFMutableStringRef)mutableString, NULL, kCFStringTransformStripCombiningMarks, NO);
//        return mutableString;
//    };
//    
//    NSLog(@"%@", [context evaluateScript:@"simplifyString('안녕하새요!')"]);
    
    
    context[@"Person"] = [Person class];
    
    NSString *mustacheJSString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mustache"
                                                                                                    ofType:@"js"]
                                                           encoding:NSUTF8StringEncoding error:nil];
    [context evaluateScript:mustacheJSString];
    
    NSString *peopleJSON = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"js"]
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    [context evaluateScript: peopleJSON];

    // get load function
    JSValue *load = context[@"loadPeopleFromJSON"];
    // call with JSON and convert to an NSArray
    JSValue *loadResult = [load callWithArguments:@[peopleJSON]];
    NSArray *people = [loadResult toArray];

    // get rendering function and create template
    JSValue *mustacheRender = context[@"Mustache"][@"render"];
    NSString *template = @"{{getFullName}}, born {{birthYear}}";

    // loop through people and render Person object as string
    for (Person *person in people) {
        NSLog(@"%@", [mustacheRender callWithArguments:@[template, person]]);
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
