//
//  CellContact.h
//  UI12_MVC 之 model 使用
//
//  Created by dllo on 15/12/28.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Contact;

@interface CellContact : UITableViewCell

/** 声明一个 model 的属性, 用来接收外部的 model 数据 .*/

@property (nonatomic , retain) Contact *con;

/** 声明一个方法,传入一个 model 数据过来 .*/

- (void)passModel:(Contact *)con;



@end
