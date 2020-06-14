### build
#### compile firrtl
```
make -C /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl SBT="java -Xmx2G -Xss8M -XX:MaxPermSize=256M -jar /mnt/Other/riscv/chipsalliance/rocket-chip/sbt-launch.jar" root_dir=/mnt/Other/riscv/chipsalliance/rocket-chip/firrtl build-scala
```

#### firrtl Test / assembly
```
cd /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl && java -Xmx2G -Xss8M -XX:MaxPermSize=256M -jar /mnt/Other/riscv/chipsalliance/rocket-chip/sbt-launch.jar "Test / assembly"

touch /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar  # update time

mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/lib
cp -p /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar /mnt/Other/riscv/chipsalliance/rocket-chip/lib

mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/test_lib
cp -p /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar /mnt/Other/riscv/chipsalliance/rocket-chip/test_lib
cp -p /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl-test.jar /mnt/Other/riscv/chipsalliance/rocket-chip/test_lib

mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/lib
cp -p /mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar /mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/lib
```

#### gen rocketchip fir
```
mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/
cd /mnt/Other/riscv/chipsalliance/rocket-chip && java -Xmx2G -Xss8M -XX:MaxPermSize=256M -jar /mnt/Other/riscv/chipsalliance/rocket-chip/sbt-launch.jar "runMain freechips.rocketchip.system.Generator -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src -T freechips.rocketchip.system.TestHarness -C freechips.rocketchip.system.DefaultConfig "

```

##### use sbt gen other module
```
> cd <rocket-chip>
> sbt
> runMain freechips.rocketchip.system.Generator --help

> show discoveredMainClasses

> runMain freechips.rocketchip.system.Generator -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src -T freechips.rocketchip.system.TestHarness -C freechips.rocketchip.system.DefaultConfig

> runMain freechips.rocketchip.unittest.Generator -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src -T freechips.rocketchip.unittest.TestHarness -C freechips.rocketchip.unittest.AMBAUnitTestConfig

> runMain freechips.rocketchip.groundtest.Generator -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src -T freechips.rocketchip.groundtest.TestHarness -C freechips.rocketchip.groundtest.TraceGenBufferlessConfig
```

#### gen rocketchip verilog
```
mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/
java -Xmx2G -Xss8M -XX:MaxPermSize=256M -cp "/mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar":"/mnt/Other/riscv/chipsalliance/rocket-chip/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/core/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/macros/target/scala-2.12/classes" firrtl.Driver -i /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.fir \
    -o /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.v \
    -X verilog \
    --infer-rw TestHarness \
    --repl-seq-mem -c:TestHarness:-o:/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.conf \
    -faf /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.anno.json \
    -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig/ \
    -fct firrtl.passes.InlineInstances, \
     \


mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src/
java -Xmx2G -Xss8M -XX:MaxPermSize=256M -cp "/mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar":"/mnt/Other/riscv/chipsalliance/rocket-chip/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/core/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/macros/target/scala-2.12/classes" firrtl.Driver -i /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src/freechips.rocketchip.unittest.AMBAUnitTestConfig.fir \
    -o /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src/freechips.rocketchip.unittest.AMBAUnitTestConfig.v \
    -X verilog \
    --infer-rw TestHarness \
    --repl-seq-mem -c:TestHarness:-o:/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src/freechips.rocketchip.unittest.AMBAUnitTestConfig.conf \
    -faf /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src/freechips.rocketchip.unittest.AMBAUnitTestConfig.anno.json \
    -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/unittest-generated-src/freechips.rocketchip.unittest.AMBAUnitTestConfig/ \
    -fct firrtl.passes.InlineInstances, \
     \


mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src/
java -Xmx2G -Xss8M -XX:MaxPermSize=256M -cp "/mnt/Other/riscv/chipsalliance/rocket-chip/firrtl/utils/bin/firrtl.jar":"/mnt/Other/riscv/chipsalliance/rocket-chip/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/core/target/scala-2.12/classes:/mnt/Other/riscv/chipsalliance/rocket-chip/chisel3/macros/target/scala-2.12/classes" firrtl.Driver -i /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src/freechips.rocketchip.groundtest.TraceGenBufferlessConfig.fir \
    -o /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src/freechips.rocketchip.groundtest.TraceGenBufferlessConfig.v \
    -X verilog \
    --infer-rw TestHarness \
    --repl-seq-mem -c:TestHarness:-o:/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src/freechips.rocketchip.groundtest.TraceGenBufferlessConfig.conf \
    -faf /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src/freechips.rocketchip.groundtest.TraceGenBufferlessConfig.anno.json \
    -td /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/groundtest-generated-src/freechips.rocketchip.groundtest.TraceGenBufferlessConfig/ \
    -fct firrtl.passes.InlineInstances, \
     \
```

#### install verilator
```
mkdir -p verilator/
wget http://www.veripool.org/ftp/verilator-4.028.tgz -O verilator/verilator-4.028.tar.gz
rm -rf verilator/src/verilator-4.028/
mkdir -p verilator/src/verilator-4.028/
cat verilator/verilator-4.028.tar.gz | tar -xz --strip-components=1 -C verilator/src/verilator-4.028/
touch verilator/src/verilator-4.028/configure
mkdir -p verilator/src/verilator-4.028/
cd verilator/src/verilator-4.028/ && ./configure --prefix=/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/verilator/install

make -C verilator/src/verilator-4.028 verilator_bin

touch verilator/src/verilator-4.028/bin/verilator
make -C verilator/src/verilator-4.028 installbin installdata

touch /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/verilator/install/bin/verilator
```


#### gen vlsi mem
```
cd /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src && \
/mnt/Other/riscv/chipsalliance/rocket-chip/scripts/vlsi_mem_gen /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.conf > /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.behav_srams.v.tmp && \
mv -f /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.behav_srams.v.tmp /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.behav_srams.v
```

#### gen debug emulator
```
mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig
/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/verilator/install/bin/verilator --cc --exe --top-module TestHarness +define+PRINTF_COND=\$c\(\"verbose\",\"\&\&\"\,\"done_reset\"\) +define+RANDOMIZE_GARBAGE_ASSIGN +define+STOP_COND=\$c\(\"done_reset\"\) --assert --output-split 20000 --output-split-cfuncs 20000 --threads 2 -Wno-UNOPTTHREADS -Wno-STMTDLY --x-assign unique -I/mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/vsrc -O3 -CFLAGS "-O1 -std=c++11 -I/opt/riscv/toolchain/include -DVERILATOR -DTEST_HARNESS=VTestHarness -include /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/verilator.h -include /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.plusArgs" --max-num-width 1048576 -Mdir /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig \
-o /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.v /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.behav_srams.v  /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/emulator.cc /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/SimDTM.cc /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/SimJTAG.cc /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/remote_bitbang.cc -LDFLAGS " -L/opt/riscv/toolchain/lib -Wl,-rpath,/opt/riscv/toolchain/lib -L/mnt/Other/riscv/chipsalliance/rocket-chip/emulator -lfesvr -lpthread" \
-CFLAGS "-I/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src -include /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig/VTestHarness.h"

make VM_PARALLEL_BUILDS=1 -C /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig -f VTestHarness.mk
```

#### gen debug emulator
```
mkdir -p /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src-debug/freechips.rocketchip.system.DefaultConfig
/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/verilator/install/bin/verilator --cc --exe --top-module TestHarness +define+PRINTF_COND=\$c\(\"verbose\",\"\&\&\"\,\"done_reset\"\) +define+RANDOMIZE_GARBAGE_ASSIGN +define+STOP_COND=\$c\(\"done_reset\"\) --assert --output-split 20000 --output-split-cfuncs 20000 --threads 2 -Wno-UNOPTTHREADS -Wno-STMTDLY --x-assign unique -I/mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/vsrc -O3 -CFLAGS "-O1 -std=c++11 -I/opt/riscv/toolchain/include -DVERILATOR -DTEST_HARNESS=VTestHarness -include /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/verilator.h -include /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.plusArgs" --max-num-width 1048576 -Mdir /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src-debug/freechips.rocketchip.system.DefaultConfig  --trace \
-o /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/emulator-freechips.rocketchip.system-freechips.rocketchip.system.DefaultConfig-debug /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.v /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src/freechips.rocketchip.system.DefaultConfig.behav_srams.v  /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/emulator.cc /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/SimDTM.cc /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/SimJTAG.cc /mnt/Other/riscv/chipsalliance/rocket-chip/src/main/resources/csrc/remote_bitbang.cc -LDFLAGS " -L/opt/riscv/toolchain/lib -Wl,-rpath,/opt/riscv/toolchain/lib -L/mnt/Other/riscv/chipsalliance/rocket-chip/emulator -lfesvr -lpthread" \
-CFLAGS "-I/mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src-debug -include /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src-debug/freechips.rocketchip.system.DefaultConfig/VTestHarness.h"

make VM_PARALLEL_BUILDS=1 -C /mnt/Other/riscv/chipsalliance/rocket-chip/emulator/generated-src-debug/freechips.rocketchip.system.DefaultConfig -f VTestHarness.mk
```

