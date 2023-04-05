cd examples/many_hashes/circom
# ghead on OSX, head on Linux
ghead -n -1 many_hashes.circom > many_hashes.circom
echo "component main { public [step_in] } = Main($1);" >> many_hashes.circom

circom many_hashes_benchmark.circom --r1cs --wasm --sym --c --prime vesta
# Linux
#cd many_hashes_cpp && make
#cd many_hashes_js && node generate_witness.js many_hashes.wasm
# ../input_32_first_step2.json output.wtns
