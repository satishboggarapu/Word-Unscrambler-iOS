import UIKit

public struct Font {

    // Alegreya
    public struct AlegreyaSans {

        public static func regular(with size: CGFloat) -> UIFont {
            let size = size + FontOffset
            if let font = UIFont(name: "AlegreyaSans-Regular", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size)
        }

        public static func medium(with size: CGFloat) -> UIFont {
            let size = size + FontOffset
            if let font = UIFont(name: "AlegreyaSans-Medium", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size)
        }

        public static func bold(with size: CGFloat) -> UIFont {
            let size = size + FontOffset
            if let font = UIFont(name: "AlegreyaSans-Bold", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size)
        }

        public static func extraBold(with size: CGFloat) -> UIFont {
            let size = size + FontOffset
            if let font = UIFont(name: "AlegreyaSans-ExtraBold", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size)
        }

        public static func black(with size: CGFloat) -> UIFont {
            let size = size + FontOffset
            if let font = UIFont(name: "AlegreyaSans-Black", size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size)
        }

        private static var FontOffset: CGFloat {
            get {
                switch Device.type {
                case .iPhoneSE:
                    return 4
                case .iPhoneNormal:
                    return 6
                case .iPhonePlus:
                    return 6
                case .iPhoneX:
                    return 6
                case .iPhoneXR:
                    return 6
                case .iPhoneXSMax:
                    return 6
                case .iPadPro9_2048:
                    return 10
                case .iPadPro10_2388:
                    return 15
                case .iPadPro12_2732:
                    return 15
                default:
                    if Device.isDeviceIPad {
                        return 14
                    } else {
                        return 5
                    }
                }
            }
        }
    }
}