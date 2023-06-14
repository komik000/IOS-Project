//
//  CharacterTableViewCell.swift
//  Rick & Morty
//
//  Created by Admin on 07.06.2023.
//

import UIKit
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    
    static let identifier = "CharacterTableViewCell"
    let color = UIColor(named: "blue")
    
    let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 74/2
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
    
    let statusLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textAlignment = .left
        customLabel.textColor = .green
        customLabel.font = .systemFont(ofSize: 10)
        
        let attributedText = NSMutableAttributedString(string: customLabel.text ?? "dead")
        let letterSpacing: CGFloat = 1.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText
        
        return customLabel
    }()
    let genderLabel: UILabel = {
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
        let myStackView = UIStackView(arrangedSubviews: [statusLabel,nameLabel,genderLabel])
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
    
    func configure(with image: UIImage,and array: Result) {
        self.customImageView.image = image
        self.nameLabel.text = "\(array.name)"
        self.genderLabel.text = "Human, \(array.gender)"
        self.statusLabel.text = "\(array.status)".uppercased()
        if "\(array.status)" == "unknown" {
            statusLabel.text = "UNKNOWN"
            statusLabel.textColor = .gray
        }
        else if "\(array.status)" == "dead" {
            statusLabel.text = "DEAD"
            statusLabel.textColor = .red
        }
        else if "\(array.status)" == "alive" {
            statusLabel.text = "ALIVE"
            statusLabel.textColor = .green
        }
        

        
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
