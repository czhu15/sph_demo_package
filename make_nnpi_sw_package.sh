DIR=./_deploy/opt/intel_nnpi/

if [ "$1" == "debug" ]
then
        echo "Generating debug version..."
        MODE="debug"
else
        echo "Generating release version..."
        MODE="release"
fi

if [ -d "./_deploy" ]
then
        echo "Directory _deploy already exists. Removing..."
        rm -rf ./_deploy
fi

mkdir -p $DIR/artifacts
mkdir -p $DIR/bin
mkdir -p $DIR/etc
mkdir -p $DIR/etc/profile.d
mkdir -p $DIR/etc/udev/rules.d
mkdir -p $DIR/images
mkdir -p $DIR/lib
#mkdir -p $DIR/lib/firmware/intel/nnpi
mkdir -p $DIR/modules

# all config files
cp ./aipg_inference-platform_sw/src/host/apps/nnpi_ctl/nnpi_ctl.cfg $DIR/etc/
cp ./aipg_inference-platform_sw/src/host/apps/nnpi_trace/nnpi_trace.cfg $DIR/etc/
cp ./aipg_inference-platform_sw/scripts/nnpi.rules $DIR/etc/udev/rules.d/
cp ./aipg_inference-platform_sw/scripts/installation/nnpi.sh $DIR/etc/profile.d/

# SPH OS image. will get from artifactary directly.
#cp ./sph_os/intel/sph/OS_Image/disk.img $DIR/image

if [ "$MODE" == "release" ]
then
	# nnpi binary files
	cp ./aipg_inference-platform_sw/build/sph_ep/Release/host/bin/nnpi_* $DIR/bin
	cp ./aipg_inference-platform_sw/build/sph_ep/Release/host/bin/sph_* $DIR/bin
	cp ./aipg_inference-dl/build/bin/intel64/Release/gt_sample $DIR/bin

	# nnpi libary files
	cp ./aipg_inference-dl/build/bin/intel64/Release/lib/libnnpi_transformer.so $DIR/lib
	cp ./aipg_inference-inference_api/build_linux/sph_ep/Release/lib/libnnpi_inference.so $DIR/lib
	cp ./aipg_inference-platform_sw/build/sph_ep/Release/host/lib/libnnpiml.so $DIR/lib
	cp ./aipg_inference-platform_sw/build/sph_ep/Release/host/lib/libhwtrace.* $DIR/lib

	# nnpi kernel driver
	cp ./aipg_inference-platform_sw/build/sph_ep/Release/host/modules/sphdrv.ko $DIR/modules
else
	# nnpi binary files
	cp ./aipg_inference-platform_sw/build/sph_ep/Debug/host/bin/nnpi_* $DIR/bin
	cp ./aipg_inference-platform_sw/build/sph_ep/Debug/host/bin/sph_* $DIR/bin
	cp ./aipg_inference-dl/build/bin/intel64/Debug/gt_sample $DIR/bin

	# nnpi libary files
	cp ./aipg_inference-dl/build/bin/intel64/Debug/lib/libnnpi_transformer.so $DIR/lib
	cp ./aipg_inference-inference_api/build_linux/sph_ep/Debug/lib/libnnpi_inference.so $DIR/lib
	cp ./aipg_inference-platform_sw/build/sph_ep/Debug/host/lib/libnnpiml.so $DIR/lib
	cp ./aipg_inference-platform_sw/build/sph_ep/Debug/host/lib/libhwtrace.* $DIR/lib 

	# nnpi kernel driver
	cp ./aipg_inference-platform_sw/build/sph_ep/Debug/host/modules/sphdrv.ko $DIR/modules
fi

