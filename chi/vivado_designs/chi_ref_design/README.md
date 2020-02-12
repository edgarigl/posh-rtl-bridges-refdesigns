# CHI Reference Design

This design is using CHI HN-F & RN-F Bridge in back to back mode.

Following are the requirements to rebuild and run the design
  - Xilinx Vivado 2018.3 ( To Rebuild & Program Bitfiles )
  - x86 Host
  - Alveo-u250

To check Vivado version do,

```sh
vivado -version
```
You should see something like this,

```sh
Vivado v2018.3 (64-bit)
```

## How to build ?
```sh
$ cd ./chi
$ make
```
After Synthesis, Placement and Routing is completed, You should expect bitfile after around 2 hours under following folder
```sh
$ ./chi/vivado_designs/chi_ref_design/runs_build/u250_ep_posh_chi/u250_ep_posh_chi.runs/impl_1/u250_ep_posh_chi_wrapper.bit
```

## How to test ?

> NOTE: Make sure in /boot/grub/grub.cfg iommun is on. i.e "intel_iommu=on"

1. Program the bitfile on Alveo-u250 board using JTAG
2. After Programming is done, reboot the x86 Board ( Soft Reboot )
> NOTE: Make sure U250 is running on Seperate Power supply, else with x86 reboot, bitfile will be erased.
3. After Reboot, do
```sh
$ lspci | grep Xilinx
```
You should expect something like this
```sh
$ 65:00.0 FLASH memory: Xilinx Corporation Device 903F
```
Here, "65:00.0" is BDF and "903F" is Device ID for Xilinx End Point.
> NOTE : BDF Can change from setup to setup, so in following instructions please replace with your BDF

4. Go into Super User mode & Execute below commands,
```sh
$ modprobe vfio-pci
$ echo 0000:65:00.0 > /sys/bus/pci/devices/0000\:65\:00.0/driver/unbind #Ignore if error for the first time run.
$ echo 10ee 903f > /sys/bus/pci/drivers/vfio-pci/new_id
```
