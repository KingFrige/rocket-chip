### gen run log
```
make output/rv64ui-v-addw.run

> mkdir -p ./output
> ln -fs /opt/riscv/toolchain/riscv64-unknown-elf/share/riscv-tests/isa/rv64ui-v-addw output/rv64ui-v-addw
> ./emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig +max-cycles=100000000 output/rv64ui-v-addw 2> /dev/null 2> output/rv64ui-v-addw.run && [ $PIPESTATUS -eq 0 ]

```
### gen out log
```
make output/rv64ui-v-addw.out

> ./emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig +max-cycles=100000000 +verbose output/rv64ui-v-addw 3>&1 1>&2 2>&3 | /opt/riscv/toolchain/bin/spike-dasm  > output/rv64ui-v-addw.out && [ $PIPESTATUS -eq 0 ]
```

### gen vcd wave file
```
make output/rv64ui-v-addw.vcd

> ./emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig-debug +max-cycles=100000000 +verbose -voutput/rv64ui-v-addw.vcd output/rv64ui-v-addw 3>&1 1>&2 2>&3 | /opt/riscv/toolchain/bin/spike-dasm  > output/rv64ui-v-addw.out && [ $PIPESTATUS -eq 0 ]
```

### gen fst wave file
```
make output/rv64ui-v-addw.fst   # gtkwave wave file

> rm -rf output/rv64ui-v-addw.fst.vcd && mkfifo output/rv64ui-v-addw.fst.vcd
> vcd2fst -Z output/rv64ui-v-addw.fst.vcd output/rv64ui-v-addw.fst &
> ./emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig-debug +max-cycles=100000000 +verbose -voutput/rv64ui-v-addw.fst.vcd output/rv64ui-v-addw 3>&1 1>&2 2>&3 | /opt/riscv/toolchain/bin/spike-dasm  > output/rv64ui-v-addw.out && [ $PIPESTATUS -eq 0 ]
```

### gen vpd wave file, use vcs
```
make output/rv64ui-v-addw.vpd   # dve wave file
```


./emulator-freechips.rocketchip.system-DefaultConfig output/rv64ui-v-addw

./emulator-freechips.rocketchip.system-DefaultConfigRBB +jtag_rbb_enable=1 --rbb-port=9823 helloworld

$RISCV/bin/openocd -f ./cemulator.cfg

riscv64-unknown-elf-gdb helloworld
