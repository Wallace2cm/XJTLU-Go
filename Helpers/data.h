//
//  data.h
//  XJTLU GO
//
//  Created by Hong on 7/4/2018.
//  Copyright © 2018 Hong. All rights reserved.
//

#ifndef data_h
#define data_h


#endif  /* data_h */
//
//  data.m
//  XJTLU GO
//
//  Created by Hong on 6/4/2018.
//  Copyright © 2018 Hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
//#import "XJTLU-Swift.h"

@interface data: NSObject{
    data *ojn;
@public
    NSString *name;

}
@property NSString *myString;
@property (nonatomic, strong) NSArray *returnArr;
@property (nonatomic, strong) NSArray *returnValueAll;


//@property (strong, nonatomic) BmobIM *sharedIM;
-(void)createQ:(NSString*)title
             A:(NSString*)optionA
             B:(NSString*)optionB
             C:(NSString*)optionC
             D:(NSString*)optionD
           ans:(NSString*)answer;
-(NSArray *)getAllQustions: bankName;
-(void)searchQ:(NSString*)title;
-(NSArray *)RandomSearchByNumber:(int)total num:(int)num bankName:(NSString*)bankName;
-(void)getQuestionsByIndex:(NSArray *)arr bankName:(NSString*)bankName;
+(NSMutableArray *)getRandomInt:(NSMutableArray*)a total:(int)total;
+(NSMutableArray *)getRamdomArray:(int)number total:(int)total;

@end


@implementation data
int numSearch = 3;

//decode string to json
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json decode fail ：%@",err);
        return nil;
    }
    return dic;
}


//update a question to database
-(void)createQ:(NSString*)title
             A:(NSString*)optionA
             B:(NSString*)optionB
             C:(NSString*)optionC
             D:(NSString*)optionD
             ans:(NSString*)answer{
    ojn.myString = @"d";
    
    static int nnn;  //to make outside read number
    BmobObject *acc = [BmobObject objectWithClassName:@"QuestionBank"];
    [acc setObject:title forKey:@"title"];
    [acc setObject:optionA forKey:@"optionA"];
    [acc setObject:optionB forKey:@"optionB"];
    [acc setObject:optionC forKey:@"optionC"];
    [acc setObject:optionD forKey:@"optionD"];
    [acc setObject:answer forKey:@"answer"];
    [acc setObject:[NSNumber numberWithBool:YES] forKey:@"checkmod"];
    NSLog(@"調庫開始");
    NSString *bql = @"select count(*) from QuestionBank";
    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
    [bmobQuery queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            if (result) {
                nnn = result.count +1;
                //nnn = adder(result.count, 1);
                [acc setObject:[NSNumber numberWithInt:nnn] forKey:@"num"];
                [acc saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                }];
//this place should be query finish place
                NSLog(@"調庫結束---總個數%d",nnn);
            }
        }
    }];
}

-(NSArray *)getAllQustions: bankName{
    //BmobQuery *bquery = [BmobQuery queryWithClassName:bankName];
    //[bquery whereKey:@"num" equalTo:[NSNumber numberWithInt:1]]; 單個的
    static int totalnum;
    static NSArray *returnValue;
    NSLog(@"start query");
    NSString *bql = @"select count(*) from QuestionBank";
    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
    [bmobQuery queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            if (result) {
                totalnum = result.count;
                data *ojn = [[data alloc] init];
                returnValue = [ojn RandomSearchByNumber:totalnum num:totalnum bankName:bankName];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //do something
                    self.returnValueAll = ojn.returnValueAll;
                });
//                NSLog(@"調庫結束---總個數%d",totalnum);
            }
        }
    }];
    return returnValue;
}


//get a distinct random selected array
+(NSMutableArray *)getRamdomArray:(int)number total:(int)total{
    NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:number];
    for (int i = 0; i < number; i++) {
        resultArray = [data getRandomInt:resultArray total:total];
    }
    return resultArray;
}

+(NSMutableArray *)getRandomInt:(NSMutableArray*)a total:(int)total{
    int value = (arc4random() % total) + 1;
    if(![a containsObject:[NSNumber numberWithInt:value]]){
        [a addObject:[NSNumber numberWithInt:value]];
    }else{
        return [data getRandomInt:a total:total];
    }
    return a;
}

//used for getting speical question
-(void)getQuestionsByIndex:(NSArray *)arr bankName:(NSString*)bankName{
    BmobQuery *bquery = [BmobQuery queryWithClassName:bankName];
    [bquery whereKey:@"num" containedIn:arr];

    [bquery findObjectsInBackgroundWithBlock: ^(NSArray *array, NSError *error){
        if (error){
            NSLog(@"error in <data.h> getQuestionsByIndex() method");
        }else{
            if ([array isKindOfClass:[NSArray class]] && array.count > 0){
                // if array contains objects
                 self.returnArr = array;
            }else{
                NSLog(@"no result!");
            }
        }
    }];
}

-(NSArray *)RandomSearchByNumber:(int)total num:(int)num bankName:(NSString*)bankName{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    arr = [data getRamdomArray:num total:total];
    BmobQuery *bquery = [BmobQuery queryWithClassName:bankName];
    [bquery whereKey:@"num" containedIn:arr];
    static NSArray *returnValue;
    [bquery findObjectsInBackgroundWithBlock: ^(NSArray *array, NSError *error){
        if (error){
            NSLog(@"error in <data.h> random() method");
        }else{
            if ([array isKindOfClass:[NSArray class]] && array.count > 0){
                //array  not empty
                returnValue = array;
                self.returnValueAll = array;
                self.returnArr = array;
                for (BmobObject *object in array) {
                    NSString *answer = [object objectForKey:@"answer"];
                    NSString *num = [object objectForKey:@"num"];
                    NSLog(@"%@----%@",answer,num);
                }
            }else{
                NSLog(@"no result!");
            }
        }
    }];
    return returnValue;
}

//writen for programmer
-(void)searchQ:(NSString*)title{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"QuestionBank"];
    [bquery whereKey:@"title" equalTo:title];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error){
        if (error){
                NSLog(@"error in <data.h> searchQ() method");
        }else{
            if ([array isKindOfClass:[NSArray class]] && array.count > 0){
                for (BmobObject *object in array) {
                    NSString *answer = [object objectForKey:@"answer"];
                    NSString *num = [object objectForKey:@"num"];
                    NSLog(@"%@----%@",answer,num);
                }
            }else{
                NSLog(@"no result!");
            }
        }
    }];
}

@end
