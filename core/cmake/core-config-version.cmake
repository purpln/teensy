include(${CMAKE_CURRENT_LIST_DIR}/parse-version.cmake)

set(version 1.0.0)

parse_version("${version}" PACKAGE)

#message(${PACKAGE_VERSION_MAJOR}.${PACKAGE_VERSION_MINOR}.${PACKAGE_VERSION_PATCH})

if(PACKAGE_FIND_VERSION_MAJOR)
    if("${PACKAGE_FIND_VERSION_MAJOR}" EQUAL "${PACKAGE_VERSION_MAJOR}")
        if ("${PACKAGE_FIND_VERSION_MINOR}" EQUAL "${PACKAGE_VERSION_MINOR}")
            set(PACKAGE_VERSION_EXACT TRUE)
        elseif("${PACKAGE_FIND_VERSION_MINOR}" LESS "${PACKAGE_VERSION_MINOR}")
            set(PACKAGE_VERSION_COMPATIBLE TRUE)
        else()
            set(PACKAGE_VERSION_UNSUITABLE TRUE)
        endif()
    else()
        set(PACKAGE_VERSION_UNSUITABLE TRUE)
    endif()
endif()