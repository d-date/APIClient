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
        public let query: [String: Any?]?
        public let form: [String: String?]?
        public let json: Data?

        public init<T: Encodable>(query: [String: Any?]?, form: [String: String?]?, jsonRaw: T?, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .iso8601, dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64) {
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

    func makeURLRequest(baseURL: URL, headers: [AnyHashable: Any]) -> URLRequest {
        let url = baseURL.appendingPathComponent(endpoint)

        var request = URLRequest(url: url)
        request.httpMethod = method.description

        headers.forEach {
            if let key = $0.key as? String, let value = $0.value as? String {
                request.addValue(value, forHTTPHeaderField: key)
            }
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
            components.queryItems?.append(contentsOf: raw.compactMap {
                if let value = $0.value {
                    return URLQueryItem(name: $0.key, value: value.addingPercentEncoding(withAllowedCharacters: .alphanumerics))
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