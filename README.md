# POSH RTL Bridges reference design
Reference designs for mixed accuracy co-simulation using AXI, ACE, CHI, CXS
and PCIe hardware bridges.

## Before building

Make sure you've checked out the libsystemctlm-soc submodule:

```
$ git submodule update --init libsystemctlm-soc
```

Make sure you have Vivado 2018.3 installed and set up.

## For building the AXI bitstream

```
$ cd ./axi
$ make design TARGET=axi_cdma_axi4_128
```

## For building the ACE bitstream

```
$ cd ./ace
$ make
```

## For building the CHI bitstream

```
$ cd ./chi
$ make
```

## For building the CXS bitstream

```
$ cd ./cxs
$ make

```

## For building the PCIe bitstream

```
$ cd ./pcie
$ make pcie_ep
```
