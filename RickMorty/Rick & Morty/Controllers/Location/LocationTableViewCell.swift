//
//  CharacterTableViewCell.swift
//  Rick & Morty
//
//  Created by Admin on 07.06.2023.
//

import UIKit
import SnapKit

class LocationTableViewCell: UITableViewCell {
    
    static let identifier = "LocationTableViewCell"
    let color = UIColor(named: "blue")
    let searchBarColor = UIColor(named: "searchBar")

    
    let customImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "earth.png"))
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 10
//        imageView.layer.masksToBounds = true
        
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
    
    let dimensionLabel: UILabel = {
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
    let typeLabel: UILabel = {
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
    
//    lazy var containerForLabel: UIView = {
//        let view = UIView()
//        
//        let label2 = UILabel()
//        label2.text = "Text"
//
//        view.addSubview(label2)
//        view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//        view.preservesSuperviewLayoutMargins = true
//        return view
//    }()
    
    lazy var myStackView: UIStackView = {
        let myStackView = UIStackView(arrangedSubviews: [customImageView,dimensionLabel,nameLabel])
        myStackView.axis = .vertical
        myStackView.backgroundColor = searchBarColor
        myStackView.layer.cornerRadius = 20
        myStackView.spacing = 10
        myStackView.layer.masksToBounds = true
        
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
    
    func configure(with image: UIImage,and array: ResultLocation) {
        self.nameLabel.text = "\(array.name)"
        self.typeLabel.text = "\(array.type)"
        self.dimensionLabel.text = "\(array.dimension)"
    }

    private func UISetup() {
        self.contentView.addSubview(myStackView)
        
    }
    
    private func makeConstr() {
        
        customImageView.snp.makeConstraints {
            $0.left.right.equalToSuperview()

            $0.height.equalTo(140)
        }
        
        myStackView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        
    }

}
