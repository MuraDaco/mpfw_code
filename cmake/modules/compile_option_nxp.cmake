target_compile_options(${EXECUTABLE} PRIVATE
    -Os 
    -fno-common 
    -g 
    -Wall 
    -c 
    -ffunction-sections 
    -fdata-sections 
    -ffreestanding 
    -fno-builtin 
    $<$<COMPILE_LANG_AND_ID:CXX,GNU>: -fno-rtti -fno-exceptions -std=gnu++14>        

    $<$<BOOL:${WP_PLATFORM_NXP}>: -mcpu=cortex-m4>
    $<$<BOOL:${WP_PLATFORM_NXP}>: -mfpu=fpv4-sp-d16>
    $<$<BOOL:${WP_PLATFORM_NXP}>: -mfloat-abi=hard>
    $<$<BOOL:${WP_PLATFORM_NXP}>: -mthumb>
    $<$<BOOL:${WP_PLATFORM_NXP}>: -fstack-usage>
    $<$<BOOL:${WP_PLATFORM_NXP}>: -specs=nano.specs>

    -Wfatal-errors

)

target_compile_definitions(${EXECUTABLE} PRIVATE
    -DCPU_LPC54608J512ET180 
    -DCPU_LPC54608J512ET180_cm4 
    -DFSL_RTOS_FREE_RTOS 
    -DSDK_OS_FREE_RTOS 
    -DSERIAL_PORT_TYPE_UART=1 
    -DSDK_DEBUGCONSOLE=1 
    -D__MCUXPRESSO 
    -D__USE_CMSIS 
    -D__NEWLIB__ 
)

