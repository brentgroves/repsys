# Home

- Dell R410
  - node MicroK8s

  - GW/Firewall to Dell Precisions
    - Natter for Dell Precisions

- 3 Dell Precisions
  - Only accessible through Dell R410
  - 3 node MicroK8s

## KVM

- Optiplex 7040/moto: port 4
- Dell 7810/repsys13: port 3
- Dell T3610/repsys12: port 2
- Dell T3600/repsys11: share port 2
- Dell R440/k8sgw1: port 1

## Ligtel ONT

## Ligtel router

- 192.168.1.1

## Trendnet

- ligtel router: port 1
- Optiplex 7040: port 3

## Dell R440 (Gateway/Firewall)

- k8sgw1
- eno1 (top port):
  - to Trendnet switch
  - 192.168.1.65
- eno2 (bottom port):
  - 192.168.2.1
  - to Dell 3548 switch

## Dell 3548 switch

- Dell 7810: port 1
- Dell T3610: port 3
- Dell T3600: port 5
- Dell R440: port 7

## Optiplex 7040

- moto
- eno1
  - 192.168.1.60
  - to Trendnet: port 3

## Dell 7810

- repsys11
- eno1
  - 192.168.2.81
  - to Dell 3548: port 1

## Dell T3610

- repsys12
- eno1
  - 192.168.2.82
  - to Dell 3548: port 3

## Dell T3600

- repsys13
- eno1
  - 192.168.2.83
  - to Dell 3548: port 5
