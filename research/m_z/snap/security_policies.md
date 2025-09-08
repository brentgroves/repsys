# **[Information security](https://snapcraft.io/docs/security-policies)**

## How to establish strict confinement

Without **[custom flags at installation](https://snapcraft.io/docs/install-modes)**, or subsequent **[interface connections](https://snapcraft.io/docs/interface-management)**, snaps remain confined to a restrictive security sandbox, preventing access to system resources outside the snap.

Snap developers need to be aware which system resources their applications depend on from within the snap.

Security policies and store policies work together to allow developers to quickly confine and update their applications to provide safety to end users. This document provides an overview of core mechanisms that underpins the secure snap sandbox as well as information on how to configure and work with the security policies for snaps you publish.

For more general details on what confinement entails, see **[Snap confinement](https://snapcraft.io/docs/snap-confinement)**, and see below for implementation details.

## Security overview

Application developers should not need to know about, or understand, the low-level implementation details of how a security policy is enforced.

Each command declared with the apps **[snap metadata](https://snapcraft.io/docs/the-snap-format#heading--snapyaml)** is tracked by the system assigning a security label to the command.
