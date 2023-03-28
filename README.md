# Recursive hashing benchmarks for ZK

## Goal

Create rough benchmarks for Nova vs Circom / Halo2 for recursive hashing.

Inspired by https://github.com/celer-network/zk-benchmark but doing hashing
recursively to take advantage of things like Nova+IVC.

That is, computations of the form $h(h(h(h(h(x)))))$, or similar.

Assuming useful, upstream to zk-benchmark and/or https://www.zk-bench.org/

## Details

Can also generalize to Merkle Tree.

Initially SHA256, but later on Keccak256.

NOTE: Different curves

### Parameters

- (`n` preimage) - ignoring for now
- `k` steps
- `t` paralleization/threads (or similar)

### Targets

- Nova
- Circom
- Halo2?

## How to run

- Make sure update submodules first: `git submodule update --init --recursive`
- You also need Circom setup with pasta curves, see https://github.com/nalinbhardwaj/Nova-Scotia#how

For Circom benchmarks:

`./circom/compile.sh`

For Nova:

```
(cd nova/examples/sha256/circom && npm install)
./nova/examples/sha256/circom/compile.sh
(cd nova && cargo run --examples sha256_wasm --release)
```

## Initial results

# Initial benchmarking

## Hardware

Run on Macbook Pro M1 Max (2021), 64GB memory

## Circom (proving)

### n=1

- 29636 non-linear constraints
- mem 694691.200000
- time 0.953000
- cpu 378.800000

### n=10

- non-linear constraints: 296360
- mem 148928.000000
- time 0.282000
- cpu 232.300000

### n=100

- Compiling starts to take a long time, circuits getting too big for reasonably ptau file
- Increases linearly, e.g. need ptau23 (2**23=~8m) vs ~6m (3m\*2)
- non-linear constraints: 2963600
- mem 22014856.000000
- time 62.510000
- cpu 491.000000

## Nova

Number of constraints per step (primary circuit): 44176
Number of constraints per step (secondary circuit): 10347

(Same for all)

### n=1

RecursiveSNARK creation took 195.841458ms
CompressedSNARK::prove: true, took 3.099014917s

### n=10

Number of constraints per step (primary circuit): 44176
Number of constraints per step (secondary circuit): 10347

RecursiveSNARK creation took 2.428390917s
CompressedSNARK::prove: true, took 2.916614208s

### n=100

RecursiveSNARK creation took 24.352297666s
CompressedSNARK::prove: true, took 2.984685667s

### n=1000

RecursiveSNARK creation took 239.474452666s
CompressedSNARK::prove: true, took 17.342738166s

segfault with wasm => run C++ prover prover (doesn't work on M1) or wee_alloc allocator (intermittent problems but seems to work)