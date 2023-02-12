import UIKit
import WeightUI

final class UIAppService: ApplicationService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        WeightUI.setup()
        return true
    }
}
