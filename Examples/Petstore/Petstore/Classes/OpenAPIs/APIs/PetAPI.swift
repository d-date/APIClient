//
// PetAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation

public struct PetAPI {
    /**
     Add a new pet to the store
     - POST /pet
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter body: (body) Pet object that needs to be added to the store 
     - returns: RequestBuilder<Void> 
     */
    public static func addPet(body: Pet) -> RequestBuilder<Void> {
        let path = "/pet"
        let parameters = Parameters(
            query: nil,
            form: nil,
            body: AnyEncodable(body))
        return RequestBuilder<Void>(endpoint: path, method: "POST", parameters: parameters)
    }

    /**
     Deletes a pet
     - DELETE /pet/{petId}
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter petId: (path) Pet id to delete 
     - parameter apiKey: (header)  (optional)
     - returns: RequestBuilder<Void> 
     */
    public static func deletePet(petId: Int64, apiKey: String? = nil) -> RequestBuilder<Void> {
        var path = "/pet/{petId}"
        let petIdEscaped = "\(petId)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{petId}", with: petIdEscaped, options: .literal, range: nil)
        let parameters = Parameters(
            query: nil,
            form: nil,
            body: nil)
        return RequestBuilder<Void>(endpoint: path, method: "DELETE", parameters: parameters)
    }

    /**
     * enum for parameter status
     */
    public enum Status_findPetsByStatus: String {
        case available = "available"
        case pending = "pending"
        case sold = "sold"
    }

    /**
     Finds Pets by status
     - GET /pet/findByStatus
     - Multiple status values can be provided with comma separated strings
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter status: (query) Status values that need to be considered for filter 
     - returns: RequestBuilder<[Pet]> 
     */
    public static func findPetsByStatus(status: [String]) -> RequestBuilder<[Pet]> {
        let path = "/pet/findByStatus"
        let parameters = Parameters(
            query: ["status": status],
            form: nil,
            body: nil)
        return RequestBuilder<[Pet]>(endpoint: path, method: "GET", parameters: parameters)
    }

    /**
     Finds Pets by tags
     - GET /pet/findByTags
     - Multiple tags can be provided with comma separated strings. Use tag1, tag2, tag3 for testing.
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter tags: (query) Tags to filter by 
     - returns: RequestBuilder<[Pet]> 
     */
    public static func findPetsByTags(tags: [String]) -> RequestBuilder<[Pet]> {
        let path = "/pet/findByTags"
        let parameters = Parameters(
            query: ["tags": tags],
            form: nil,
            body: nil)
        return RequestBuilder<[Pet]>(endpoint: path, method: "GET", parameters: parameters)
    }

    /**
     Find pet by ID
     - GET /pet/{petId}
     - Returns a single pet
     - API Key:
       - type: apiKey api_key 
       - name: api_key
     - parameter petId: (path) ID of pet to return 
     - returns: RequestBuilder<Pet> 
     */
    public static func getPetById(petId: Int64) -> RequestBuilder<Pet> {
        var path = "/pet/{petId}"
        let petIdEscaped = "\(petId)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{petId}", with: petIdEscaped, options: .literal, range: nil)
        let parameters = Parameters(
            query: nil,
            form: nil,
            body: nil)
        return RequestBuilder<Pet>(endpoint: path, method: "GET", parameters: parameters)
    }

    /**
     Update an existing pet
     - PUT /pet
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter body: (body) Pet object that needs to be added to the store 
     - returns: RequestBuilder<Void> 
     */
    public static func updatePet(body: Pet) -> RequestBuilder<Void> {
        let path = "/pet"
        let parameters = Parameters(
            query: nil,
            form: nil,
            body: AnyEncodable(body))
        return RequestBuilder<Void>(endpoint: path, method: "PUT", parameters: parameters)
    }

    /**
     Updates a pet in the store with form data
     - POST /pet/{petId}
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter petId: (path) ID of pet that needs to be updated 
     - parameter name: (form) Updated name of the pet (optional)
     - parameter status: (form) Updated status of the pet (optional)
     - returns: RequestBuilder<Void> 
     */
    public static func updatePetWithForm(petId: Int64, name: String? = nil, status: String? = nil) -> RequestBuilder<Void> {
        var path = "/pet/{petId}"
        let petIdEscaped = "\(petId)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{petId}", with: petIdEscaped, options: .literal, range: nil)
        let parameters = Parameters(
            query: nil,
            form: ["name": name, "status": status],
            body: nil)
        return RequestBuilder<Void>(endpoint: path, method: "POST", parameters: parameters)
    }

    /**
     uploads an image
     - POST /pet/{petId}/uploadImage
     - OAuth:
       - type: oauth2
       - name: petstore_auth
     - parameter petId: (path) ID of pet to update 
     - parameter additionalMetadata: (form) Additional data to pass to server (optional)
     - parameter file: (form) file to upload (optional)
     - returns: RequestBuilder<ApiResponse> 
     */
    public static func uploadFile(petId: Int64, additionalMetadata: String? = nil, file: URL? = nil) -> RequestBuilder<ApiResponse> {
        var path = "/pet/{petId}/uploadImage"
        let petIdEscaped = "\(petId)".addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{petId}", with: petIdEscaped, options: .literal, range: nil)
        let parameters = Parameters(
            query: nil,
            form: ["additionalMetadata": additionalMetadata, "file": file?.description],
            body: nil)
        return RequestBuilder<ApiResponse>(endpoint: path, method: "POST", parameters: parameters)
    }

}
