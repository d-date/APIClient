import Foundation

public struct Request<ResponseBody> {
    public let endpoint: String
    public let method: String
    public let parameters: Parameters?

    public init(endpoint: String, method: String, parameters: Parameters? = nil) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
    }

    public struct Parameters {
        public struct Form {
            var parameters: [String: String?]
            var allowedCharacters: CharacterSet

            public init?(parameters: [String: String?]?, allowedCharacters: CharacterSet = .alphanumerics) {
                guard let parameters = parameters else { return nil }
                self.parameters = parameters
                self.allowedCharacters = allowedCharacters
            }
        }

        public let query: [String: Any?]?
        public let form: Form?
        public let json: Data?

        public init<T: Encodable>(query: [String: Any?]?, form: Form?, jsonRaw: T?, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601, dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64) {
            self.query = query
            self.form = form

            if let jsonRaw = jsonRaw {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = dateEncodingStrategy
                encoder.dataEncodingStrategy = dataEncodingStrategy
                if let data = try? encoder.encode(jsonRaw) {
                    self.json = data
                } else {
                    self.json = nil
                }
            } else {
                self.json = nil
            }
        }
    }

    func makeURLRequest(baseURL: URL, headers: [String: String]) -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint)

        var request = URLRequest(url: url)
        request.httpMethod = method.description

        headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }

        guard let parameters = parameters,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return request
        }

        if let query = parameters.query {
            var queryItems = [URLQueryItem]()
            for (key, value) in query {
                switch value {
                case let values as [Any?]:
                    let items: [URLQueryItem] = values.compactMap {
                        if let value = $0 {
                            return URLQueryItem(name: key, value: "\(value)")
                        }
                        return nil
                    }
                    queryItems.append(contentsOf: items)

                case let value?:
                    queryItems.append(URLQueryItem(name: key, value: "\(value)"))

                default:
                    break
                }
            }
            components.queryItems = queryItems
        }
        if let raw = parameters.form {
            components.queryItems?.append(contentsOf: raw.parameters.compactMap {
                if let value = $0.value?.addingPercentEncoding(withAllowedCharacters: raw.allowedCharacters),
                    let key = $0.key.addingPercentEncoding(withAllowedCharacters: raw.allowedCharacters) {
                    return URLQueryItem(name: key, value: value)
                }
                return nil
            })

            if let query = components.query {
                request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpBody = query.data(using: .utf8)
            }
        }

        if let json = parameters.json {
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = json
        }

        request.url = components.url

        return request
    }
}
