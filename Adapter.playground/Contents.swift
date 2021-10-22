import UIKit

var str = "Hello, playground"

protocol Account {
    var accountNumber: String? { get }
    var accountId: String? { get }
}

class ThirdPartyAccount {
    var accountidentifier: String?
    var accountScudocode: String?
}

class AdapterAccount: Account {
    var account: ThirdPartyAccount
    
    init(account: ThirdPartyAccount) {
        self.account = account
    }
    
    var accountNumber: String? {
        return self.account.accountScudocode
    }
    var accountId: String? {
        return self.account.accountidentifier
    }
}


