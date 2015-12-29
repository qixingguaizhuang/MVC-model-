//
//  CellContact.m
//  UI12_MVC 之 model 使用
//
//  Created by dllo on 15/12/28.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "CellContact.h"

#import "Contact.h"

/** 延展 */

@interface CellContact ()

@property (nonatomic, retain) UIImageView *imageViewLeft;

@property (nonatomic, retain) UILabel *lableName;

@end



@implementation CellContact

- (void)dealloc{
    [_imageViewLeft release];
    [_lableName release];
    [super dealloc];
}




/*方法*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self creatSubviews];
    }
    
    return self;
    
}


- (void)creatSubviews{
    
    self.imageViewLeft = [[UIImageView alloc] init];
    [self.contentView addSubview: self.imageViewLeft];
    
    [_imageViewLeft release];
    
    self.lableName = [[UILabel alloc] init];
    [self.contentView addSubview:self.lableName];
    [_lableName release];

}


- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    self.imageViewLeft.frame = CGRectMake(10, 10, height - 20, height - 20);
    
    self.lableName.frame = CGRectMake(width - height - 20 - 10, 10, width - (width - height - 20 - 10), height - 20);

}




/** 重写属性 con 的 set 方法*/


- (void)setCon:(Contact *)con{


    if (_con != con) {
        
        [_con release];
        _con = [con retain];
        
    }

    /** 子控件赋值 */
    
    self.imageViewLeft.image = [UIImage imageNamed:con.photo];
    self.lableName.text = con.name;


}


/** 在 arc 中也可以使用这个方法 */


- (void)passModel:(Contact *)con{
    
/**赋值*/
    
    self.imageViewLeft.image = [UIImage imageNamed:con.photo];
    
    self.lableName.text = con.name;



}












- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
