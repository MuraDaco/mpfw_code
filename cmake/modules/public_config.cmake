##################################################################################
## _______________________________________________________________________________
## RELATIVE PATH Definitions

##################################################################################
## Relative path from CMakeLists.txt project folder                             ##
##################################################################################


include(${RELATIVE_PATH__LIBS}/mpfw_code_libs_common/wsp/cmake/project/public/module_lib_common.cmake                                       )
include(${RELATIVE_PATH__LIBS}/mpfw_code_libs_sdk_${WP_PLATFORM_STR}/wsp/cmake/project/public/module_lib_sdk_${WP_PLATFORM_STR}.cmake       )
include(${RELATIVE_PATH__LIBS}/mpfw_code_libs_fw2_core_core/wsp/cmake/project/public/module_lib_fw2_core_core.cmake                         )
include(${RELATIVE_PATH__LIBS}/mpfw_code_libs_fw2_wrapper_core/common/wsp/cmake/project/public/module_lib_fw2_wrapper_core.cmake            )
include(${RELATIVE_PATH__LIBS}/mpfw_code_libs_fw2_wrapper_resources/common/wsp/cmake/project/public/module_lib_fw2_wrapper_resources.cmake  )
include(${RELATIVE_PATH__APPS}/mpfw_code_apps_${APP_NAME}/wsp/cmake/project/public/module_app_${APP_NAME}.cmake                             )

set(RELATIVE_PATH__LIBS_SDK_PLATFORM_PUBLIC     ${RELATIVE_PATH__LIBS}/mpfw_code_libs_sdk_${WP_PLATFORM_STR}/wsp/cmake/project/public       )
set(RELATIVE_PATH__APPS_PUBLIC                  ${RELATIVE_PATH__APPS}/mpfw_code_apps_${APP_NAME}/wsp/cmake/project/public                  )

