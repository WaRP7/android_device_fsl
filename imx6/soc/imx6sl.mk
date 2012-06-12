#
# SoC-specific compile-time definitions.
#

BOARD_SOC_TYPE := IMX6SL
BOARD_HAVE_VPU := true
HAVE_FSL_IMX_GPU := false
HAVE_FSL_IMX_IPU := false
BOARD_KERNEL_BASE := 0x80800000
TARGET_KERNEL_DEFCONF := imx6s_android_defconfig
HAVE_FSL_IMX_CODEC := false
TARGET_HAVE_IMX_GRALLOC := false
TARGET_HAVE_IMX_HWCOMPOSER = false
USE_OPENGL_RENDERER := false
TARGET_CPU_SMP := false
