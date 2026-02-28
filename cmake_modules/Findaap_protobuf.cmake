set(_AAP_PROTOBUF_HINT_PATHS "")
if(DEFINED AASDK_BUILD_DIR AND NOT "${AASDK_BUILD_DIR}" STREQUAL "")
    list(APPEND _AAP_PROTOBUF_HINT_PATHS
        "${AASDK_BUILD_DIR}"
        "${AASDK_BUILD_DIR}/protobuf"
        "${AASDK_BUILD_DIR}/lib")
endif()
if(DEFINED AASDK_ROOT AND NOT "${AASDK_ROOT}" STREQUAL "")
    list(APPEND _AAP_PROTOBUF_HINT_PATHS
        "${AASDK_ROOT}"
        "${AASDK_ROOT}/protobuf"
        "${AASDK_ROOT}/build-release"
        "${AASDK_ROOT}/build-release/protobuf"
        "${AASDK_ROOT}/build-release/lib")
endif()

if (AAP_PROTOBUF_LIB_DIRS AND AAP_PROTOBUF_INCLUDE_DIRS)
    # in cache already
    message(STATUS "aap_protobuf is cached")
    # Keep singular vars in sync for legacy consumers in CMakeLists.txt
    set(AAP_PROTOBUF_INCLUDE_DIR ${AAP_PROTOBUF_INCLUDE_DIRS})
    set(AAP_PROTOBUF_LIB_DIR ${AAP_PROTOBUF_LIB_DIRS})
    set(AAP_PROTOBUF_FOUND TRUE)
else (AAP_PROTOBUF_LIB_DIRS AND AAP_PROTOBUF_INCLUDE_DIRS)
    find_path(AAP_PROTOBUF_INCLUDE_DIR
            NAMES
            channel/control/GalConstants.pb.h
            PATHS
            ${_AAP_PROTOBUF_HINT_PATHS}
            /usr/include
            /usr/local/include
            /opt/local/include
            /sw/include
            PATH_SUFFIXES
            aap_protobuf
    )

    find_library(AAP_PROTOBUF_LIB_DIR
            NAMES
            aap_protobuf libaap_protobuf
            PATHS
            ${_AAP_PROTOBUF_HINT_PATHS}
            /usr/lib
            /usr/local/lib
            /opt/local/lib
            /sw/lib
    )

    set(AAP_PROTOBUF_INCLUDE_DIRS
            ${AAP_PROTOBUF_INCLUDE_DIR}
    )
    set(AAP_PROTOBUF_LIB_DIRS
            ${AAP_PROTOBUF_LIB_DIR}
    )

    if (AAP_PROTOBUF_INCLUDE_DIRS AND AAP_PROTOBUF_LIB_DIRS)
        set(AAP_PROTOBUF_FOUND TRUE)
    endif (AAP_PROTOBUF_INCLUDE_DIRS AND AAP_PROTOBUF_LIB_DIRS)

    if (AAP_PROTOBUF_FOUND)
        message(STATUS "SUCCESS. Found: aap_protobuf:")
        message(STATUS " - Includes: ${AAP_PROTOBUF_INCLUDE_DIRS}")
        message(STATUS " - Libraries: ${AAP_PROTOBUF_LIB_DIRS}")
        add_library(aap_protobuf INTERFACE)
        target_include_directories(aap_protobuf SYSTEM INTERFACE ${AAP_PROTOBUF_INCLUDE_DIR})
        target_link_libraries(aap_protobuf INTERFACE ${AAP_PROTOBUF_LIB_DIR})
    else (AAP_PROTOBUF_FOUND)
        message(STATUS " - Includes: ${AAP_PROTOBUF_INCLUDE_DIRS}")
        message(STATUS " - Libraries: ${AAP_PROTOBUF_LIB_DIRS}")
        message(FATAL_ERROR "Could not locate aap_protobuf")
    endif (AAP_PROTOBUF_FOUND)

    # show the AAP_PROTOBUF_INCLUDE_DIRS and AAP_PROTOBUF_LIB_DIRS variables only in the advanced view
    mark_as_advanced(AAP_PROTOBUF_INCLUDE_DIRS AAP_PROTOBUF_LIB_DIRS)

endif (AAP_PROTOBUF_LIB_DIRS AND AAP_PROTOBUF_INCLUDE_DIRS)
