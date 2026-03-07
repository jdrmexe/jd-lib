# FiveM Notification Library

Welcome to the FiveM Notification Library! This library is designed to provide a seamless and efficient way to display notifications within your FiveM server applications. 

## Features
- **Custom Notifications**: Easily create unique notifications tailored to your server's theme.
- **Multiple Notification Types**: Support for success, error, info, and warning notifications.
- **Configurable Duration**: Set how long each notification remains visible to the user.
- **User-friendly API**: Create notifications with a simple and intuitive API.
- **Responsive Design**: Adapts to various screen sizes without compromising quality.
- **Localization Support**: Easily translate notifications to different languages for international servers.

## Installation
To get started with the FiveM Notification Library, simply include it in your resource manifest:

```lua
fx_version 'cerulean'
game 'gta5'

client_scripts {
    'notification.lua', -- Path to your main notification script
}
```

## Usage
Creating a notification is as simple as:

```lua
TriggerEvent('notification:show', 'Your message here', 'success');
```

## Contributing
We welcome contributions to improve the FiveM Notification Library! Please fork the repository and submit a pull request for any changes.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.