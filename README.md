# Klarna In-App SDK - iOS Demo App
![Platforms](https://img.shields.io/badge/platform-ios-lightgrey)
[![GitHub](https://img.shields.io/github/license/klarna/klarna-mobile-sdk)](https://github.com/klarna/kp-ios-example-app/blob/master/LICENSE)

This is an example iOS app to demonstrate [Klarna In-App SDK](https://github.com/klarna/klarna-mobile-sdk) usage.

The Klarna In-App SDK allows merchants to integrate Klarna’s products into their apps natively. This means that you can add services like Klarna Payments to your app and let your customers pay with our payment methods.

**Are you looking for Klarna Checkout iOS Demo App?** Check out the [Klarna Checkout iOS Demo App](https://github.com/klarna/kco-ios-example-app) repo instead.

## What Does Klarna In-App SDK Offer?
Klarna In-App SDK offers two integration approaches: **Native integration** and **Hybrid integration**.

**Native integration** allows fully native apps to add views with Klarna content to their app. We currently support Klarna Payments, allowing you to add payment views to your checkout and authorizing a session to create an order natively.

**Hybrid integration** will enhance your customers' experience if your app renders in a web view that presents content from Klarna.

[Read More About the SDK](https://developers.klarna.com/documentation/in-app)

## Setup
* Clone this repo
* Run `pod install --repo-update`
* Open `FashionStore.xcworkspace`
* Enter your Merchant credentials & API details in `BackendOperations` file.
* Build and run the project.

### Native Integration
As previously mentioned, Klarna Payments supports native integration. The main idea behind Klarna Payments is to give merchants the ability to offer Klarna’s payment methods to customers. Because Klarna doesn’t own the entire checkout flow, a check must be performed before an order is created. Our goal with this integration is to offer you the same simple development experience as you have on the web. As such, integrating Klarna Payments consists of four steps:

1. Creating a session.
2. Rendering the payment view.
3. Authorizing the session.
4. Creating an order.

![](https://developers.klarna.com/static/in-app/kp-diagram.png)

### Screenshots

<img src="Screenshots/ScreenShot1.png" width="200"/> <img src="Screenshots/ScreenShot2.png" width="200"/>  <img src="Screenshots/ScreenShot3.png" width="200"/>

## Requirements
* iOS 10 or later.

### Developer Documentation

* [Overview](https://developers.klarna.com/documentation/in-app/)
* [iOS](https://developers.klarna.com/documentation/in-app/ios/)
* [Android](https://developers.klarna.com/documentation/in-app/android/)

### API Documentation
*  [iOS](https://htmlpreview.github.io/?https://github.com/klarna/klarna-mobile-sdk/blob/master/docs/ios/index.html)
*  [Android](https://htmlpreview.github.io/?https://github.com/klarna/klarna-mobile-sdk/blob/master/docs/android/klarna-mobile-sdk/index.html)

## Support
If you are having any issues using the SDK in your project or if you think that something is wrong with the SDK itself, please create an issue on [Github](https://github.com/klarna/kp-ios-example-app/issues) or report a bug by following the guidelines in the next section. 

## Contributing
Thank you for reading this and taking the time to contribute to Klarna In-App SDK - iOS Demo App! Below is a set of guidelines to help you contribute whether you want to report a bug, come with suggestions or modify code.

### How can I contribute?
#### Reporting Bugs
This section will guide you through submitting a bug report for Klarna In-App SDK - iOS Demo App.

Before submitting a bug report, please check that the issue hasn't been reported before. If you find a *Closed* issue that seems to describe an issue that is similar to what you want to report, open a new issue and link to the original issue in the new one. When you have checked that the issue hasn't been reported before, please **fill out [the required template](https://github.com/klarna/kp-ios-example-app/blob/master/.github/ISSUE_TEMPLATE/bug_report.md)** which will help us resolve the issue faster. 

##### Submitting a Bug Report
Submitted bugs are tracked as [GitHub issues](https://guides.github.com/features/issues/). To report a bug, create an issue and use [the template](https://github.com/klarna/kp-ios-example-app/blob/master/.github/ISSUE_TEMPLATE/bug_report.md) to provide information about the bug. Explain the problem thoroughly and include any additional information that you think might help the maintainers reproduce the issue. When creating the GitHub issue, please make sure that you:

* **Use a clear and descriptive title** for the issue.
* **Describe the exact steps which reproduce the problem** with as many details as possible. It's generally better to provide too much than too little information.
* **Describe the behavior you observed after following the steps** and explain precisely what the problem is with that behavior.
* **Explain which behavior you expected instead** and why.
* **Provide screenshots and/or screen recordings** that might help explain the issue you are facing. To screen record on iOS, follow the steps described [here](https://support.apple.com/en-us/HT207935).
* **Include relevant logs in the bug report** by putting it in a [code block](https://help.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github#multiple-lines), a [file attachment](https://help.github.com/en/github/managing-your-work-on-github/file-attachments-on-issues-and-pull-requests), or in a [gist](https://help.github.com/en/github/writing-on-github/creating-gists) and provide a link to that gist.
* **Tell how recently you started having the issue.** When was the first time you experienced the issue and was it after updating the SDK version? Or has it always been a problem?
* If the problem started happening recently, **can you reproduce it in an older version of the SDK?** What's the most recent version in which the problem doesn't happen?
* **Can you reliably reproduce the issue?** If not, explain how often it occurs and under what conditions it usually happens. For example, in what environment you are running.

Include details about the device/emulator/simulator you are experiencing the issue on:

* **Which version of the SDK are you using?**
* **Which OS is this a problem in, iOS, Android, or both?** What version(s)? Also, add the appropriate label to the issue.
* **Did you experience the issue in simulator/emulator or on real device(s)?**

#### Contributing to Code
Before contributing, please read through the [Klarna In-App SDK documentation](https://developers.klarna.com/documentation/in-app/).

##### Branching
Prefix the branch you are going to work on depending on what you are working on (bug fix or feature). Use the following prefixes when creating a new branch:

* **feature/** if the branch contains a new feature, for example: `feature/my-shiny-feature`.
* **bugfix/**  if the branch contains a bug fix, for example: `bugfix/my-bug-fix`.

##### Pull Requests
When creating a PR, please include as much information as possible about the type of enhancement, whether if it's a bugfix, new functionality, or any other change. There's [a template](https://github.com/klarna/kp-ios-example-app/blob/master/.github/ISSUE_TEMPLATE/pull-request.md) for you to fill out, which will make the review process for the maintainers faster. When creating a PR do it against the `master` branch. The PR should include:

* **A clear and descriptive title**.
* **Description of the issue** if you are fixing a bug together with a link to the relevant issue or **background for introducing a new feature**.

## License
Copyright 2018 Klarna Bank AB

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
