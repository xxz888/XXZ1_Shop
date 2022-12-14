//
//  UILabel+Category.m
//  XQDQ
//
//  Created by lh on 2021/9/18.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)


+ (instancetype)getUILabelText:(NSString *)text
                     TextColor:(UIColor *)color
                      TextFont:(UIFont *)font
             TextNumberOfLines:(NSInteger)lines{
    
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.numberOfLines = lines;
    return label;
    
}

+ (void)getToChangeTheLabel:(UILabel *)label
                  TextColor:(UIColor *)color
                   TextFont:(UIFont *)font{
    label.textColor = color;
    label.font = font;
}
///添加下划线
+ (NSMutableAttributedString *)AddLabelTheUnderline:(NSString *)text{
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                 NSBaselineOffsetAttributeName : [NSNumber numberWithInteger:2]
    };
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
    return attribtStr;
}


+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {

    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];

}
#pragma mark - 富文本设置部分字体颜色
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color textFont:(UIFont *)font{
    NSRange hightlightTextRange = [text rangeOfString:rangeText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:font range:hightlightTextRange];
        return attributeStr;
    }else {
        return [rangeText copy];
    }
}
+(NSString *)splitSpace:(NSString * )text{
    
    
    NSUInteger lenth = text.length;
    NSString *str1 = [text substringToIndex:4];
    NSString *str2 = [text substringFromIndex:lenth - 4];
    NSMutableString *str3 = [[NSMutableString alloc]init];
    for (int i = 0; i < lenth - 8; i++) {
        [str3 appendString:@"*"];
    }

    text = [NSString stringWithFormat:@"%@%@%@",@"****",str3,str2];
    
    
    
    
    
    // 4位分隔银行卡卡号
            NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789*\b"];
            NSString *  string = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
                return text;
            }

            NSString *newString = @"";
            while (text.length > 0) {
                NSString *subString = [text substringToIndex:MIN(text.length, 4)];
                newString = [newString stringByAppendingString:subString];
                if (subString.length == 4) {
                    newString = [newString stringByAppendingString:@" "];
                }
                text = [text substringFromIndex:MIN(text.length, 4)];
            }
            
            newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
            
            if ([newString stringByReplacingOccurrencesOfString:@" " withString:@""].length >= 21) {
                return text;
            }
            
    return newString;
}
@end
