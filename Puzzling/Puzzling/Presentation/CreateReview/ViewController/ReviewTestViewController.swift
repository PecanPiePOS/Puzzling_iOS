//
//  testViewController.swift
//  Puzzling
//
//  Created by 천성우 on 2023/07/13.
//

import UIKit

import Moya
import Then
import SnapKit

class ReviewTestViewController: UIViewController {
    
    private let pushButton = UIButton()
    
//    let previousTemplateProvider = MoyaProvider<CreateRetrospectService>(plugins: [NetworkLoggerPlugin(verbose: true)])
//    private var previousTemplateId: PreviousTemplateModel?
    private var templateNum: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        setLayout()
        setDelegate()
    }
    
    private func setUI() {
        view.backgroundColor = .white000
        
        view.addSubview(pushButton)
        
        pushButton.do {
            $0.setTitle("규보심의 뷰에서 나오는 버튼~", for: .normal)
            $0.addTarget(self,
                        action: #selector(pushButtonTapped),
                        for: .touchUpInside)
            $0.backgroundColor = .blue400
        }
        pushButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setLayout() {
        
    }
    
    private func setDelegate() {
        
    }
    
    func pushToCreateRetrospectViewController() {
        let VC = CreateReViewViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
//    func fetchPreviousTemplate() {
//        previousTemplateProvider.request(.previousTemplate(memberID: "7", projectID: "2")) { result in
//            switch result {
//            case .success(let result):
//                let status = result.statusCode
//                if status >= 200 && status < 300 {
//                    do {
//                        guard let data = try result.map(GeneralResponse<PreviousTemplateResponce>.self).data else {
//                            return
//                        }
//
//                        self.previousTemplateId = data.convertToPreviousTemplate()
//                        let template = data
//                        print(template)
//                        print("♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️♥️")
//                        print(self.previousTemplateId)
//                        if let templateNum = self.previousTemplateId?.previousTemplateId {
//                            print("이전에 작성한 회고 Option은~")
//                            print("♥️♥️♥️♥️ \(templateNum) 입니다♥️♥️♥️♥️")
//                            let crVC = CreateReViewViewController(option: templateNum, templateID: templateNum)
//                            self.navigationController?.pushViewController(crVC, animated: true)
//
//                        }
//                    }
//                    catch (let error) {
//                        print(error.localizedDescription)
//                    }
//                }
//                else if status >= 400 {
//                    print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
//                    print("400 이상에러")
//                    print("💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭💭")
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    @objc
    func pushButtonTapped() {
        pushToCreateRetrospectViewController()
//        fetchPreviousTemplate()
//        showToast(withImage: Image.checkW, message: "저장 완료!")
    }
}
