//
//  EditNameViewController.swift
//  Rick & Morty
//
//  Created by Yessimkhan Zhumash on 09.06.2023.
//

import UIKit
import SnapKit

class EditNameViewController: UIViewController {
    
    let backroundColor = UIColor(named: "backroundColor")
    let bigTextColor = UIColor(named: "textColor")
    let smallTextColor = UIColor(named: "miniTextColor")
    let deviderColor = UIColor(named: "deviderColor")
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    let Title: UILabel = {
        let label = UILabel()
        label.text = "Изменить ФИО"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    let stasus1: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let inputName1:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        field.placeholder = "Oleg"
        field.layer.cornerRadius = 12
        return field
    }()
    let stasus2: UILabel = {
        let label = UILabel()
        label.text = "Фамилия"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let inputName2:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        field.placeholder = "Belotserkovsky"
        field.layer.cornerRadius = 12
        return field
    }()
    let stasus3: UILabel = {
        let label = UILabel()
        label.text = "Отчество"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let inputName3:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        field.placeholder = "Отчество"
        field.layer.cornerRadius = 12
        return field
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.133, green: 0.635, blue: 0.741, alpha: 1).cgColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action:#selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func saveButtonTapped(){
//        let vc = EditProfileViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
        setUpColors()
        setUpConstraints()
        self.navigationController?.navigationBar.isHidden = true
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        print("name did load")
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
}
private extension EditNameViewController{
    func setUpColors(){
        Title.textColor = bigTextColor
        backButton.imageView?.tintColor = bigTextColor
        view.backgroundColor = backroundColor
        stasus1.textColor = bigTextColor
        inputName1.textColor = bigTextColor
        inputName1.tintColor = bigTextColor
        inputName1.backgroundColor = deviderColor
        stasus2.textColor = bigTextColor
        inputName2.textColor = bigTextColor
        inputName2.tintColor = bigTextColor
        inputName2.backgroundColor = deviderColor
        stasus3.textColor = bigTextColor
        inputName3.textColor = bigTextColor
        inputName3.tintColor = bigTextColor
        inputName3.backgroundColor = deviderColor
        
    }
    func setUpView(){
        view.addSubview(Title)
        view.addSubview(backButton)
        view.addSubview(stasus1)
        view.addSubview(inputName1)
        view.addSubview(stasus2)
        view.addSubview(inputName2)
        view.addSubview(stasus3)
        view.addSubview(inputName3)
        view.addSubview(saveButton)
    }
    func setUpConstraints(){
        Title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(28)
        }
        stasus1.snp.makeConstraints { make in
            make.top.equalTo(Title.snp.bottom).inset(-60)
            make.leading.equalToSuperview().inset(20)
        }
        inputName1.snp.makeConstraints { make in
            make.top.equalTo(stasus1.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        stasus2.snp.makeConstraints { make in
            make.top.equalTo(inputName1.snp.bottom).inset(-10)
            make.leading.equalToSuperview().inset(20)
        }
        inputName2.snp.makeConstraints { make in
            make.top.equalTo(stasus2.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        stasus3.snp.makeConstraints { make in
            make.top.equalTo(inputName2.snp.bottom).inset(-10)
            make.leading.equalToSuperview().inset(20)
        }
        inputName3.snp.makeConstraints { make in
            make.top.equalTo(stasus3.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(70)
            make.height.equalTo(48)
        }
    }
}
