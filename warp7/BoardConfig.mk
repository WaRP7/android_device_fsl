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
	device/fsl/warp7/modules/startup_fw_update.img:root/lib/firmware/synaptics/startup_fw_update.img \
	device/fsl/warp7/fstab.freescale:root/fstab.freescale 

#$(info *****************************************************************************************)
#$(info "please make sure wifi driver: device/fsl/warp7/bluetooth/system/lib/modules/bcmdhd.ko" )
#$(info "match the kernel,it is copy from kernel_imx/drivers/net/wireless/bcmdhd/bcmdhd.ko ")
#$(info *****************************************************************************************)

# copy bt/wifi firmware
PRODUCT_COPY_FILES +=	\
	device/fsl/warp7/bluetooth/system/etc/firmware/bcm/bcmdhd.1DX.OOB.cal:system/etc/firmware/bcm/bcmdhd.1DX.OOB.cal \
	device/fsl/warp7/bluetooth/system/etc/firmware/bcm/fw_bcmdhd_mfgtest.bin:system/etc/firmware/bcm/fw_bcmdhd_mfgtest.bin \
	device/fsl/warp7/bluetooth/system/etc/firmware/bcm/bcmdhd.1DX.SDIO.cal:system/etc/firmware/bcm/bcmdhd.1DX.SDIO.cal \
	device/fsl/warp7/bluetooth/system/etc/firmware/bcm/BCM43430A1.1DX.hcd:system/etc/firmware/bcm/BCM43430A1.1DX.hcd \
	device/fsl/warp7/bluetooth/system/etc/bluetooth/bt_stack.conf:system/etc/bluetooth/bt_stack.conf \
	device/fsl/warp7/bluetooth/system/etc/bluetooth/ble_stack.conf:system/etc/bluetooth/ble_stack.conf \
	device/fsl/warp7/modules/bcmdhd.ko:system/lib/modules/bcmdhd.ko \
	device/fsl/warp7/modules/mx6s_capture.ko:system/lib/modules/mx6s_capture.ko \
	device/fsl/warp7/modules/mxc_mipi_csi.ko:system/lib/modules/mxc_mipi_csi.ko \
	device/fsl/warp7/modules/ov5640_camera_mipi.ko:system/lib/modules/ov5640_camera_mipi.ko \
	
TARGET_BOOTLOADER_BOARD_NAME := WARP7
PRODUCT_MODEL := WARP7

TARGET_RELEASETOOLS_EXTENSIONS := device/fsl/imx7
TARGET_NO_KERNEL := true

# WLAN
# UNITE is a virtual device support both atheros and realtek wifi(ar6103 and rtl8723as)
BOARD_WLAN_DEVICE            := UNITE
WPA_SUPPLICANT_VERSION       := VER_0_8_UNITE
BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB_QCOM              := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_QCOM       := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_PRIVATE_LIB_RTL               := lib_driver_cmd_rtl
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RTL        := lib_driver_cmd_rtl
BOARD_HOSTAPD_PRIVATE_LIB_BCM               := lib_driver_cmd_bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_BCM        := lib_driver_cmd_bcmdhd

WIFI_DRIVER_FW_PATH_STA 	:= "/system/etc/firmware/bcm/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P 	:= "/system/etc/firmware/bcm/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP  	:= "/system/etc/firmware/bcm/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_PARAM 	:= "/sys/module/bcmdhd/parameters/firmware_path"

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
