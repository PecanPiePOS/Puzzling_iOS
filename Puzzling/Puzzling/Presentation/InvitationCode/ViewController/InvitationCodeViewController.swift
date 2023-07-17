//
//  InvitationCodeViewController.swift
//  Puzzling
//
//  Created by KJ on 2023/07/17.
//

import UIKit

import Moya
import SnapKit
import Then

final class InvitationCodeViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let navigationView = UIView()
    private let navigationTitleLabel = UILabel()
    private let closeButton = UIButton()
    private let logoImageView = UIImageView()
    private let invitationCodeInputView = InputContentView(type: .invitationCode)
    private let inputCompletionButton = CheckButton()
    
    // MARK: - Properties
    
    var invitationCode: String = ""
    
    // MARK: - Initializer
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setupKeyboardEvent()
        setTapScreen()
        setNotification()
        setAddTarget()
    }
}

extension InvitationCodeViewController {
    
    // MARK: - UI Components Property
    
    private func setUI() {
        
        view.backgroundColor = .white000
        
        navigationView.do {
            $0.backgroundColor = .clear
        }
        
        navigationTitleLabel.do {
            $0.text = "프로젝트 등록하기"
            $0.font = .fontGuide(.heading4_kor)
            $0.textColor = .black000
        }
        
        closeButton.do {
            $0.setImage(Image.xMark, for: .normal)
        }
        
        logoImageView.do {
            $0.image = Image.invitationCodeLogo
        }
        
        inputCompletionButton.do {
            $0.setTitle("입력 완료", for: .normal)
            $0.setState(.notAllow)
        }
    }
    
    // MARK: - Layout Helper
    
    private func setLayout() {
        
        navigationView.addSubviews(navigationTitleLabel, closeButton)
        view.addSubviews(navigationView, logoImageView,
                         invitationCodeInputView, inputCompletionButton)
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
        
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.centerY.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(88)
            $0.centerX.equalToSuperview()
        }
        
        invitationCodeInputView.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(80)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(106)
        }
        
        inputCompletionButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(55)
        }
    }
    
    // MARK: - Methods
    
    private func setAddTarget() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
        inputCompletionButton.addTarget(self, action: #selector(inputCompletionButtonDidTap), for: .touchUpInside)
    }
    
    private func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setTapScreen() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getTextFieldInfo(_:)), name: Notification.Name("textFieldNotification"), object: nil)
    }
    
    private func buttonStateSetting() {
        !invitationCode.isEmpty ? inputCompletionButton.setState(.allow) : inputCompletionButton.setState(.notAllow)
    }
    
    private func presentToCreateProfile() {
        let createProfileVC = CreateProfileViewController()
        createProfileVC.modalPresentationStyle = .fullScreen
        self.present(createProfileVC, animated: true)
    }
    
    private func dismissToMain() {
        dismiss(animated: true)
    }
    
    // MARK: - @objc Methods
    
    @objc
    private func inputCompletionButtonDidTap() {
        presentToCreateProfile()
    }
    
    @objc func closeButtonDidTap() {
        dismissToMain()
    }
    
    @objc
    private func didTapScreen(_ gesture: UITapGestureRecognizer) {
        gesture.location(in: self.view)
        self.view.endEditing(true)
    }
    
    @objc
    private func keyboardWillShow(_ sender: Notification) {
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        let keyboardOverlap = textFieldBottomY - keyboardTopY
        view.frame.origin.y = -keyboardOverlap - 40
    }
    
    @objc
    private func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    @objc
    private func getTextFieldInfo(_ notification: Notification) {
        if let textInfo = notification.userInfo as? [String: TextFieldInfo], let updateTextInfo = textInfo["userInfo"] {
            if updateTextInfo.type == .invitationCode {
                invitationCode = updateTextInfo.text
            }
            buttonStateSetting()
        }
    }
}
