# PulseCore — Medical Device Monitoring Simulator

A desktop medical monitoring simulator developed with **C++20, Qt 6, and Qt Quick/QML**.

PulseCore is an educational software engineering project designed to demonstrate modern C++ development, desktop GUI engineering, real-time data visualization, and integration between C++ and QML.

> **SIMULATION ONLY — NOT FOR CLINICAL USE**

## Project Status

**Current phase:** Initial project setup.

The project is being developed incrementally, with each functional block implemented, compiled, and validated before moving to the next.

## Technology Stack

- C++20
- Qt 6.12
- Qt Quick / QML
- Qt Creator
- CMake
- MinGW-w64
- Ninja
- Qt Test (planned)

## Planned Features

- Synthetic vital signs monitoring
- Heart rate (HR)
- Oxygen saturation (SpO₂)
- Respiratory rate (RESP)
- Temperature (TEMP)
- Animated synthetic ECG waveform
- Normal, Warning, and Critical scenarios
- Start, Pause, and Reset controls
- Simulated alarms
- Sensor disconnection simulation

## Architecture

PulseCore follows a lightweight architecture:

- **C++20:** Simulation engine, application logic, and state management.
- **QML:** User interface, visual components, and animations.
- **JavaScript:** Lightweight UI interactions and expressions.

The initial project structure is intentionally simple. Classes will be designed with clear responsibilities and small, reusable methods.

## Development Environment

- Windows 10/11 x64
- Qt Creator
- Qt 6.12 MinGW 64-bit Kit
- CMake and Ninja
- C++20-compatible compiler

## Build and Run

1. Open Qt Creator.
2. Select **File → Open File or Project**.
3. Open `CMakeLists.txt`.
4. Select the **Desktop Qt 6.12.0 MinGW 64-bit** kit.
5. Configure the project.
6. Build using `Ctrl+B`.
7. Run using `Ctrl+R`.

Build and execution verification will be recorded as development progresses.

## Development Roadmap

- [ ] Validate the development environment and initial application
- [ ] Build the main monitoring interface
- [ ] Implement the C++ simulation engine
- [ ] Integrate C++ and QML
- [ ] Implement synthetic ECG visualization
- [ ] Implement monitoring scenarios and alarms
- [ ] Add automated tests
- [ ] Prepare the Windows demonstration release

## Disclaimer

PulseCore is an educational and portfolio project.

It does not connect to medical equipment, process real patient data, provide diagnoses, or support clinical decisions.

**SIMULATION ONLY — NOT FOR CLINICAL USE**

## License

License to be determined before public distribution.

## Author

Alexander Alves

C++ Developer | QT | QML | Java | Javascript | QA Automation Engineer 
