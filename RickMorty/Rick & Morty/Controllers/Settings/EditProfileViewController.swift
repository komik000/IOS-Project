//
//  EditProfileViewController.swift
//  Rick & Morty
//
//  Created by Yessimkhan Zhumash on 08.06.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class EditProfileViewController: UIViewController {
    
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
        self
    }
    let userPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "levi")
        return imageView
    }()
    let editPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить фото", for: .normal)
        button.setTitleColor(UIColor(red: 0.133, green: 0.635, blue: 0.741, alpha: 1), for: .normal)
        button.addTarget(self, action:#selector(editPhotoButtonTapped), for: .touchUpInside)
        return button
    }()
    @objc func editPhotoButtonTapped(){
//        let vc = EditProfileViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    let status1: UILabel = {
        let label = UILabel()
        let text = "Профиль"
        label.text = text.uppercased()
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.357, green: 0.412, blue: 0.459, alpha: 1)
        return label
    }()
    let userName: UILabel = {
        let label = UILabel()
        label.text = "Изменить ФИО"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let userNameDescription: UILabel = {
        let label = UILabel()
        label.text = "Oleg Belotserkovsky"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.431, green: 0.475, blue: 0.549, alpha: 0.6)
        return label
    }()
    let editUserNameButton: UIButton = {
       let button = UIButton()
        button.setImage(
            UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action:#selector(isTappedEditUserNameButton), for: .touchUpInside)
        return button
    }()
    @objc func isTappedEditUserNameButton(_ sender: Any){
        let vc = EditNameViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    let logoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Logout"
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    let logoutLabelDexcription: UILabel = {
        let label = UILabel()
        label.text = "Oleg Belotserkovsky"
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.431, green: 0.475, blue: 0.549, alpha: 0.6)
        return label
    }()
    let logoutButton: UIButton = {
       let button = UIButton()
        button.setImage(
            UIImage(systemName: "chevron.right"), for: .normal)
        button.addTarget(self, action:#selector(isTappedLoginButton), for: .touchUpInside)
        return button
    }()
    @objc func isTappedLoginButton(_ sender: Any){
        let alert = UIAlertController(title: "Log Out", message: "Are you shure you want to log out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Contiue", style: .default, handler: { _ in
            do{
                if FirebaseAuth.Auth.auth().currentUser != nil{
                    try FirebaseAuth.Auth.auth().signOut()
                    print("you are logged out")
                }else{
                    print("you are not logged in")
                }
                let vc = LoginViewController()
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.setViewControllers([vc], animated: true)
//                self.navigationController?.pushViewController(vc, animated: true)
            }catch{
               print("An error occured")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        print("profile didload")
        super.viewDidLoad()
        setUpView()
        setUpColors()
        setUpConstraints()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
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

private extension EditProfileViewController{
    
    func setUpColors(){
        Title.textColor = bigTextColor
        backButton.imageView?.tintColor = bigTextColor
        view.backgroundColor = backroundColor
        status1.textColor = smallTextColor
        userName.textColor = bigTextColor
        userNameDescription.textColor = smallTextColor
        logoutLabel.textColor = bigTextColor
        logoutLabelDexcription.textColor = bigTextColor
        logoutLabel.tintColor = bigTextColor
        logoutButton.imageView?.tintColor = bigTextColor
        editUserNameButton.imageView?.tintColor = bigTextColor
    }
    func setUpView(){
        view.addSubview(Title)
        view.addSubview(backButton)
        view.addSubview(userPhotoView)
        view.addSubview(editPhotoButton)
        view.addSubview(status1)
        view.addSubview(userName)
        view.addSubview(userNameDescription)
        view.addSubview(editUserNameButton)
        view.addSubview(logoutLabel)
        view.addSubview(logoutLabelDexcription)
        view.addSubview(logoutButton)
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
        userPhotoView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(124)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        editPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(userPhotoView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        status1.snp.makeConstraints { make in
            make.top.equalTo(editPhotoButton.snp.bottom).inset(-40)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(16)
        }
        userName.snp.makeConstraints { make in
            make.top.equalTo(status1.snp.bottom).inset(-24)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        userNameDescription.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        editUserNameButton.snp.makeConstraints { make in
            make.top.equalTo(status1.snp.bottom).inset(-42)
            make.trailing.equalToSuperview().inset(20)
        }
        logoutLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameDescription.snp.bottom).inset(-20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        logoutLabelDexcription.snp.makeConstraints { make in
            make.top.equalTo(logoutLabel.snp.bottom)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(status1.snp.bottom).inset(-106)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
