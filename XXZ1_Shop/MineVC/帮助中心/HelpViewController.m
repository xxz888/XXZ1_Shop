//
//  HelpViewController.m
//  jintStudentProject
//
//  Created by BH on 2021/8/7.
//  Copyright © 2021 JA. All rights reserved.
//

#import "HelpViewController.h"
#import "ProblemTitleModel.h"
#import "AnswerModel.h"
#import "HeadView.h"
#import "AnswerCell.h"


@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource,HeadViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *collectViewBottom;
@property (nonatomic ,strong)UICollectionView * collectView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray * collectionList;
@property (nonatomic, strong) NSMutableArray *answersArray;
@property (nonatomic, assign) CGSize textSize;
@property (nonatomic ,strong)ProblemTitleModel * titleModel;
@property (weak, nonatomic) IBOutlet UIView *changjianView;

@property (weak, nonatomic) IBOutlet UIView *woyaozixunView;
@property (weak, nonatomic) IBOutlet UIView *woyaotousuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollowHeight;
@property (weak, nonatomic) IBOutlet UIView *chakanjiluView;
@property (weak, nonatomic) IBOutlet UIView *helpCenterView;

@property (nonatomic ,assign)CGFloat selectHeight;

@property (nonatomic, assign)CGFloat headerHeight;


@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"帮助中心";

  
    self.tableView.sectionHeaderHeight = 50;
    self.tableView.sectionFooterHeight = 0;

        

    

    self.collectionList = [[NSMutableArray alloc]init];
    self.answersArray = [NSMutableArray array];

    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"problemCenter" ofType:@"plist"];
    NSArray * arr = [[NSArray alloc]initWithContentsOfFile:path];
    for (NSDictionary * dic in arr) {
        ProblemTitleModel *titleGroup = [ProblemTitleModel friendGroupWithDict:dic];
        [self.answersArray addObject:titleGroup];
    }
 
    [self.tableView reloadData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.answersArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProblemTitleModel *titleGroup = self.answersArray[section];
    NSInteger count = titleGroup.isOpened ? titleGroup.infor.count : 0;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    AnswerCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnswerCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ProblemTitleModel *titleGroup = self.answersArray[indexPath.section];
    AnswerModel *answerModel = titleGroup.infor[indexPath.row];
    
    cell.textViewLabel.text = answerModel.answer;
    
    self.textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:15] textLabel:answerModel.answer view:cell.textViewLabel];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return self.textSize.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    
    headView.delegate = self;
    headView.titleGroup = self.answersArray[section];

    return headView;
}
- (CGSize)getLabelSizeFortextFont1:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(KScreenWidth-200,1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ProblemTitleModel * model = self.answersArray[section];
    CGFloat h =  [self getLabelSizeFortextFont1:[UIFont systemFontOfSize:15] textLabel:model.title].height;
    return h < 50 ? 50 : h ;
}



- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)clickHeadView:(ProblemTitleModel*)model
{
    self.headerHeight = 0;
    for (ProblemTitleModel * limianModel in self.answersArray) {
        CGFloat h =  [self getLabelSizeFortextFont1:[UIFont systemFontOfSize:15] textLabel:limianModel.title].height;
        self.headerHeight += (h < 50 ? 50 : h);
    }
    
    for (ProblemTitleModel * limianModel in self.answersArray) {
     
        if([model.title isEqualToString:limianModel.title]){
            ProblemTitleModel * selectModel = model;
            [selectModel setOpened:!model.opened];
            
            if (selectModel.opened) {
                self.scrollowHeight.constant = 170  + [self getLabelSizeFortextFont1:[UIFont systemFontOfSize:15] textLabel:selectModel.answer].height + self.headerHeight;
                
            }else{
                self.scrollowHeight.constant = 170 + self.headerHeight ;
            }
            
     
        }else{
            [limianModel setOpened:NO];

        }
    }

    [self.tableView reloadData];
    
}

- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text view:(UITextView *)textView{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(KScreenWidth-100, MAXFLOAT)];
    return sizeToFit;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
//        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
//    }
//}
//

- (IBAction)moreAction:(id)sender {
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
