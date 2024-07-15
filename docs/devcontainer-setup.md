# Getting Started with DevContainers

The setup process involves installing the right tools and extensions, along with configuring the environment.

## Prerequisites

- **VSCode** -> You'll need [Visual Studio Code](https://code.visualstudio.com/Download)...
- **Docker** -> Make sure [Docker is installed](docker-setup) and running on your system.

### Setup

#### Install Extentions

1. Open Visual Studio Code.
1. Go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window or by pressing `Ctrl+Shift+X`.
1. Search for and install ->
   1. **Remote Development** extension pack by [Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).
   1. **Docker** by [Microsoft](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

---

#### Example

1. Open your project folder in Visual Studio Code.
2. Create a folder named `.devcontainer` at the root of your project.
3. Inside the `.devcontainer` folder, create a `devcontainer.json` file with the following content:

[Python DevContainer](https://raw.githubusercontent.com/DiagnosticsMonkey/DevContainer-Python/trunk/.devcontainer/devcontainer.json ':include :type=json')

4. Open the Command Palette (`Ctrl+Shift+P`) and select `Remote-Containers: Reopen in Container`. This will build the container and open your project inside the DevContainer.

---

## Summary

DevContainers provide a robust way to ensure a consistent development environment. By using a simple configuration file, you can define your entire development setup, including the base image, necessary extensions, and any post-creation commands.  
This helps to ensure that every developer on your project works in an identical environment, greatly reducing the chances of environment-related issues.

- **Configuration** -> The `devcontainer.json` file is the heart of DevContainers. It defines the image to use, extensions to install, settings to apply, and any commands to run after creating the container.
- **Extensions** -> DevContainers allow you to specify Visual Studio Code extensions that should be installed in the container, ensuring that every developer has the same tools available.
- **Docker Integration** -> DevContainers use Docker to create isolated development environments. This integration ensures that the development environment is consistent across different machines and setups.
