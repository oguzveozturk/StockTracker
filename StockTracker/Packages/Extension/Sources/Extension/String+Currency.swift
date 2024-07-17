import Foundation

extension String {
    private static let currencyCodes = [
        "usd": "$",
        "USD": "$",
        "try": "₺",
        "TRY": "₺",
        "tl" : "₺",
        "TL" : "₺"
    ]
    
    public var currencySymbol: String? {
        Self.currencyCodes[self]
    }
}

extension Optional where Wrapped == String {
    public var symbolForCurrencyCode: String? {
        guard let code = self else {
            return nil
        }
        return code.currencySymbol
    }
}
