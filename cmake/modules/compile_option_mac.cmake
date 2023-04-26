target_compile_options(${EXECUTABLE} PRIVATE
    -g
    -O3 
    -Wall 
    -Wextra 
    -pedantic   
    -fno-common 
    -ffunction-sections 
    -fdata-sections 
    -fno-builtin 
    -fno-rtti 
    -fno-exceptions    
    $<$<BOOL:${WP_PLATFORM_LINUX}>:-DWP_PLATFORM_LINUX>
    $<$<BOOL:${WP_PLATFORM_MAC}>:  -DWP_PLATFORM_MAC>
    $<$<BOOL:${WP_PLATFORM_NXP}>:  -DWP_PLATFORM_NXP>
    -Wfatal-errors
)
