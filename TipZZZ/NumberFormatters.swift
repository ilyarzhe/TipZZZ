import Foundation

enum NumberFormatters {
    static let formatter: NumberFormatter = {
        let billFormatter = NumberFormatter()
        billFormatter.numberStyle = .decimal
        billFormatter.groupingSeparator = ","
        billFormatter.usesGroupingSeparator = true
        return billFormatter
    }()
}
