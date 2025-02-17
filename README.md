# OCR Empire Watch Face

A clean and informative watch face for Garmin devices that displays essential information with a modern design.

## Features

- **Time Display**: Large, easy-to-read digital time display
- **Activity Metrics**:
  - 🔥 Calories burned
  - 👣 Step count with thousands separator
  - ♥ Current heart rate
  - 🔋 Battery level percentage
- **Date Display**: Shows day of week and date (e.g., "SUN 17")

## Supported Devices

supports:
all garmin wathces, tested on 
- Garmin Fenix 6

## Installation

1. Download the latest `.prg` file from the releases section
2. Connect your Garmin device to your computer
3. Copy the `.prg` file to the `/GARMIN/APPS` directory on your device
4. Disconnect your device and the watch face will be installed automatically

## Development

### Prerequisites

- Connect IQ SDK 3.0.0 or higher
- A valid Garmin developer key

### Building from Source

1. Clone this repository:
```bash
git clone [repository-url]
```

2. Open the project in Visual Studio Code with the Garmin Connect IQ extension

3. Build the project:
```bash
monkeyc -o bin/ocrEmpireWatchFace.prg -f monkey.jungle -d fenix6 -y [path-to-developer-key]
```

## Customization

The watch face uses emojis for icons to maintain a clean and modern look:
- 🔥 for calories
- 👣 for steps
- ♥ for heart rate
- 🔋 for battery level

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Thanks to the Garmin Connect IQ community for their support and documentation
- Special thanks to all contributors who have helped improve this watch face

## Support

If you encounter any issues or have suggestions for improvements, please open an issue on the GitHub repository.
