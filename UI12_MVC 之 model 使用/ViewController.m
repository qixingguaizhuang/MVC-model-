//
//  ViewController.m
//  UI12_MVC 之 model 使用
//
//  Created by dllo on 15/12/28.
//  Copyright © 2015年 doll-61. All rights reserved.
//

#import "ViewController.h"

#import "Contact.h"

#import "CellContact.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableDictionary *dic;//数组小字典

@property (nonatomic, retain) NSMutableArray *arrKeys;

@property (nonatomic, retain) NSMutableArray *arr;



@end

@implementation ViewController

- (void)dealloc{

    [_tableView release];
    [_dic release];
    [_arrKeys release];
    [_arr release];
    [super dealloc];

}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
    [self handleDate];
    

}

- (void)creatTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.tableView];
    
    [_tableView release];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    /** 注册 cell  每次自动创建 cell */
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool1"];
    [self.tableView registerClass:[CellContact class] forCellReuseIdentifier:@"pool2"];
    
    
}



#pragma mark  - TableView DateSource


/** 分区名称 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return  self.arrKeys[section];

}

/* 分区数 */

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{

    return self.arrKeys.count;

}


/* 行数 */


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    /** 取出 key 值*/
    
    NSString *key = [self.arrKeys objectAtIndex:section];
    
    /** 根据 key 值找出 大字典中的 数组数, 即是行数 */
    
    NSMutableArray *arrl = [self.dic objectForKey:key];

    return  arrl.count;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{



    /** 返回 cell 的第二种写法(推荐).
     * 1.需要 tableView 注册一个 cell 类, 绑定一个重用池;
     * 2.从重用池中直接取出 cell. 如果 cell 为空,系统会自动根据和重用池绑定的 cell 类创建cell 对象.
     */

    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
        
        /* cell 赋值*/
        
        /** dic 是 con 对象和 key  的字典 */
      
        NSString *key = [self.arrKeys objectAtIndex:indexPath.section]; // 通过 section 在 key 值的数组中找到对应的 key 值
 
        NSArray *arr = [self.dic objectForKey:key];// 通过 key 值找到字典中对应的 con 数组

        Contact *con = [arr objectAtIndex:indexPath.row];// 通过行数找到数组中的 con 对象
        
        cell.imageView.image = [UIImage imageNamed:con.photo];// 数组 con 对象中的属性 赋值给 cell
        
        cell.textLabel.text = con.name; // 数组 con 对象中的属性 赋值给 cell

        return cell;
        
    }else {
    
    
        CellContact *cell = [tableView dequeueReusableCellWithIdentifier:@"pool2"];
        
        NSString *key = [self.arrKeys objectAtIndex:indexPath.section];
        
        NSArray *arr = [self.dic objectForKey:key];
        
        Contact *con = [arr objectAtIndex: indexPath.row];
        
        /* 赋值 */

        /** 思路: 
         
         将 model 数据传入自定义 cell 中,在cell 类里面完成 cell 上子控件的赋值过程 */
        
        
         /** MRC 下可以重写 setter 方法, 但不适用于 ARC */
 //         cell.con = con;
        
        
        
  /*第一开始的原始*/

//        cell.imageViewLeft.image = [UIImage imageNamed:con.photo];
//        
//        cell.lableName.text = con.name;
        
        
        
        /**ARC 可以通过方法实现 (Mrc 同样适用) 详见 cellcontact */
        
        [cell passModel:con];
        

        return cell;
        
    }

}


#pragma mark - Tableview Delegate


- (void)handleDate{

    self.dic = [NSMutableDictionary dictionary];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    
    /* self.dic = [NSMutableDictionary dictionaryWithContentsOfFile:path]; */
    
    NSMutableDictionary *dicTemp = [NSMutableDictionary dictionaryWithContentsOfFile:path];
   
    
    // 遍历 dicTemp 对象,将数据转成 model 对象
    
    
      /** 遍历出数组 存放 value 联系人数组 */
    
    for (NSString *key in dicTemp) {

        NSArray *arr = [dicTemp objectForKey:key];
        
         /** 初始化一个数组,用于存放 model 对象 */
        
        NSMutableArray *mArr = [NSMutableArray array];
        
            /**遍历数组,遍历出联系人小字典*/
        
        for (NSDictionary *dicCon in arr) {
            
            Contact *cont = [[Contact alloc] init];
            
            /** KVC 方法, 注意!! 对于未识别到的 key 的处理 */
            
            [cont setValuesForKeysWithDictionary:dicCon];
            
            [mArr addObject:cont];
 
            [cont release];
            
        }
        
        /** 在外面遍历.将数组添加到字典中  */
        
        [self.dic setObject:mArr forKey:key];

    }
    
     self.arrKeys = [NSMutableArray  arrayWithArray:self.dic.allKeys];
    [self.arrKeys sortUsingSelector:@selector(compare:)];
   
}

/** 行高 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
