# PCIe-EP Design 

This design is using PCIE-EP Bridge to test with AXI CDMA & BRAM IPs

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
$ cd ./pcie
$ make pcie_ep
```
After Synthesis, Placement and Routing is completed, You should expect bitfile after around 2 hours under following folder
```sh
$ vivado_designs/pcie_ep/runs/u250_pcie_ep/u250_pcie_ep.runs/impl_1/u250_pcie_ep_wrapper.bit
```

