//
//  user.h
//  XJTLU GO
//
//  Created by Hong on 7/4/2018.
//  Copyright © 2018 Hong. All rights reserved.
//

#ifndef user_h
#define user_h


#endif /* user_h */
#import <Foundation/Foundation.h>
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobUser.h>
//#import "data.h"

@interface user : NSObject <BmobEventDelegate>

@property (strong, nonatomic) BmobUser           *loginUser;
@property (strong, nonatomic) BmobEvent *bmobEvent;
@property (strong, nonatomic) NSString *rowId;

-(Boolean)createUser:(NSString*)user_name password:(NSString*)length;
-(Boolean)login:(NSString*)user_name password:(NSString*)length;
-(void)changeRanking:(int)score;
-(void)logOut;
-(void)initAPP;
//- (void)asdfg;
@end

@implementation user
-(Boolean)createUser:(NSString*)user_name password:(NSString*)length{
    static Boolean state;
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:user_name];
    [bUser setPassword:length];
    NSString* email = [NSString stringWithFormat:@"%@@student.xjtlu.edu.cn", user_name];
    //email = @"honglonghelong@163.com";
    //email = @"chentainb@163.com";
    NSLog(@"%@",email); //correct
    [bUser setEmail: email];
    [bUser setObject:[NSNumber numberWithBool:NO] forKey:@"emailVerified"];
    [bUser setObject:[NSNumber numberWithInt:0] forKey:@"ranking"];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            NSLog(@"Sign up successfully");
            BmobUser *user = [BmobUser currentUser];
            //verify email
            if ([user objectForKey:@"emailVerified"]) {
                if (![[user objectForKey:@"emailVerified"] boolValue]) {
                    [user verifyEmailInBackgroundWithEmailAddress:email];
                    [user verifyEmailInBackgroundWithEmailAddress:email  block:^(BOOL isSuccessful, NSError *error){
                        if(isSuccessful){
                            NSLog(@"successful");
                            state = true;
                        }
                    }];
                    //NSLog(@"%@",bUser.objectId);
                    NSLog(@"%@",user.email);
                    NSLog(@"email sent");
                }
            }
        } else {
            NSLog(@"%@",error);
            state = false;
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //do something
        
    });
    return state;
}

//most situation is exsiting a user
-(Boolean)login:(NSString*)user_name password:(NSString*)length{
    BmobUser *bUser = [BmobUser currentUser];
    static Boolean state = false;
    if (bUser) {
        //进行操作
        NSLog(@"have user");
        return true;
    }else{
        [BmobUser loginWithUsernameInBackground:user_name
                                       password:length block:^(BmobUser *user, NSError *error) {
                                           if(error){
                                               NSLog(@"no");
                                               state = false;
                                           }else{
                                               NSLog(@"yes");
                                               state = true;
                                           }
                                       }];
        return state;
    }
}

-(void)initAPP{
    [Bmob registerWithAppKey:@"688a743b831b3978b314f7bf1357a4de"];
}


NSString *num = @"1";
NSString *chioce = @"A";
NSString *quesTotalNum = @"10";
int quesTotalNumInt = 10;

//- (void)asdfg {
//
//self.bmobEvent          = [BmobEvent defaultBmobEvent];
//self.bmobEvent.delegate = self;
//[self.bmobEvent start];
//self.loginUser = [BmobUser currentUser];
//
//BmobQuery *bquery = [BmobQuery queryWithClassName:@"waitingTable"];
//[bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
//    if ([array isKindOfClass:[NSArray class]] && array.count > 0){
//        for (NSDictionary *obj in array) {
//            NSString *listItems = [obj description];
//            NSLog(@"%@",listItems);
//            NSLog(@"userId = %@", [obj objectForKey:@"userId"]);
//            NSLog(@"rowObjectId = %@", [obj objectForKey:@"rowObjectId"]);
//            self.rowId = [obj objectForKey:@"rowObjectId"] ;
//            BmobObject *bmobObject = [BmobObject objectWithoutDataWithClassName:@"waitingTable"  objectId:[obj objectForKey:@"objectId"]];
//            [bmobObject deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
//                if (isSuccessful) {
//                    NSLog(@"successful delete");
//                    BmobObject *update = [BmobObject objectWithoutDataWithClassName:@"conversation"  objectId:self.rowId];
//                    [update setObject:self.loginUser.objectId forKey:@"user2"];
//                    [update setObject:[NSNumber numberWithBool:NO] forKey:@"didInitState"];
//                    [update setObject:[NSNumber numberWithBool:NO] forKey:@"answerState"];
//                    NSString *bql = @"select count(*) from QuestionBank";
//                    BmobQuery *bmobQuery = [[BmobQuery alloc] init];
//                    static int totalNumInt = 0;
//                    [bmobQuery queryInBackgroundWithBQL:bql block:^(BQLQueryResult *result, NSError *error) {
//                        if (error) {
//                            NSLog(@"%@",error);
//                        } else {
//                            if (result) {
//                                totalNumInt = result.count + 1;
//                                NSMutableArray *resultArray=[[NSMutableArray alloc] initWithCapacity:totalNumInt];
//                                if(totalNumInt < quesTotalNumInt){
//                                    resultArray = [data getRamdomArray:totalNumInt total:totalNumInt];
//                                }else{
//                                    resultArray = [data getRamdomArray:quesTotalNumInt total:totalNumInt];
//                                }
//                                NSLog(@"searched question total number %@", resultArray);
//                                [update setObject:resultArray forKey:@"questionIndex"];
//                                [update updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                                    if (isSuccessful) {
//                                        NSLog(@"successful changing conversation table");
//                                        [self.bmobEvent listenRowChange:BmobActionTypeUpdateRow tableName:@"conversation" objectId:self.rowId];
//
//                                        //此处开始得到题库
//
//
//                                    } else if (error){
//                                        NSLog(@"%@",error);
//                                    } else {
//                                        NSLog(@"Unknow error");
//                                    }
//                                }];
//                            }
//                        }
//                    }];
//                } else if (error){
//                    NSLog(@"%@",error);
//                } else {
//                    NSLog(@"UnKnow error");
//                }
//            }];
//        }
//    }else{
//        NSLog(@"no result!");
//        BmobObject  *conversation = [BmobObject objectWithClassName:@"conversation"];
//        [conversation setObject:self.loginUser.objectId forKey:@"user1"];
//        [conversation setObject:[NSNumber numberWithBool:NO] forKey:@"didInitState"];
//        [conversation setObject:[NSNumber numberWithBool:NO] forKey:@"answerState"];
//        for(int i = 1 ; i < 11 ; i++){
//            NSString *option = [NSString stringWithFormat:@"option%d", i];
//            [conversation setObject:@"" forKey:option];
//        }
//        [conversation saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//            if (isSuccessful) {
//                NSLog(@"%@",conversation.objectId);
//                [self.bmobEvent listenRowChange:BmobActionTypeUpdateRow tableName:@"conversation" objectId:conversation.objectId];
//                self.rowId = conversation.objectId;
//                BmobObject  *update = [BmobObject objectWithClassName:@"waitingTable"];
//                [update setObject:self.loginUser.objectId forKey:@"userId"];
//                [update setObject:self.rowId forKey:@"rowObjectId"];
//                [update saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                    if (isSuccessful) {
//                        NSLog(@"successful add to waiting table");
//                    } else if (error){
//                        NSLog(@"%@",error);
//                    } else {
//                        NSLog(@"Unknow error");
//                    }
//                }];
//            } else if (error){
//                //发生错误后的动作
//                NSLog(@"%@",error);
//            } else {
//                NSLog(@"Unknow error");
//            }
//        }];
//    }
//    if(error){
//        NSLog(@"%@",error);
//    }
//}];
//}


//-(void)bmobEvent:(BmobEvent *)event didReceiveMessage:(NSString *)message{
//    //打印数据
//    NSLog(@"didReceiveMessage:%@",message);
//    //如果state1 是 false， 得到题库 并 改成 ture
//    //然后可以在user2处输出user1 已get题库
//    //答题时 所有的state2一直是2
//    NSDictionary *dic = [data dictionaryWithJsonString:message];
//    if ([dic isKindOfClass:[NSDictionary class]]){
//        NSDictionary *subdic =  [dic objectForKeyedSubscript:@"data"];
//        NSString *listItems = [subdic description];
//        NSLog(@"%@",listItems);
//        NSLog(@"userId = %@", [subdic objectForKey:@"option1"]);
//        NSLog(@"rowObjectId = %@", [subdic objectForKey:@"answerState"]);
//        NSLog(@"rowObjectId = %@", [subdic objectForKey:@"questionIndex"]);  //user1 初始化时questionindex同样 应该是null
//        NSString *didInitState =  [subdic objectForKey:@"didInitState"];
//        NSString *answerState =  [subdic objectForKey:@"answerState"];
//        //        NSLog(@"%d",[answerState integerValue] == 0);
//        //        NSLog(@"%d",[answerState isEqual:@"0"]);
//        if(([didInitState integerValue] == 1) && ([answerState integerValue] == 1)){
//            //收到题的state
//
//        }else{
//            if(([didInitState integerValue] == 0) && ([answerState integerValue] == 0)){
//                //去得到题库 + state1 改成 true
//                //写一个function 按照array 得到 题目
//                id questionIndex = [subdic objectForKey:@"questionIndex"];
//                if([questionIndex isKindOfClass:[NSArray class]]){
//                    NSLog(@"%@",questionIndex);
//                    data *da = [[data alloc] init];
//                    [da getQuestionsByIndex:(NSArray*)questionIndex bankName:@"QuestionBank"];     //////////////
//                }
//
//                BmobObject *update = [BmobObject objectWithoutDataWithClassName:@"conversation"  objectId:self.rowId];
//                [update setObject:[NSNumber numberWithBool:YES] forKey:@"didInitState"];
//                [update updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//                    if (isSuccessful) {
//                        NSLog(@"changed didInitState to true");
//                    } else if (error){
//                        NSLog(@"%@",error);
//                    } else {
//                        NSLog(@"Unknow error");
//                    }
//                }];
//            }else{
//                //此处应该不可能 didInitState false 而 answerState true 的情况
//                NSLog(@"I should be User2 and now user1 got the question bank");
//            }
//        }
//    }
//}


-(void)logOut{
    [BmobUser logout];
}


//called when ranking finished
-(void)changeRanking:(int)score{
    BmobUser *bUser = [BmobUser currentUser];
    static int rankingScore;
    if (bUser) {
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"_User"];
        [bquery getObjectInBackgroundWithId:bUser.objectId block:^(BmobObject *object,NSError *error){
            if (error){
                //进行错误处理
            }else{
                if (object) {
                    //得到playerName和cheatMode
                    int getScore = (int)[object objectForKey:@"ranking"];
                    rankingScore = getScore + score;
                    [bUser setObject:[NSNumber numberWithInt:rankingScore] forKey:@"ranking"];
                    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                        if (isSuccessful) {
                            NSLog(@"Ranking changed");
                        } else {
                            NSLog(@"%@",error);
                        }
                    }];
                    }else{
                        NSLog(@"error in change Ranking");
                    }
                }
        }];
    }
}

@end
