//
//  EditUserQuestionTableViewCell.swift
//  StarFriend
//
//  Created by vitas on 2024/3/27.
//

import UIKit

class EditUserQuestionTableViewCell: EditUserInfoBaseCell {

    var question: SocialQuestion? {
        didSet {
            setData()
        }
    }
    
    let questionLabel: UILabel = UILabel(frame: .zero)
    
    let answerLabel: UILabel = UILabel(frame: .zero)
    
    static func cellWithTable(_ tableView: UITableView) -> EditUserQuestionTableViewCell {
        let cellID = "EditUserQuestionTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = EditUserQuestionTableViewCell(style: .default, reuseIdentifier: cellID)
            cell?.selectionStyle = .none
        }
        
        return cell as! EditUserQuestionTableViewCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        questionLabel.textColor = UIColor.hexVal(0xbfbfbf)
        questionLabel.font = UIFont.titleSize(16)
        questionLabel.numberOfLines = 0
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(questionLabel)
        
        answerLabel.textColor = UIColor.hexVal(0xfafafa)
        answerLabel.font = UIFont.textSize(16)
        answerLabel.numberOfLines = 0
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(answerLabel)
        
        
        questionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.right.equalTo(arrowView.snp.left).offset(-12)
            make.top.equalToSuperview().inset(20)
        }
                
//        answerLabel.snp.contentCompressionResistanceHorizontalPriority = UILayoutPriority.defaultLow.rawValue
//        valueLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(questionLabel.snp.bottom).offset(12)
            make.left.equalToSuperview().inset(12)
            make.right.equalTo(arrowView.snp.left).offset(-12)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData() {
        guard let question = question else {
            return
        }
        
        questionLabel.text = question.question_en
        answerLabel.text = question.answer
    }
}
