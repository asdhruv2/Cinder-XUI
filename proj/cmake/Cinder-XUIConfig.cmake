if(NOT TARGET Cinder-XUI)
    # Define ${Cinder-XUI_PROJECT_ROOT}. ${CMAKE_CURRENT_LIST_DIR} is just the current directory.
    get_filename_component(Cinder-XUI_PROJECT_ROOT "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)

    # Define ${CINDER_PATH} as usual.
    get_filename_component(CINDER_PATH "${Cinder-XUI_PROJECT_ROOT}/../.." ABSOLUTE)

    # Make a list of source files and define that to be ${SOURCE_LIST}.
    file(GLOB SOURCE_LIST CONFIGURE_DEPENDS
            "${Cinder-XUI_PROJECT_ROOT}/include/*.h"
            "${Cinder-XUI_PROJECT_ROOT}/src/**/*.cc"
            "${Cinder-XUI_PROJECT_ROOT}/src/**/*.cpp"
            "${Cinder-XUI_PROJECT_ROOT}/src/**/*.c"
            "${Cinder-XUI_PROJECT_ROOT}/src/*.cc"
            "${Cinder-XUI_PROJECT_ROOT}/src/*.cpp"
            "${Cinder-XUI_PROJECT_ROOT}/src/*.c")

    # Create the library!
    add_library(Cinder-XUI ${SOURCE_LIST})

    # Add include directories.
    # Notice that `cinderblock.xml` has `<includePath>src</includePath>`.
    # So you need to set `../../src/` to include.
    target_include_directories(Cinder-XUI PUBLIC "${Cinder-XUI_PROJECT_ROOT}/src" )
    target_include_directories(Cinder-XUI SYSTEM BEFORE PUBLIC "${CINDER_PATH}/include" )


    # If your Cinder block has no source code but instead pre-build libraries,
    # you can specify all of them here (uncomment the below line and adjust to your needs).
    # Make sure to use the libraries for the right platform.
    # # target_link_libraries(Cinder-XUI ${Cinder-OpenCV_PROJECT_ROOT}/lib/libopencv_core.a)

    if(NOT TARGET cinder)
        include("${CINDER_PATH}/proj/cmake/configure.cmake")
        find_package(cinder REQUIRED PATHS
                "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
                "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}")
    endif()
    target_link_libraries(Cinder-XUI PRIVATE cinder)

endif()