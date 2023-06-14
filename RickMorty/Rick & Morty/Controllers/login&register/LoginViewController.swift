//
//  LoginViewController.swift
//  Rick & Morty
//
//  Created by Yessimkhan Zhumash on 09.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import UserNotifications

class LoginViewController: UIViewController {
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    let backroundColor = UIColor(named: "backroundColor")
    let bigTextColor = UIColor(named: "textColor")
    let smallTextColor = UIColor(named: "miniTextColor")
    let deviderColor = UIColor(named: "deviderColor")
    let tintColor = UIColor(named: "tintColor")
    
    let logoPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Rick&Morty")
        return imageView
    }()
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
        let iconImageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 25, height: 25))
        iconImageView.image = UIImage(named: "person")
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
        vc.addSubview(iconImageView)
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftView = vc
        field.placeholder = "Электронная почта"
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
        let iconImageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 25, height: 25))
        iconImageView.image = UIImage(named: "lock")
        let lvc = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
        lvc.addSubview(iconImageView)
        field.leftViewMode = .always
        field.leftView = lvc
        let seeImageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 25, height: 25))
        let rvc = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 25))
        rvc.addSubview(seeImageView)
        field.rightViewMode = .always
        field.rightView = rvc
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.placeholder = "Пароль"
        field.layer.cornerRadius = 12
        return field
    }()
    let showPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "eye-slashed"), for: .normal)
        button.addTarget(self, action:#selector(showPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func showPasswordButtonTapped(){
        inputName2.isSecureTextEntry.toggle()
        let imageName = inputName2.isSecureTextEntry ? "eye-slashed" : "eye"
        showPasswordButton.setImage(UIImage(named: imageName), for: .normal)
    }
    let stasus3: UILabel = {
        let label = UILabel()
        label.text = "У вас еще нет аккаунта?"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.addTarget(self, action:#selector(registerButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .bold)
        return button
    }()
    @objc func registerButtonTapped(){
        
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.layer.backgroundColor = UIColor(red: 0.133, green: 0.635, blue: 0.741, alpha: 1).cgColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action:#selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func loginButtonTapped(){
        print("loginButton tapped")
        guard let email = inputName1.text, !email.isEmpty,
              let password = inputName2.text, !password.isEmpty else{
            print("missing data")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            print("You have signed in")
            strongSelf.showLoggedInNotification()
            strongSelf.inputName1.resignFirstResponder()
            strongSelf.inputName2.resignFirstResponder()
            let vc = HomeScreen()
            vc.hidesBottomBarWhenPushed = false
            strongSelf.navigationController?.pushViewController(vc, animated: true)
        })
        
    }
    func showCreateAccount(email: String, password: String){
        let alert = UIAlertController(title: "Неверный адрес электронной почты или пароль", message: "Если у вас нет учетной записи, вы должны создать новую учетную запись", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))//, handler: { _ in
        present(alert, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.isHidden = true
        setUpColors()
        setUpViews()
        setUpConstraints()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        print("did load login")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = false
        print("will disappear login")
    }
    
    
    func showLoggedInNotification() {
        let content = UNMutableNotificationContent()
        content.title = "You are logged in"
        content.body = "Welcome back!"
        content.sound = UNNotificationSound.default
        
        // Set the notification trigger for immediate display
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.25, repeats: false)
        
        // Create the notification request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // Schedule the notification
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
        
        print("you are logged in ehooooy")
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        inputName1.becomeFirstResponder()
//        inputName2.becomeFirstResponder()
//    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // MARK: - setupViews
}
private extension LoginViewController{
    
    func setUpColors(){
        view.backgroundColor = backroundColor
        stasus1.textColor = bigTextColor
        stasus2.textColor = bigTextColor
        inputName1.textColor = bigTextColor
        inputName1.backgroundColor = deviderColor
        inputName2.textColor = bigTextColor
        inputName2.backgroundColor = deviderColor
        stasus3.textColor = smallTextColor
        registerButton.setTitleColor(tintColor, for: .normal)
    }
    
    func setUpViews(){
        view.addSubview(logoPhotoView)
        view.addSubview(stasus1)
        view.addSubview(inputName1)
        view.addSubview(stasus2)
        view.addSubview(inputName2)
        view.addSubview(stasus3)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        view.addSubview(showPasswordButton)
    }
    
    func setUpConstraints(){
        
        logoPhotoView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.height.equalTo(376.22)
            make.centerX.equalToSuperview()
        }
        
        stasus1.snp.makeConstraints { make in
            make.top.equalTo(logoPhotoView.snp.bottom).inset(-65)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        inputName1.snp.makeConstraints { make in
            make.top.equalTo(stasus1.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        stasus2.snp.makeConstraints { make in
            make.top.equalTo(inputName1.snp.bottom).inset(-10)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        inputName2.snp.makeConstraints { make in
            make.top.equalTo(stasus2.snp.bottom).inset(-8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        showPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(inputName2.snp.centerY)
            make.trailing.equalToSuperview().inset(30)
            make.width.height.equalTo(25)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        stasus3.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(70)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        registerButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(70)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
    }
}
