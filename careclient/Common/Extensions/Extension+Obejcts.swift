//
// Copyright ©2023 유니메오.
// All Rights Reserved.
//

import UIKit
import Foundation
import Photos


///dateFromat 구분자 스타일
enum DateFormatterStyle: String {
    case dot = "."
    case hypoon = "-"
}

// MARK: - extension - Double
extension Double {
    ///자리수 반올림,올림,내림처리후 문자열로 치환
    func toFloorString(min: Int = 0, max: Int = 0, mode: NumberFormatter.RoundingMode = .floor) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = mode
        numberFormatter.minimumSignificantDigits = min
        numberFormatter.maximumSignificantDigits = max
        return numberFormatter.string(for: self)
    }
}

// MARK: - extension - Int
extension Int {
    ///1,000 형식으로 변경
    var decimalString: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter.string(for: self) ?? "0"
        }
    }
}

// MARK: - extension - Bool
extension Bool {
    var toInt:Int {
        return self ? 1 : 0
    }
}

// MARK: - extension - DateFormatter
extension DateFormatter {
    ///날짜 표기
    func showDateStr(_ date: Date, style: DateFormatterStyle = .hypoon) -> String {
        self.dateFormat = "yyyy\(style.rawValue)MM\(style.rawValue)dd"
        return self.string(from: date)
    }
    
    func toServerSendDateStyle(date: Date) -> String {
        self.dateFormat = "yyyy-MM-dd"
        return self.string(from: date)
    }
    
    func toDateStyleFromServer(str: String) -> Date {
        self.timeZone = TimeZone(identifier: "UTC")
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return self.date(from: str)!
    }
    
    func toShowslushFormDateStyle(date: Date) -> String {
        self.dateFormat = "MM/dd"
        return self.string(from: date)
    }
    
    func toDateTime(date: Date) -> String {
        self.dateFormat = "H:mm"
        return self.string(from: date)
    }
    
    func toKrStringyyyymd(date: Date) -> String {
        self.dateFormat = "yyyy년 M월 d일"
        return self.string(from: date)
    }
}


// MARK: - extension - String
extension String {
    
    
    ///특정 포멧의 문자열을 Date객체로 변환
    func stringToDate(formatter:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = formatter
        return dateForamtter.date(from: self)
    }
    
    
    ///url -> String으로 디코딩
    var decodeUrl: URL? {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }
        
        return URL(string: encoded)
    }
    
    /// utf-8으로 인코딩된 문자열 ascii로 변경
    var decodeEmoji: String {
        let string = self.lowercased()
        let data = string.data(using: .utf8)
        if let data = data, let str = String(data: data, encoding: .nonLossyASCII) {
            return str
        }
        return self
    }
    
    func jsonStringConvert<T>(_ type: T.Type) throws -> T? {
        if let data = self.data(using: .utf8) {
            return try JSONSerialization.jsonObject(with: data, options: []) as? T
        }
        else {
            return nil
        }
    }
    
    
    ///문자열 ascii로 인코딩
    var encodeEmoji: String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
}

// MARK: - extension - Date
extension Date {
    ///년
    var year: Int {
        let cal = Calendar.current
        return cal.component(.year, from: self)
    }
    
    ///월
    var momth: Int {
        let cal = Calendar.current
        return cal.component(.month, from: self)
    }
    
    ///일
    var day: Int {
        let cal = Calendar.current
        return cal.component(.day, from: self)
    }
    
    ///시
    var hour: Int {
        let cal = Calendar.current
        return cal.component(.hour, from: self)
    }
    
    ///분
    var minute: Int {
        let cal = Calendar.current
        return cal.component(.minute, from: self)
    }
    
    ///초
    var second: Int {
        let cal = Calendar.current
        return cal.component(.second, from: self)
    }
    
    ///날짜를 포멧된 문자열로 변경
    func dateToString(formatter:String = "yyyy-MM-dd HH:mm:ss", locale: Locale = Locale(identifier: "ko_KR")) -> String {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = formatter
        dateForamtter.locale = locale
        
        return dateForamtter.string(from: self)
    }
    
    ///해당 월의 1일
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }

    ///해당 월의 말일
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func getDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier:"ko_KR")
        let convertStr = formatter.string(from: self)
        return convertStr
    }
}


// MARK: - extension - UIImage
extension UIImage {
    
    ///placeHolder 이미지 (앱 로고)
    static var placeHolderImage:UIImage? {
        return Bundle.main.icon
    }
    
    ///이미지 비율로 크기 조정
    func resizeImageToData(width: CGFloat) -> Data? {
        let size = self.size
        let ratio = width / size.width
        if size.width < width {
            return self.jpegData(compressionQuality: 1.0)
        }
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage?.jpegData(compressionQuality: 1.0)
    }
}

extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
            let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
            let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
            let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
