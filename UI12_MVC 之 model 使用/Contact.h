//
//  Contact.h
//  UI12_MVC 之 model 使用
//
//  Created by dllo on 15/12/28.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

/** 声明属性, 一般是在数据字典中需要得数据对应的 Key 值 */

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *phone;

@property (nonatomic, copy)NSString *photo;

@property (nonatomic, copy)NSString *hobby;



@end
