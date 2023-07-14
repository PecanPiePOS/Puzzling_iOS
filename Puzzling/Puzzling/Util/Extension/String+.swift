//
//  String+.swift
//  Puzzling-iOS
//
//  Created by KJ on 2023/07/04.
//

import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isOnlyKorean() -> Bool {
        let pattern = "[가-힣]"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        let size = (self as NSString).size(withAttributes: [.font: font])
        let buffer = 0.2
        return CGSize(width: size.width + buffer, height: size.height)
    }
    
    /// 해야할 것
    /// 1. String -> "월일" 있는 String
    /// 2. String -? / 사용하는 String
    /// 3. Date ->
    
    /// "yyyy-MM-dd" 형식의 String 을 "M월 d일" 형식으로 리턴합니다.
    func convertDateToKoreanDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "M월 d일"
        
        let convertDate = dateFormatter.date(from: self)
        guard let convertedDate = convertDate else { return "" }
        
        let modifiedDateString = myDateFormatter.string(from: convertedDate)
        return modifiedDateString
    }
    
    /// "yyyy-MM-dd" 형식의 String 을 "M/d" 형식으로 리턴합니다.
    func convertDateToSlashFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM/dd"
        
        let convertDate = dateFormatter.date(from: self)
        guard let convertedDate = convertDate else { return "" }
        
        let modifiedDateString = myDateFormatter.string(from: convertedDate)
        return modifiedDateString
    }
    
    /// "yyyy-MM-dd" 형식의 String 을 Date 형식으로 리턴합니다.
    func convertStringToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertDate = dateFormatter.date(from: self)
        guard let convertedDate = convertDate else {
            print("Failed to convert String to Data")
            return Date()
        }
        return convertedDate
        
        /// "yyyy-MM-dd" 형식의 String을 Date 형식으로 리턴합니다.
        func toDate() -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.timeZone = TimeZone(identifier: "KST")
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                return nil
            }
        }
    }
}
