//
//  CharacterScreen.swift
//  Rick & Morty
//
//  Created by Alisher Manatbek on 04.06.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterScreen: UIViewController {
    
    let color = UIColor(named: "blue")
    let searchBarColor = UIColor(named: "searchBar")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = color
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        
        return tableView
    }()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView(image : UIImage(named: "SearchIcon.png"))
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = color

        return searchIcon
    }()
    
    lazy var customView: UIView = {
        let customView = UIView()
        customView.addSubview(searchIcon)
        
        return customView
    }()
    
    let sortIcon: UIImageView = {
        let searchIcon = UIImageView(image : UIImage(named: "sort.png"))
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = UIColor(red: 21/255, green: 41/255, blue: 58/255, alpha: 1)

        return searchIcon
    }()
    
    lazy var forSortView: UIView = {
        let customView = UIView()
        customView.addSubview(sortIcon)
        
        return customView
    }()
    
    lazy var searchBar : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Find character"
        textField.layer.cornerRadius = 20
//        textField.layer.masksToBounds = true

        textField.textColor = UIColor(red: 175/255, green: 155/255, blue: 155/255, alpha: 1)
        textField.backgroundColor = searchBarColor

                
        textField.leftView = customView
        textField.leftViewMode = .always
        
        textField.rightView = forSortView
        textField.rightViewMode = .always

        return textField
    }()
    
    lazy var myStackView: UIStackView = {
        let myStackView = UIStackView(arrangedSubviews: [CharLabel,CharIcon])
        myStackView.axis = .horizontal
//        myStackView.spacing = 2
        
        return myStackView
    }()
    
    let CharLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textAlignment = .left
        customLabel.textColor = UIColor(red: 95/255, green: 105/255, blue: 117/255, alpha: 1)
        customLabel.font = .systemFont(ofSize: 10)
        
        let attributedText = NSMutableAttributedString(string: "ВСЕГО ПЕРСОНАЖЕЙ: 0")
        let letterSpacing: CGFloat = 1.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText
        
        return customLabel
    }()
    
    let CharIcon: UIImageView = {
        let searchIcon = UIImageView(image : UIImage(named: "Grid, Layout.7.png"))
        searchIcon.contentMode = .scaleAspectFit
        searchIcon.tintColor = UIColor(red: 21/255, green: 41/255, blue: 58/255, alpha: 1)

        return searchIcon
    }()
    
    
    private var list: [Result] = [] {
        didSet {
            updateCharacterCountLabel()
        }
    }
    func updateCharacterCountLabel() {
        let attributedText = NSMutableAttributedString(string: "ВСЕГО ПЕРСОНАЖЕЙ: \(list.count)")
        let letterSpacing: CGFloat = 1.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        CharLabel.attributedText = attributedText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier:  CharacterTableViewCell.identifier)
        
        searchBar.delegate = self

        APIManager.shared.getDataCharacter { [weak self] values in
            DispatchQueue.main.async {
                guard let self = self else{return}
                self.list = values
                self.tableView.reloadData()
            }
        }
        
        view.backgroundColor = color
        
        
        UISetup()
        makeConstr()
        
    }
    func UISetup() {
        view.addSubview(myStackView)
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    func makeConstr() {
        customView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        forSortView.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        searchIcon.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        sortIcon.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        myStackView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(tableView.snp.top).offset(-16) 
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(myStackView.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview().inset(16)
        }
    }
    // Implement UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSearch(with: textField.text)
        return true
    }
        
    func performSearch(with searchText: String?) {
        // Perform search logic based on the entered text
        if let text = searchText {
            print("Performing search for: \(text)")
            // Add your search implementation here
        }
    }


}

extension CharacterScreen: UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            fatalError("Failed to dequeue CharacterTableViewCell")
        }
        
        
        let url = URL(string: "\(list[indexPath.row].image)")
        cell.customImageView.kf.setImage(with: url)
        cell.backgroundColor = color
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = color
        cell.selectedBackgroundView = selectedBackgroundView
        
        
        if let image = cell.customImageView.image {
            cell.configure(with: image, and: list[indexPath.row])
        } else {
            cell.configure(with: UIImage(named: "SearchIcon.png")!, and: list[indexPath.row])
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = CharacterDetailViewController(model: list[indexPath.row])
        detailViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(detailViewController, animated: false)
    }

    
    
}
