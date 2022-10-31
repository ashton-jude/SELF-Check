//
// AWS Service Functions
//

import Amplify
import AWSCognitoAuthPlugin
import Foundation
import AWSAPIPlugin

//
// User Authentication Functions
//
func signIn(username: String, password: String) async {
    do {
        let signInResult = try await Amplify.Auth.signIn(
            username: username,
            password: password
            )
        if signInResult.isSignedIn {
            print("Sign in succeeded")
        }
    } catch let error as AuthError {
        print("Sign in failed \(error)")
    } catch {
        print("Unexpected error: \(error)")
    }
}
func signUp(username: String, password: String, email: String) async {
    let userAttributes = [AuthUserAttribute(.email, value: email)]
    let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
    do {
        let signUpResult = try await Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        )
        if case let .confirmUser(deliveryDetails, _, userId) = signUpResult.nextStep {
            print("Delivery details \(String(describing: deliveryDetails)) for userId: \(String(describing: userId))")
        } else {
            print("SignUp Complete")
        }
    } catch let error as AuthError {
        print("An error occurred while registering a user \(error)")
    } catch {
        print("Unexpected error: \(error)")
    }
}
func confirmSignUp(for username: String, with confirmationCode: String) async {
    do {
        let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: confirmationCode
        )
        print("Confirm sign up result completed: \(confirmSignUpResult.isSignUpComplete)")
    } catch let error as AuthError {
        print("An error occurred while confirming sign up \(error)")
    } catch {
        print("Unexpected error: \(error)")
    }
}
func signOut() async {
    let result = await Amplify.Auth.signOut()
    guard let signOutResult = result as? AWSCognitoSignOutResult
    else {
        print("Signout failed")
        return
    }

    print("Local signout successful: \(signOutResult.signedOutLocally)")
    switch signOutResult {
    case .complete:
        print("SignOut completed")
    case .failed(let error):
        print("SignOut failed with \(error)")
    case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
        print(
            """
            SignOut is partial.
            RevokeTokenError: \(String(describing: revokeTokenError))
            GlobalSignOutError: \(String(describing: globalSignOutError))
            HostedUIError: \(String(describing: hostedUIError))
            """
        )
    }
}

//
// Image Processing Functions
//
func processPhoto() async {
 
    do {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(image, forKey: "photo")
        let jsonData: NSData

        jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")

        let request = RESTRequest(path: "/selfcheck/processphoto", body: jsonString.data(using: .utf8))
        let data = try await Amplify.API.post(request: request)
        let str = String(decoding: data, as: UTF8.self)
        print("Success: \(str)")
    } catch let error as APIError {
        print("Error: \(error)")
    } catch {
        print("Unexpected error: \(error)")
    }
}

struct Photo: Codable {
    var photo: String
}

