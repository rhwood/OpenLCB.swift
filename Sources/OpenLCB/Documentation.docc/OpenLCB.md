# ``OpenLCB``

OpenLCB is a Swift library for controlling model railroads using the NMRA LCC / OpenLCB protocol.

## Overview

A [Swift](https://swift.org) implementation of the [OpenLCB](https://openlcb.org) protocol.

## Design

This library has the following design criteria:

- Compiles on macOS and Linux (this may expend to Windows and other Apple product platforms)
- Supports the following transports
    - TCP
    - CAN (includes an abstraction layer for CAN connections, but makes no assumptions about the CAN bus is connected to
          the computer this library is used on)
- Includes no UI code as UI code is highly platform specific
- Fully testable (any code that can't be reliably tested needs to be in a separate library that depends on this library)

@Comment {
## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
}
