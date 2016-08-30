#
# Product-specific compile-time definitions.
#

include device/fsl/imx7/soc/imx7d.mk
include device/fsl/warp7/build_id.mk
include device/fsl/imx7/BoardConfigCommon.mk
-include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# sabresd_mx7d default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/fsl/imx7/imx7_target_fs.mk
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/fsl/warp7/fstab.freescale:root/fstab.freescale

TARGET_BOOTLOADER_BOARD_NAME := WARP7
PRODUCT_MODEL := WARP7

TARGET_RELEASETOOLS_EXTENSIONS := device/fsl/imx7
BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init androidboot.console=ttymxc0 consoleblank=0 androidboot.hardware=freescale 
TARGET_BOOTLOADER_CONFIG := imx7d:mx7dsabresdandroid_config
TARGET_BOARD_DTS_CONFIG := imx7d:imx7d-sdb.dtb

# Bluetooth
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/fsl/sabresd_7d/bluetooth

BOARD_SEPOLICY_DIRS := \
       device/fsl/imx7/sepolicy \
       device/fsl/sabresd_7d/sepolicy
BOARD_SEPOLICY_UNION := \
       domain.te \
       system_app.te \
       system_server.te \
       untrusted_app.te \
       sensors.te \
       init_shell.te \
       kernel.te \
       mediaserver.te \
       file_contexts \
       genfs_contexts \
       fs_use \
       rild.te \
       init.te \
       netd.te \
       bootanim.te \
       dnsmasq.te \
       recovery.te \
	   bluetooth.te \
       device.te
