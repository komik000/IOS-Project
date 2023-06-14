//
//  RegisterViewController.swift
//  Rick & Morty
//
//  Created by Yessimkhan Zhumash on 10.06.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    var tapGestureRecognizer: UITapGestureRecognizer!
    let backroundColor = UIColor(named: "backroundColor")
    let bigTextColor = UIColor(named: "textColor")
    let smallTextColor = UIColor(named: "miniTextColor")
    let deviderColor = UIColor(named: "deviderColor")
    
    let Title: UILabel = {
        let label = UILabel()
        label.text = "Редактировать профиль"
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
        label.text = "Электронная почта"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let inputName1:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        field.placeholder = "Электронная почта"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        return field
    }()
    let stasus2: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let inputName2:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        return field
    }()
    let stasus3: UILabel = {
        let label = UILabel()
        label.text = "Подтвердите пароль"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let inputName3:UITextField = {
        let field = UITextField()
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width:16,height:0))
        field.placeholder = "Подтвердите пароль"
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = 12
        return field
    }()
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.133, green: 0.635, blue: 0.741, alpha: 1).cgColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action:#selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func saveButtonTapped(){
        guard let email = inputName1.text, !email.isEmpty,
              let password = inputName2.text, !password.isEmpty,
              let repeatPassword = inputName3.text, !repeatPassword.isEmpty
        else{
            print("missing data")
            return
        }
        if(password != repeatPassword){
            let alert = UIAlertController(title: "Пароли не совпадают", message: "Пожалуйста, убедитесь, что пароли совпадают", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }else{
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let strongSelf = self else{
                    return
                }
                guard error == nil else{
                    print("acc creation failed")
                    return
                }
                let vc = HomeScreen()
                strongSelf.navigationController?.pushViewController(vc, animated: true)
                print("You have signed in")
                strongSelf.inputName1.resignFirstResponder()
                strongSelf.inputName2.resignFirstResponder()
                strongSelf.inputName3.resignFirstResponder()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        setUpView()
        setUpColors()
        setUpConstraints()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.cancelsTouchesInView = false
        self.navigationController?.navigationBar.isHidden = true
        view.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = false
    }
    lazy var y = {
        return self.saveButton.frame.origin.y
    }()
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.saveButton.frame.origin.y == y {
                self.saveButton.frame.origin.y -= (keyboardSize.height-30)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.saveButton.frame.origin.y != y {
            self.saveButton.frame.origin.y = y
        }
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

private extension RegisterViewController{
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
