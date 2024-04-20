# SCNUpdate

ScribbleLabApp's updating service

## Overview

SCNUpdate is a service designed for handling updates from GitHub releases. It provides functionalities for fetching the latest releases from a GitHub repository, downloading release assets, and performing necessary actions for updating the application. This service is specifically designed for macOS applications.

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

### SCNGitHubError

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

### Generic Errors

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
