if(WP_PLATFORM_NXP)
    add_subdirectory(${RELATIVE_PATH__LIBS_SDK_NXP_PRJ})
endif()
add_subdirectory(${RELATIVE_PATH__LIBS_FW2_CORE_CORE_PRJ})

add_subdirectory(${RELATIVE_PATH__LIBS_FW2_WP_KR_PRJ})

add_subdirectory(${RELATIVE_PATH__LIBS_FW2_WP_RS_PRJ})

add_subdirectory(${RELATIVE_PATH__APPS_XXX_PRJ})

add_subdirectory(main/mpfw_code_main_${MAIN_NAME}/wsp/cmake/project/subdir/${STR_APP_CMAKE_VERSION})
