# SCNUpdate (macOS)

ScribbleLabApp's updating service

@Metadata {
    @SupportedLanguage(swift) 
    @SupportedLanguage(objc)
    @Available(macOS, introduced: "14.0")
    @Available(MacCatalyst, introduced: "17.0")
    @PageColor(yellow)
}

## Overview

SCNUpdate is a service designed for **handling updates** from GitHub releases. It provides functionalities for **fetching the latest releases** from a GitHub repository, **downloading release assets**, and **performing necessary actions** for updating the application. This service is specifically designed for macOS applications.

![An illustartion referring to the Updating logic](updateHandlers)

Every time you launch ScribbleLab, the **`checkForUpdate(channel:)`** function is called. This function **sends a request** to ScribbleCoreServices, which in turn **sends an API request** to the **GitHub REST API**. The API at `api.github.com` responds by providing the **releases for the subscribed channel**, and **returns data** that will be **used in ScribbleLab** to download the necessary assets.

![An illustartion referring to the channel logic](update_channels)

The `checkForUpdate(channel:)` function includes a `channel` parameter that can take two values: **„stable“** and **„pre-release“**. If a user has subscribed to the **„stable“ channel**, they will receive **stable releases** of ScribbleLab. On the other hand, if they have subscribed to the **„pre-release“ channel**, they will receive **alpha and beta versions** of the app.

![An illustartion referring to the channel logic with api request for the coresponding channel](channel_api)

**ScribbleCoreServices** has **subscribed to a channel** to receive the **latest release data** from the **GitHubREST API**. Whenever **a new release is published**, the **GitHub REST API retrieves the corresponding information** and **sends it to ScribbleCoreServices**.

![An illustartion referring to the returned types from api](response_api_updater)

The **data** that has been obtained **includes the `tagName`**, **information of the latest release** from the **subscribed channel**, along with the **`Asset` details** such as **Name and AssetURL**, and **whether it is a prerelease** or not. Once this information is available, **ScribbleLabCoreServices will compare the tagName against the `CFBundleShortVersionString`**. If the **tagName is greater than `CFBundleShortVersionString`**, then **`self.isUpdateAvailable` will be set to `true`**, and an update request will be prompted.

### Error codes

##### SCNUpdateError

- `invalidDMGFile`: -3
  - Indicates that the DMG file is invalid.

- `mountingFailed`: -2
  - Indicates that mounting the DMG file failed.

- `noMountedVolume`: -2
  - Indicates that no mounted volume was found.

- `applicationInstallationFailed`: -6
  - Indicates that application installation failed.

- `applicationRemovalFailed`: -4
  - Indicates that application removal failed.

- `applicationMoveFailed`: -5
  - Indicates that moving the application failed.

##### SCNGitHubError

- `networkError`: -100
  - Indicates a network error occurred.

- `parsingError`: -102
  - Indicates an error occurred while parsing data.

- `noReleasesFound`: -404
  - Indicates that no releases were found.

- `userNotEligible`: -403
  - Indicates that the user is not eligible for the operation.

- `apiError`: Varies
  - Indicates an error occurred in the API. The exact status code is provided in the `statusCode` parameter. Additional information is provided in the `message` parameter.

##### Generic Errors

- `-1`: Varies
  - Indicates a generic error occurred. The specific error message can vary based on the context.

- `-1000`: Varies
  - Indicates an error occurred due to an invalid URL.

- `-1001`: Varies
  - Indicates an error occurred due to an invalid response.

- `-1002`: Varies
  - Indicates an error occurred due to no data received.

## See Also

- <doc:SCNUpdate>
