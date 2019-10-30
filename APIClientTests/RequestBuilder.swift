import Foundation
import APIClient
import PetStore

extension RequestBuilder {
    public func request() -> Request<Response> {
        if let parameters = parameters {
            let query = parameters.query
            let form = parameters.form
            let json = parameters.body

            return Request<Response>(endpoint: endpoint, method: method, parameters: Request.Parameters(query: query, form: form, jsonRaw: json))
        }
        return Request(endpoint: endpoint, method: method)
    }
}
