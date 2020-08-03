import Foundation

public struct Response<ResponseBody: Equatable> {
    public let statusCode: Int
    public let headers: [AnyHashable: Any]
    public let body: ResponseBody

    public init(statusCode: Int, headers: [AnyHashable: Any], body: ResponseBody) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }
}

extension Response: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.statusCode == rhs.statusCode
            && NSDictionary(dictionary: lhs.headers).isEqual(to: rhs.headers)
            && lhs.body == rhs.body
    }
}

public struct EmptyResponse {
    public let statusCode: Int
    public let headers: [AnyHashable: Any]

    public init(statusCode: Int, headers: [AnyHashable: Any]) {
        self.statusCode = statusCode
        self.headers = headers
    }
}

extension EmptyResponse: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.statusCode == rhs.statusCode
            && NSDictionary(dictionary: lhs.headers).isEqual(to: rhs.headers)
    }
}

public enum Failure: Error {
    case networkError(Error)
    case decodingError(Error, Int, [AnyHashable: Any], Data)
    case responseError(Int, [AnyHashable: Any], Data)
}

extension Failure: Equatable {
    public static func == (lhs: Failure, rhs: Failure) -> Bool {
        switch (lhs, rhs) {
        case (.networkError, .networkError):
            return true
        case (.decodingError(_, let lhsCode, let lhsUserInfo, let lhsData), .decodingError(_, let rhsCode, let rhsUserInfo, let rhsData)),
             (.responseError(let lhsCode, let lhsUserInfo, let lhsData), .responseError(let rhsCode, let rhsUserInfo, let rhsData)):
            return lhsCode == rhsCode
                && NSDictionary(dictionary: lhsUserInfo).isEqual(to: rhsUserInfo)
                && lhsData == rhsData
        default:
            return false
        }
    }
}
