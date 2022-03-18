#!/usr/bin/env swift

import Darwin
import AVFoundation

let deviceId = getDefaultDeviceId()
let name = String(getDeviceName(deviceId: deviceId))

let isHeadphones = name.contains("AirPods") || name.contains("Crossfade")
let isMuted = getDeviceVolume(deviceId: deviceId) == 0.0

if isHeadphones && isMuted {
    print("ﳌ")
} else if isHeadphones {
    print("")
} else if isMuted {
    print("ﱝ")
} else {
    print("")
}

func getDefaultDeviceId() -> AudioDeviceID {
    var deviceId = kAudioObjectUnknown
    var deviceSize = UInt32(MemoryLayout.size(ofValue: deviceId))
    var address = AudioObjectPropertyAddress(mSelector: kAudioHardwarePropertyDefaultOutputDevice,
                                             mScope: kAudioObjectPropertyScopeGlobal,
                                             mElement: kAudioObjectPropertyElementMain)

    let err = AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject),
                                         &address, 0, nil, &deviceSize, &deviceId)
    guard err == noErr else {
        print("#[fg=red]ﱝ")
        exit(1)
    }

    return deviceId
}

func getDeviceName(deviceId: AudioDeviceID) -> CFString {
    var deviceSize = UInt32(MemoryLayout.size(ofValue: deviceId))
    var address = AudioObjectPropertyAddress(mSelector: kAudioDevicePropertyDeviceNameCFString,
                                             mScope: kAudioObjectPropertyScopeGlobal,
                                             mElement: kAudioObjectPropertyElementMain)

    var deviceName = "" as CFString
    deviceSize = UInt32(MemoryLayout.size(ofValue: deviceName))
    guard AudioObjectGetPropertyData(deviceId, &address, 0, nil, &deviceSize, &deviceName) == noErr else {
        print("#[fg=red]ﱝ")
        exit(1)
    }

    return deviceName
}

enum Errors: Error {
    case badChannel
    case operationError(status: OSStatus)
}

func getDeviceVolumeForChannel(deviceId: AudioDeviceID, channel: AudioObjectPropertyElement) throws -> Float {
    var address = AudioObjectPropertyAddress(mSelector: kAudioDevicePropertyVolumeScalar,
                                             mScope: kAudioDevicePropertyScopeOutput,
                                             mElement: channel)

    var level = Float32(-1)
    var propertySize = UInt32(MemoryLayout<Float32>.size)

    let err = AudioObjectGetPropertyData(deviceId, &address, 0, nil,
                                         &propertySize, &level)
    guard err == noErr else {
        if err == 2003332927 {
            throw Errors.badChannel
        } else {
            throw Errors.operationError(status: err)
        }
    }

    return level
}

func getDeviceVolume(deviceId: AudioDeviceID) -> Float {
    // Idk why this is required, kAudioDevicePropertyPreferredChannelsForStereo isn't useful
    do {
        return try getDeviceVolumeForChannel(deviceId: deviceId, channel: 0)
    } catch (Errors.badChannel) {
        do {
            return try getDeviceVolumeForChannel(deviceId: deviceId, channel: 1)
        } catch {
            print("#[fg=red]ﱝ")
            return -1.0
        }
    } catch {
        print("#[fg=red]ﱝ")
        return -1.0
    }
}
