##################################################################################
## _______________________________________________________________________________
## RELATIVE PATH Definitions

##################################################################################
## Relative path from CMakeLists.txt project folder                             ##
##################################################################################


set(RELATIVE_PATH__COMMON_LIB                   ${RELATIVE_PATH__LIBS}/common                                                           )
set(RELATIVE_PATH__COMMON_LIB_PRJ               ${RELATIVE_PATH__COMMON_LIB}/wsp/cmake                                                  )

set(RELATIVE_PATH__SDK_NXP                      ${RELATIVE_PATH__LIBS}/sdk_nxp                                                     )
set(RELATIVE_PATH__SDK_NXP_PRJ                  ${RELATIVE_PATH__SDK_NXP}/wsp/cmake/project                                             )
set(RELATIVE_PATH__FW2_LIB                      ${RELATIVE_PATH__LIBS}/fw2/core/core                                               )
set(RELATIVE_PATH__FW2_LIB_PRJ                  ${RELATIVE_PATH__FW2_LIB}/wsp/cmake/project/${STR_FW2_CMAKE_VERSION}                    )
set(RELATIVE_PATH__FW2_WP_RS_LIB                ${RELATIVE_PATH__LIBS}/fw2/wrapper/resources/${WP_PLATFORM_STR}                    )
set(RELATIVE_PATH__FW2_WP_RS_LIB_PRJ            ${RELATIVE_PATH__FW2_WP_RS_LIB}/wsp/cmake/project                                       )
set(RELATIVE_PATH__FW2_WP_KR_LIB                ${RELATIVE_PATH__LIBS}/fw2/wrapper/core/${WP_PLATFORM_STR}                         )
set(RELATIVE_PATH__FW2_WP_KR_LIB_PRJ            ${RELATIVE_PATH__FW2_WP_KR_LIB}/wsp/cmake/project/${STR_FW2_WP_KR_CMAKE_VERSION}        )
set(RELATIVE_PATH__TST_LIB                      ${RELATIVE_PATH__LIBS}/tst_20221206                                                )
set(RELATIVE_PATH__TST_LIB_PRJ                  ${RELATIVE_PATH__TST_LIB}/wsp/cmake/project                                             )


