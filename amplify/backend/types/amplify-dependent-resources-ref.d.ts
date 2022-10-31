export type AmplifyDependentResourcesAttributes = {
    "auth": {
        "selfcheck": {
            "IdentityPoolId": "string",
            "IdentityPoolName": "string",
            "UserPoolId": "string",
            "UserPoolArn": "string",
            "UserPoolName": "string",
            "AppClientIDWeb": "string",
            "AppClientID": "string"
        }
    },
    "function": {
        "processPhoto": {
            "Name": "string",
            "Arn": "string",
            "Region": "string",
            "LambdaExecutionRole": "string"
        }
    },
    "api": {
        "selfcheck": {
            "RootUrl": "string",
            "ApiName": "string",
            "ApiId": "string"
        }
    }
}