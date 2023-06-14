//
//  LocationScreen.swift
//  Rick & Morty
//
//  Created by Alisher Manatbek on 04.06.2023.
//

import UIKit

class LocationScreen: UIViewController {
    let color = UIColor(named: "blue")
    let searchBarColor = UIColor(named: "searchBar")
    
    private var list: [ResultLocation] = [] {
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

    //searhBar
    lazy var searchIcon: UIImageView = {
        let searchIcon = UIImageView(image: UIImage(named: "SearchIcon.png"))
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
        let sortIcon = UIImageView(image: UIImage(named: "sort.png"))
        sortIcon.contentMode = .scaleAspectFit
        sortIcon.tintColor = UIColor(red: 21/255, green: 41/255, blue: 58/255, alpha: 1)

        return sortIcon
    }()

    lazy var forSortView: UIView = {
        let forSortView = UIView()
        forSortView.addSubview(sortIcon)
        return forSortView
    }()
        
    lazy var searchBar: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Find location"
        textField.layer.cornerRadius = 20
        textField.backgroundColor = .black
        textField.textColor = UIColor(red: 175/255, green: 155/255, blue: 155/255, alpha: 1)
        textField.backgroundColor = searchBarColor

        textField.leftView = customView
        textField.leftViewMode = .always

        textField.rightView = forSortView
        textField.rightViewMode = .always

        return textField
    }()

    //
    let CharLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textAlignment = .left
        customLabel.textColor = UIColor(red: 95/255, green: 105/255, blue: 117/255, alpha: 1)
        customLabel.font = .systemFont(ofSize: 10)
        
        let attributedText = NSMutableAttributedString(string: "ВСЕГО ЛОКАЦИИ: 0")
        let letterSpacing: CGFloat = 1.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText
        
        return customLabel
    }()
    
    // tableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = color
        tableView.separatorStyle = .none
        
        return tableView
    }()
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = color
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier:  LocationTableViewCell.identifier)
        
        searchBar.delegate = self

        APIManager.shared.getDataLocation { [weak self] values in
            DispatchQueue.main.async {
                guard let self = self else{return}
                self.list = values
                self.tableView.reloadData()
            }
        }

        UISetup()
        makeConstr()
    }
    
    func UISetup(){
        view.addSubview(searchBar)
        view.addSubview(CharLabel)
        view.addSubview(tableView)
    }
    
    func makeConstr() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
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
        CharLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(CharLabel.snp.bottom).offset(24)
            $0.left.right.bottom.equalToSuperview().inset(16)
        }
    }

}

extension LocationScreen: UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Failed to dequeue LocationTableViewCell")
        }
        
        
        
        cell.backgroundColor = color
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = color
        cell.selectedBackgroundView = selectedBackgroundView
        

        
        cell.configure(with: UIImage(named: "Series1.png")!, and: list[indexPath.row])
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 218
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let detailViewController = LocationDetailViewController(model: list[indexPath.row])
        
        navigationController?.pushViewController(detailViewController, animated: false)
        
    }

    
    
}

