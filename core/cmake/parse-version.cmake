function (parse_version VERSION_CONTENTS PREFIX)
    # E.g., "MONGOCXX_VERSION".
    string (REPLACE ";" "" VERSION_NAME ${PREFIX} _VERSION)
    string (REPLACE ";" "" DIST_VERSION_NAME ${PREFIX} _DIST_VERSION)

    # A list of version components separated by dots and dashes: "1.3.0-[prerelease-marker]"
    string (REGEX MATCHALL "[^.-]+" VERSION ${VERSION_CONTENTS})

    list (GET VERSION 0 VERSION_MAJOR)
    string (REPLACE ";" "" VERSION_MAJOR_NAME ${PREFIX} _VERSION_MAJOR)
    set (${VERSION_MAJOR_NAME} ${VERSION_MAJOR} PARENT_SCOPE)

    list (GET VERSION 1 VERSION_MINOR)
    string (REPLACE ";" "" VERSION_MINOR_NAME ${PREFIX} _VERSION_MINOR)
    set (${VERSION_MINOR_NAME} ${VERSION_MINOR} PARENT_SCOPE)

    list (GET VERSION 2 VERSION_PATCH)
    string (REPLACE ";" "" VERSION_PATCH_NAME ${PREFIX} _VERSION_PATCH)
    set (${VERSION_PATCH_NAME} ${VERSION_PATCH} PARENT_SCOPE)

    string (REPLACE ";" "" VERSION_EXTRA_NAME ${PREFIX} _VERSION_EXTRA)
    string (REPLACE ";" "" VERSION_DIST_EXTRA_NAME ${PREFIX} _VERSION_DIST_EXTRA)
    list (LENGTH VERSION VERSION_LENGTH)
    if (VERSION_LENGTH GREATER 3)
        list (GET VERSION 3 VERSION_EXTRA)
        set (${VERSION_DIST_EXTRA_NAME} "-${VERSION_EXTRA}" PARENT_SCOPE)
        set (${VERSION_EXTRA_NAME} "-pre" PARENT_SCOPE)
        set (${VERSION_NAME}
            "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}-pre"
            PARENT_SCOPE)
        set (${DIST_VERSION_NAME}
            "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}${VERSION_EXTRA}"
            PARENT_SCOPE)
    else ()
        set (${VERSION_DIST_EXTRA_NAME} "" PARENT_SCOPE)
        set (${VERSION_EXTRA_NAME} "" PARENT_SCOPE)
        set (${VERSION_NAME}
            "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
            PARENT_SCOPE)
        set (${DIST_VERSION_NAME}
            "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}"
            PARENT_SCOPE)
    endif ()
endfunction (parse_version)