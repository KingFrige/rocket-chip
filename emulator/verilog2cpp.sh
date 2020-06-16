mkdir -p /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig

/home/korben/riscv/chipsalliance/rocket-chip/emulator/verilator/install/bin/verilator  \
  --cc  \
  --exe  \
  --top-module TestHarness  \
  +define+PRINTF_COND=$c("verbose","&&","done_reset")  \
  +define+RANDOMIZE_GARBAGE_ASSIGN   \
  +define+STOP_COND=$c("done_reset")  \
  --assert   \
  --output-split 20000  \
  --output-split-cfuncs 20000  \
  --threads 2 -Wno-UNOPTTHREADS  \
  -Wno-STMTDLY  \
  --x-assign unique  \
  -I/home/korben/riscv/chipsalliance/rocket-chip/src/main/resources/vsrc  \
  -O3 -CFLAGS -O1 -std=c++11  \
  -I/opt/riscv/toolchain/include  \
  -DVERILATOR  \
  -DTEST_HARNESS=VTestHarness  \
  -include /home/korben/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/verilator.h \
  -include /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.plusArgs  \
  --max-num-width 1048576  \
  -Mdir /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig  \
  -o /home/korben/riscv/chipsalliance/rocket-chip/emulator/emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig  \
  /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.v \
  /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.behav_srams.v \
  /home/korben/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/emulator.cc \
  /home/korben/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/SimDTM.cc \
  /home/korben/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/SimJTAG.cc \
  /home/korben/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/remote_bitbang.cc \
  -LDFLAGS \
  -L/opt/riscv/toolchain/lib \
  -Wl,-rpath,/opt/riscv/toolchain/lib \
  -L/home/korben/riscv/chipsalliance/rocket-chip/emulator \
  -lfesvr \
  -lpthread \
  -CFLAGS \
  -I/home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src \
  -include \
  /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig/VTestHarness.h \

make VM_PARALLEL_BUILDS=1 -C /home/korben/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig -f VTestHarness.mk
