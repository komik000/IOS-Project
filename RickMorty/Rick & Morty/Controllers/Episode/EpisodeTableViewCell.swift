//
//  CharacterTableViewCell.swift
//  Rick & Morty
//
//  Created by Admin on 07.06.2023.
//

import UIKit
import SnapKit

class EpisodeTableViewCell: UITableViewCell {
    
    static let identifier = "EpisodeTableViewCell"
    let color = UIColor(named: "blue")
    
    let customImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "seria1.png"))
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textAlignment = .left
        customLabel.textColor = .label
        customLabel.font = .systemFont(ofSize: 16,weight: .medium)
        
        let attributedText = NSMutableAttributedString(string: customLabel.text ?? "dead")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText
        
        return customLabel
    }()
    
    let seriaLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textAlignment = .left
        customLabel.textColor = UIColor(red: 34/255, green: 162/255, blue: 189/255, alpha: 0.87)//rgba(34, 162, 189, 0.87)
        customLabel.font = .systemFont(ofSize: 10)
        
        let attributedText = NSMutableAttributedString(string: customLabel.text ?? "0")
        let letterSpacing: CGFloat = 1.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText
        
        return customLabel
    }()
    let airDateLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textAlignment = .left
        customLabel.textColor = UIColor(red: 110/255, green: 121/255, blue: 140/255, alpha: 1)
        customLabel.font = .systemFont(ofSize: 12)
        
        let attributedText = NSMutableAttributedString(string: customLabel.text ?? "UNKNOWN")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))

        customLabel.attributedText = attributedText
        
        return customLabel
    }()
    
    lazy var myStackView: UIStackView = {
        let myStackView = UIStackView(arrangedSubviews: [seriaLabel,nameLabel,airDateLabel])
        myStackView.axis = .vertical
        myStackView.spacing = 2
        
        return myStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        UISetup()
        makeConstr()
    }
    
    required init?(coder: NSCoder) {
        fatalError("has not be implemented")
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            contentView.backgroundColor = color
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
    }
    
    func configure(with image: UIImage,and array: ResultEp) {
        self.customImageView.image = image
        self.nameLabel.text = "\(array.name)"
        self.airDateLabel.text = "\(array.airDate)"
        self.seriaLabel.text = "\(array.episode)"
    }

    private func UISetup() {
        self.contentView.addSubview(customImageView)
        self.contentView.addSubview(myStackView)
    }
    
    private func makeConstr() {
        customImageView.snp.makeConstraints {
            $0.top.equalTo(self.contentView.snp.top)
            $0.left.equalTo(self.contentView.snp.left)
            $0.bottom.equalTo(self.contentView.snp.bottom)


            $0.width.equalTo(74)
//            $0.height.equalTo(74)
        }
        myStackView.snp.makeConstraints {
            $0.left.equalTo(customImageView.snp.right).offset(16)
            $0.center.equalTo(self.contentView.snp.center)
        }
    }

}
