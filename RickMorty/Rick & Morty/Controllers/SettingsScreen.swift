//
//  SettingsScreen.swift
//  Rick & Morty
//
//  Created by Alisher Manatbek on 04.06.2023.
//

import UIKit
import SnapKit

class SettingsScreen: UIViewController {
    
    let backroundColor = UIColor(named: "backroundColor")
    let bigTextColor = UIColor(named: "textColor")
    let smallTextColor = UIColor(named: "miniTextColor")
    let deviderColor = UIColor(named: "deviderColor")
    let window = SceneDelegate.window
    
    let Title: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let userPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "levi")
        return imageView
    }()
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Oleg Belotserkovsky"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    let userDiscription: UILabel = {
        let label = UILabel()
        label.text = "Rick"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        return label
    }()
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Редактировать", for: .normal)
        button.layer.borderColor = UIColor(red: 0.133, green: 0.635, blue: 0.741, alpha: 1).cgColor
        button.setTitleColor(UIColor(red: 0.133, green: 0.635, blue: 0.741, alpha: 1), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.addTarget(self, action:#selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func editButtonTapped(){
        let vc = EditProfileViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let devider1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.082, green: 0.165, blue: 0.227, alpha: 1)
        return view
    }()
    let status1: UILabel = {
        let label = UILabel()
        let text = "Внешний вид"
        label.text = text.uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.357, green: 0.412, blue: 0.459, alpha: 1)
        return label
    }()
    let colorPalette: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "paintpalette")
        imageView.tintColor = .white
        return imageView
    }()
    let darkMode: UILabel = {
        let label = UILabel()
        label.text = "Темная тема"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let darkModeDescription: UILabel = {
        let label = UILabel()
        label.text = "Следовать настройкам системы"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.431, green: 0.475, blue: 0.549, alpha: 0.6)
        return label
    }()
    let dropDownButton: UIButton = {
       let button = UIButton()
        button.setImage(
            UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action:#selector(isTappedDropDownButton), for: .touchUpInside)
        return button
    }()
    
    
    @objc func isTappedDropDownButton(_ sender: Any){
        let alert = UIAlertController(title: "Темная тема", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let on = UIAlertAction(title: "Включенна", style: UIAlertAction.Style.default, handler:{ UIAlertAction in self.darkModeDescription.text = "Включенна"
            self.window?.overrideUserInterfaceStyle = .dark
        })
        on.setValue(bigTextColor, forKey: "titleTextColor")
        alert.addAction(on)
        let off = UIAlertAction(title: "Выключенна", style: UIAlertAction.Style.default, handler:{ UIAlertAction in self.darkModeDescription.text = "Выключенна"
            self.window?.overrideUserInterfaceStyle = .light
        })
        off.setValue(bigTextColor, forKey: "titleTextColor")
        alert.addAction(off)
        let system = UIAlertAction(title: "Следовать настройкам системы", style: UIAlertAction.Style.default, handler:{ UIAlertAction in self.darkModeDescription.text = "Следовать настройкам системы"
            self.window?.overrideUserInterfaceStyle = .unspecified
        })
        system.setValue(bigTextColor, forKey: "titleTextColor")
        alert.addAction(system)
        self.present(alert, animated: true)
        
    }
    let devider2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.082, green: 0.165, blue: 0.227, alpha: 1)
        return view
    }()
    let status2: UILabel = {
        let label = UILabel()
        let text = "О приложении"
        label.text = text.uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.357, green: 0.412, blue: 0.459, alpha: 1)
        return label
    }()
    let appDescription: UILabel = {
        let label = UILabel()
        label.text = "Зигерионцы помещают Джерри и Рика в симуляцию, чтобы узнать секрет изготовления концентрированной темной материи."
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    let devider3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.082, green: 0.165, blue: 0.227, alpha: 1)
        return view
    }()
    let status3: UILabel = {
        let label = UILabel()
        let text = "Версия приложения"
        label.text = text.uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.357, green: 0.412, blue: 0.459, alpha: 1)
        return label
    }()
    let appVersion: UILabel = {
        let label = UILabel()
        label.text = "Rick & Morty  v1.0.0"
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        makeConstraints()
        setUpColors()
    }
}
//MARK: - Setup View and Constraints
private extension SettingsScreen{
    
    func setUpColors(){
        view.backgroundColor = backroundColor
        Title.textColor = bigTextColor
        userName.textColor = bigTextColor
        userDiscription.textColor = smallTextColor
        darkMode.textColor = bigTextColor
        darkModeDescription.textColor = smallTextColor
        devider1.backgroundColor = deviderColor
        devider2.backgroundColor = deviderColor
        devider3.backgroundColor = deviderColor
        status1.textColor = smallTextColor
        status2.textColor = smallTextColor
        status3.textColor = smallTextColor
        colorPalette.tintColor = bigTextColor
        dropDownButton.tintColor = bigTextColor
        appVersion.textColor = bigTextColor
        appDescription.textColor = bigTextColor
    }
    func setUpViews(){
        view.addSubview(Title)
        view.addSubview(userPhotoView)
        view.addSubview(userName)
        view.addSubview(userDiscription)
        view.addSubview(editButton)
        view.addSubview(devider1)
        view.addSubview(status1)
        view.addSubview(colorPalette)
        view.addSubview(darkMode)
        view.addSubview(darkModeDescription)
        view.addSubview(dropDownButton)
        view.addSubview(devider2)
        view.addSubview(status2)
        view.addSubview(appDescription)
        view.addSubview(devider3)
        view.addSubview(status3)
        view.addSubview(appVersion)
    }
    func makeConstraints() {
        
        Title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        userPhotoView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(116)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(80)
        }
        userName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(132)
            make.leading.equalTo(userPhotoView.snp.trailing).inset(-16)
            make.height.equalTo(24)
        }
        userDiscription.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).inset(-4)
            make.leading.equalTo(userPhotoView.snp.trailing).inset(-16)
            make.height.equalTo(20)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalTo(userPhotoView.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        devider1.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).inset(-40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        status1.snp.makeConstraints { make in
            make.top.equalTo(devider1.snp.bottom).inset(-36)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        colorPalette.snp.makeConstraints { make in
            make.top.equalTo(status1.snp.bottom).inset(-28)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(36)
        }
        darkMode.snp.makeConstraints { make in
            make.top.equalTo(status1.snp.bottom).inset(-24)
            make.leading.equalTo(colorPalette.snp.trailing).inset(-16)
            make.height.equalTo(24)
        }
        darkModeDescription.snp.makeConstraints { make in
            make.top.equalTo(darkMode.snp.bottom)
            make.leading.equalTo(colorPalette.snp.trailing).inset(-16)
            make.height.equalTo(20)
        }
        dropDownButton.snp.makeConstraints { make in
            make.centerY.equalTo(colorPalette.snp.centerY)
            make.trailing.equalToSuperview().inset(20)
        }
        devider2.snp.makeConstraints { make in
            make.top.equalTo(darkModeDescription.snp.bottom).inset(-36)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        status2.snp.makeConstraints { make in
            make.top.equalTo(devider2.snp.bottom).inset(-36)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        appDescription.snp.makeConstraints { make in
            make.top.equalTo(status2.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        devider3.snp.makeConstraints { make in
            make.top.equalTo(appDescription.snp.bottom).inset(-36)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        status3.snp.makeConstraints { make in
            make.top.equalTo(devider3.snp.bottom).inset(-36)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        appVersion.snp.makeConstraints { make in
            make.top.equalTo(status3.snp.bottom).inset(-24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
