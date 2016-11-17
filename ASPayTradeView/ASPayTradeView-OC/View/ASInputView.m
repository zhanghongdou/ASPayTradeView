//
//  ASInputView.m
//  ASPayTradeView
//
//  Created by haohao on 16/11/11.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ASInputView.h"
#import "ASTransformAnimationTool.h"
#define PassWordCount_Low   6
#define PassWordCount_High 10
#define BlackLabelWidth 10
#define Spacing 10
#define paViewHeight 30


@interface ASInputView ()<UITextFieldDelegate>
{
    InputViewType _inputType;
    NSInteger _passwordCount;
}
@property (nonatomic, strong) NSMutableArray *blackDotArray;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *psView;
@property (nonatomic, strong) UIButton *getResponseBtn;
@end

@implementation ASInputView

-(id)initWithFrame:(CGRect)frame withType:(InputViewType)inputViewType withPassWordCount:(NSInteger)pwCount
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _inputType = inputViewType;
        _passwordCount = pwCount;
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    //创建输入框
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(Spacing, (self.frame.size.height - paViewHeight) / 2, self.frame.size.width - Spacing * 2, paViewHeight)];
    self.textField.placeholder = @"请输入交易密码";
    self.textField.hidden = YES;
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.secureTextEntry = YES;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.textField];
    [self.textField becomeFirstResponder];
    switch (_inputType) {
        case InputViewTypeShowDot:
            [self creatUIAboutShowDot];
            break;
        default:
            [self creatUIAboutNormal];
            break;
    }
}

-(void)textFieldTextDidChange
{
    if (self.textField.text.length <= _passwordCount) {
        [self setDotToShowWith:self.textField.text.length];
    }
    if (self.textField.text.length == _passwordCount) {
        //如果密码正确的话，直接移除view 如果错误的话，抖动
        //下面的代码只是不正确的时候
        switch (_inputType) {
            case InputViewTypeShowDot:
               [ASTransformAnimationTool shakeViewWithView:self.psView];
                self.textField.text = @"";
                [self setDotToShowWith:0];
                break;
            default:
                [ASTransformAnimationTool shakeViewWithView:self.textField];
                self.textField.text = @"";
                break;
        }
    }
}


-(void)creatUIAboutShowDot
{
    if (_passwordCount >= PassWordCount_Low && _passwordCount <= PassWordCount_High) {
        
    }else {
        _passwordCount = PassWordCount_High;
        NSLog(@"Password number limit is 6-10,If you want more, please amend the type in the source code as normal");
    }
    self.blackDotArray = [NSMutableArray arrayWithCapacity:_passwordCount];
    self.psView = [[UIView alloc]initWithFrame:CGRectMake(Spacing, (self.frame.size.height - paViewHeight) / 2, self.frame.size.width - Spacing * 2, paViewHeight)];
    self.psView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.psView];
    self.getResponseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.getResponseBtn.frame = CGRectMake(Spacing, (self.frame.size.height - paViewHeight) / 2, self.frame.size.width - Spacing * 2, paViewHeight);
    [self addSubview:self.getResponseBtn];
    [self.getResponseBtn addTarget:self action:@selector(getResponseBtn) forControlEvents:UIControlEventTouchUpInside];
    self.getResponseBtn.backgroundColor = [UIColor clearColor];
    self.psView.layer.borderWidth = 0.5;
    self.psView.layer.borderColor = [UIColor colorWithRed:0.7843 green:0.7804 blue:0.8000 alpha:1.0].CGColor;
    CGFloat unitWidth = self.psView.frame.size.width / _passwordCount;
    for (int i = 0; i < _passwordCount; i++) {
        UILabel *blackLabel = [[UILabel alloc]initWithFrame:CGRectMake(unitWidth / 2 + i * unitWidth - BlackLabelWidth / 2, CGRectGetHeight(self.psView.frame) / 2 - BlackLabelWidth / 2, BlackLabelWidth, BlackLabelWidth)];
        blackLabel.backgroundColor = [UIColor blackColor];
        blackLabel.layer.cornerRadius = BlackLabelWidth / 2;
        blackLabel.clipsToBounds = YES;
        blackLabel.hidden = YES;
        [self.psView addSubview:blackLabel];
        [self.blackDotArray addObject:blackLabel];
        
        if (i > 0 && i < _passwordCount) {
            UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(unitWidth * i, 0, 0.5, self.psView.frame.size.height)];
            lineLabel.backgroundColor = [UIColor colorWithRed:0.7843 green:0.7804 blue:0.8000 alpha:1.0];
            [self.psView addSubview:lineLabel];
        }
    }
}

-(void)getResponseBtnCLick
{
    [self.textField becomeFirstResponder];
}


-(void)creatUIAboutNormal
{
    self.textField.hidden = NO;
}

#pragma mark -------- UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.textField) {
        
        NSUInteger lengthOfString = string.length;  //lengthOfString的值始终为1
        
        for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {
            
            unichar character = [string characterAtIndex:loopIndex]; //将输入的值转化为ASCII值（即内部索引值），可以参考ASCII表
            
            // 48-57;{0,9};65-90;{A..Z};97-122:{a..z}
            
            if (character < 48) return NO; // 48 unichar for 0
            
            if (character > 57 && character < 65) return NO; //
            
            if (character > 90 && character < 97) return NO;
            
            if (character > 122) return NO;
        }
        
        // Check for total length
        
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > _passwordCount) {
            
            return NO;//限制长度
            
        }
        return YES;
    }
    
    return YES;
}

-(void)setDotToShowWith:(NSInteger)index
{
    for (UILabel *label in self.blackDotArray) {
        label.hidden = YES;
    }
    for (int i = 0; i < index; i++) {
        UILabel *label = (UILabel *)self.blackDotArray[i];
        label.hidden = NO;
    }
}

- (void)drawRect:(CGRect)rect {
    
}


@end
