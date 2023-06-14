//
//  CharacterDetailViewController.swift
//  Rick & Morty
//
//  Created by Admin on 08.06.2023.
//

import UIKit
import SnapKit
import Kingfisher

class CharacterDetailViewController : UIViewController {

    let model : Result?

    init(model: Result?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func imageConfig() {
        if let ourModel = model {
            let url = URL(string: "\(ourModel.image)")
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(named: "Subtract.png")
        }
    }


    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Subtract.png"))
        imageView.layer.cornerRadius = 75
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)

    lazy var labelName: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "\(model!.name)"
        nameLabel.font = .systemFont(ofSize: 34)

        let attributedText = NSMutableAttributedString(string: nameLabel.text ?? "dead")
        let letterSpacing: CGFloat = 0.25
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        nameLabel.attributedText = attributedText

        return nameLabel
    }()
    lazy var statusLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.textColor = .green
        customLabel.text = "\(model!.status)".uppercased()
        customLabel.font = .systemFont(ofSize: 10)

        let attributedText = NSMutableAttributedString(string: customLabel.text ?? "dead")
        let letterSpacing: CGFloat = 1.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText

        return customLabel
    }()


    //Description
    let DescriptionLabel: UILabel = {
        let customLabel = UILabel()
        customLabel.text = "Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.dsafkjdshfkajs dfjasdkf ajsdhfjk ahsdjfh jkasdf ahsdkffhasdj akjsdfh jaksdf Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери."
        customLabel.font = .systemFont(ofSize: 13)
        customLabel.numberOfLines = 0
        customLabel.textAlignment = .left
        customLabel.lineBreakMode = .byTruncatingTail

        let attributedText = NSMutableAttributedString(string: customLabel.text ?? "dead")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        customLabel.attributedText = attributedText

        return customLabel
    }()

    //Species and gender
    lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "Gender"
        genderLabel.font = .systemFont(ofSize: 12)
        genderLabel.textColor = textColor

        let attributedText = NSMutableAttributedString(string: genderLabel.text ?? "unkown")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        genderLabel.attributedText = attributedText

        return genderLabel
    }()
    lazy var genderLabel1: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.font = .systemFont(ofSize: 14)

        if let model = model {
            let speciesText = "\(model.gender)"
            let capitalizedSpecies = speciesText.prefix(1).capitalized + speciesText.dropFirst()
            speciesLabel.text = capitalizedSpecies
        } else {
            speciesLabel.text = "Unknown"
        }

        let attributedText = NSMutableAttributedString(string: speciesLabel.text ?? "")
        let letterSpacing: CGFloat = 0.25
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        speciesLabel.attributedText = attributedText

        return speciesLabel
    }()



    lazy var speciesLabel: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.text = "Species"
        speciesLabel.font = .systemFont(ofSize: 12)
        speciesLabel.textColor = textColor

        let attributedText = NSMutableAttributedString(string: speciesLabel.text ?? "unkown")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        speciesLabel.attributedText = attributedText

        return speciesLabel
    }()
    lazy var speciesLabel1: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.font = .systemFont(ofSize: 14)

        if let model = model {
            let speciesText = "\(model.species)"
            let capitalizedSpecies = speciesText.prefix(1).capitalized + speciesText.dropFirst()
            speciesLabel.text = capitalizedSpecies
        } else {
            speciesLabel.text = "Unknown"
        }

        let attributedText = NSMutableAttributedString(string: speciesLabel.text ?? "")
        let letterSpacing: CGFloat = 0.25
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        speciesLabel.attributedText = attributedText

        return speciesLabel
    }()


    lazy var labelStackViewNO1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genderLabel,genderLabel1])
        stackView.axis = .vertical
        stackView.spacing = 2

        return stackView
    }()
    lazy var labelStackViewNO2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [speciesLabel,speciesLabel1])
        stackView.axis = .vertical
        stackView.spacing = 2

        return stackView
    }()
    lazy var labelStackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackViewNO1,labelStackViewNO2])
        stackView.axis = .horizontal

        return stackView
    }()

    //Birth Location
    lazy var birthLocationLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "Birth Location"
        genderLabel.font = .systemFont(ofSize: 12)
        genderLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)

        let attributedText = NSMutableAttributedString(string: genderLabel.text ?? "unkown")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        genderLabel.attributedText = attributedText

        return genderLabel
    }()
    lazy var birthLocationLabel1: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.font = .systemFont(ofSize: 14)

        if let model = model {
            let speciesText = "\(model.origin.name)"
            let capitalizedSpecies = speciesText.prefix(1).capitalized + speciesText.dropFirst()
            speciesLabel.text = capitalizedSpecies
        } else {
            speciesLabel.text = "Unknown"
        }

        let attributedText = NSMutableAttributedString(string: speciesLabel.text ?? "")
        let letterSpacing: CGFloat = 0.25
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        speciesLabel.attributedText = attributedText

        return speciesLabel
    }()

    let iconRight: UIView = {
        let iconRight = UIImage(named: "arrow.right")
        iconRight?.withTintColor(.black)
        let view = UIImageView()
        view.image = iconRight

        return view
    }()

    lazy var labelStackViewLocation: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [birthLocationLabel,birthLocationLabel1])
        stackView.axis = .vertical
        stackView.spacing = 1

        return stackView
    }()

    lazy var labelStackViewLocationMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackViewLocation,iconRight])
        stackView.axis = .horizontal

        return stackView
    }()

    //Location
    lazy var locationLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "Location"
        genderLabel.font = .systemFont(ofSize: 12)
        genderLabel.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)

        let attributedText = NSMutableAttributedString(string: genderLabel.text ?? "unkown")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        genderLabel.attributedText = attributedText

        return genderLabel
    }()
    lazy var locationLabel1: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.font = .systemFont(ofSize: 14)

        if let model = model {
            let speciesText = "\(model.location.name)"
            let capitalizedSpecies = speciesText.prefix(1).capitalized + speciesText.dropFirst()
            speciesLabel.text = capitalizedSpecies
        } else {
            speciesLabel.text = "Unknown"
        }

        let attributedText = NSMutableAttributedString(string: speciesLabel.text ?? "")
        let letterSpacing: CGFloat = 0.25
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        speciesLabel.attributedText = attributedText

        return speciesLabel
    }()


    lazy var locationStackViewLocation: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationLabel,locationLabel1])
        stackView.axis = .vertical
        stackView.spacing = 2

        return stackView
    }()

    lazy var locationStackViewMain: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [locationStackViewLocation,iconRight])
        stackView.axis = .horizontal

        return stackView
    }()

    //hr
    let hr: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "searchBar")
        return view
    }()

    //Episods label
    lazy var epLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Episods"

        let attributedText = NSMutableAttributedString(string: label.text ?? "")
        let letterSpacing: CGFloat = 0.15
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText

        return label
    }()
    lazy var epLabel1: UILabel = {
        let label = UILabel()
        label.text = "Max. 5 episodes"
        label.font = .systemFont(ofSize: 12)
        label.textColor = textColor

        let attributedText = NSMutableAttributedString(string: label.text ?? "")
        let letterSpacing: CGFloat = 0.5
        attributedText.addAttribute(NSAttributedString.Key.kern, value: letterSpacing, range: NSRange(location: 0, length: attributedText.length))
        label.attributedText = attributedText

        return label
    }()

    lazy var epStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [epLabel,epLabel1])
        stackView.axis = .horizontal
        stackView.spacing = 156
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = color
//        scrollView.contentSize = tableView.bounds.size
        return scrollView
    }()




    let color = UIColor(named: "blue")

    // tableViewr
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = color
        return tableView
    }()
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = color
        
        return contentView
    }()

    private var list: [ResultEp] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color

        let image = UIImage(systemName: "arrow.left")
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier:  EpisodeTableViewCell.identifier)
        tableView.isScrollEnabled = false
        scrollView.frame = view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)

                // Set up the table view
        tableView.frame = scrollView.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(tableView)
        scrollView.contentSize = tableView.bounds.size
        
        contentView.addSubview(tableView)

        APIManager.shared.getDataEpisode { [weak self] values in
            DispatchQueue.main.async {
                guard let self = self else{return}
                self.list = values
                self.tableView.reloadData()
                self.maked()
            }
        }

        

    }
    func maked() {
        imageConfig()
        UISetup()
        makeConstr()
    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func UISetup() {
        view.addSubview(scrollView)

        scrollView.addSubview(imageView)
        scrollView.addSubview(labelName)
        scrollView.addSubview(statusLabel)
        scrollView.addSubview(DescriptionLabel)
        scrollView.addSubview(labelStackViewMain)
        scrollView.addSubview(labelStackViewLocationMain)
        scrollView.addSubview(locationStackViewMain)
        scrollView.addSubview(hr)
        scrollView.addSubview(epStackView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tableView)
        
    }

    func makeConstr() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.width.height.equalTo(150)
            $0.centerX.equalToSuperview()

        }
        labelName.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(labelName.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        DescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().offset(-32)
        }
        labelStackViewMain.snp.makeConstraints {
            $0.top.equalTo(DescriptionLabel.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        labelStackViewNO2.snp.makeConstraints {
            $0.left.equalToSuperview().inset(156)
        }
        labelStackViewLocationMain.snp.makeConstraints {
            $0.top.equalTo(labelStackViewMain.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)

        }
        locationStackViewMain.snp.makeConstraints {
            $0.top.equalTo(labelStackViewLocationMain.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        hr.snp.makeConstraints {
            $0.top.equalTo(locationStackViewMain.snp.bottom).offset(36)
            $0.width.equalToSuperview()
            $0.height.equalTo(1)
        }
        epStackView.snp.makeConstraints {
            $0.top.equalTo(hr.snp.bottom).offset(36)
            $0.left.right.equalToSuperview().inset(16)
        }
//        epLabel1.snp.makeConstraints {
//            $0.wid
//        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.top.equalTo(epStackView.snp.bottom)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(scrollView.snp.bottom).offset(-(list.count*40))
            
        }


    }

}

extension CharacterDetailViewController: UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as? EpisodeTableViewCell else {
            fatalError("Failed to dequeue CharacterTableViewCell")
        }
        
        
        
        cell.backgroundColor = color
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = color
        cell.selectedBackgroundView = selectedBackgroundView
        
        
        
        cell.configure(with: UIImage(named: "Series1.png")!, and: list[indexPath.row])
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    
    
}

