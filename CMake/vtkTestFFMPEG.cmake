IF (FFMPEG_INCLUDE_DIR)
  IF("VTK_FFMPEG_HAS_OLD_HEADER" MATCHES "^VTK_FFMPEG_HAS_OLD_HEADER$" OR NOT "VTK_FFMPEG_CACHED_INCLUDE" MATCHES "^${FFMPEG_INCLUDE_DIR}$")
    IF (EXISTS ${FFMPEG_INCLUDE_DIR}/ffmpeg)
      SET(VTK_FFMPEG_HAS_OLD_HEADER "TRUE" CACHE INTERNAL "Is the FFMPEG include in the old location" FORCE)
    ELSE (EXISTS ${FFMPEG_INCLUDE_DIR}/ffmpeg)
      SET(VTK_FFMPEG_HAS_OLD_HEADER "FALSE" CACHE INTERNAL "Is the FFMPEG include in the old location" FORCE)
    ENDIF (EXISTS ${FFMPEG_INCLUDE_DIR}/ffmpeg)
    IF (VTK_FFMPEG_HAS_OLD_HEADER)
      MESSAGE(STATUS "Checking if FFMPEG uses old style header files - yes")
    ELSE (VTK_FFMPEG_HAS_OLD_HEADER)
      MESSAGE(STATUS "Checking if FFMPEG uses old style header files - no")
    ENDIF (VTK_FFMPEG_HAS_OLD_HEADER)
    SET(VTK_FFMPEG_CACHED_INCLUDE ${FFMPEG_INCLUDE_DIR} CACHE INTERNAL "Previous value of FFMPEG_INCLUDE_DIR" FORCE)
  ENDIF("VTK_FFMPEG_HAS_OLD_HEADER" MATCHES "^VTK_FFMPEG_HAS_OLD_HEADER$" OR NOT "VTK_FFMPEG_CACHED_INCLUDE" MATCHES "^${FFMPEG_INCLUDE_DIR}$")

  IF("VTK_FFMPEG_HAS_IMG_CONVERT" MATCHES "^VTK_FFMPEG_HAS_IMG_CONVERT$" OR NOT "VTK_FFMPEG_CACHED_AVCODEC" MATCHES "^${FFMPEG_avcodec_LIBRARY}$")
    IF(VTK_FFMPEG_HAS_OLD_HEADER)
      SET(VTK_FFMPEG_CDEFS "HAS_OLD_HEADER")
    ELSE(VTK_FFMPEG_HAS_OLD_HEADER)
      SET(VTK_FFMPEG_CDEFS "HAS_NEW_HEADER")
    ENDIF(VTK_FFMPEG_HAS_OLD_HEADER)

    IF(FFMPEG_avcodec_LIBRARY)
      TRY_COMPILE(VTK_FFMPEG_HAS_IMG_CONVERT
        ${VTK_BINARY_DIR}/CMakeTmp
        ${VTK_CMAKE_DIR}/vtkFFMPEGTestImgConvert.cxx
        CMAKE_FLAGS "-DINCLUDE_DIRECTORIES:STRING=${FFMPEG_INCLUDE_DIR}"
          "-DLINK_LIBRARIES:STRING=${FFMPEG_avcodec_LIBRARY};${FFMPEG_avutil_LIBRARY}"
          -DCOMPILE_DEFINITIONS:STRING=-D${VTK_FFMPEG_CDEFS}
        OUTPUT_VARIABLE OUTPUT)
      IF(VTK_FFMPEG_HAS_IMG_CONVERT)
        MESSAGE(STATUS "Checking if FFMPEG has img_convert - found")
        FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
                "Checking if FFMPEG has img_convert (passed):\n"
                "${OUTPUT}\n\n")
      ELSE(VTK_FFMPEG_HAS_IMG_CONVERT)
        MESSAGE(STATUS "Checking if FFMPEG has img_convert - not found")
        FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
                "Checking if FFMPEG has img_convert (failed):\n"
                "${OUTPUT}\n\n")
      ENDIF(VTK_FFMPEG_HAS_IMG_CONVERT)
    ENDIF(FFMPEG_avcodec_LIBRARY)
    SET(VTK_FFMPEG_CACHED_AVCODEC ${FFMPEG_avcodec_LIBRARY} CACHE INTERNAL "Previous value of FFMPEG_avcodec_LIBRARY" FORCE)
  ENDIF("VTK_FFMPEG_HAS_IMG_CONVERT" MATCHES "^VTK_FFMPEG_HAS_IMG_CONVERT$" OR NOT "VTK_FFMPEG_CACHED_AVCODEC" MATCHES "^${FFMPEG_avcodec_LIBRARY}$")

  IF("VTK_FFMPEG_OLD_URL_FCLOSE" MATCHES "^VTK_FFMPEG_OLD_URL_FCLOSE$" OR NOT "VTK_FFMPEG_CACHED_AVFORMAT" MATCHES "^${FFMPEG_avformat_LIBRARY}$")
    IF(VTK_FFMPEG_HAS_OLD_HEADER)
      SET(VTK_FFMPEG_CDEFS "HAS_OLD_HEADER")
    ELSE(VTK_FFMPEG_HAS_OLD_HEADER)
      SET(VTK_FFMPEG_CDEFS "HAS_NEW_HEADER")
    ENDIF(VTK_FFMPEG_HAS_OLD_HEADER)

    IF(FFMPEG_avformat_LIBRARY)
      TRY_COMPILE(VTK_FFMPEG_OLD_URL_FCLOSE
        ${VTK_BINARY_DIR}/CMakeTmp
        ${VTK_CMAKE_DIR}/vtkFFMPEGTestURLFClose.cxx
        CMAKE_FLAGS "-DINCLUDE_DIRECTORIES:STRING=${FFMPEG_INCLUDE_DIR}"
          -DCOMPILE_DEFINITIONS:STRING=-D${VTK_FFMPEG_CDEFS}
          "-DLINK_LIBRARIES:STRING=${FFMPEG_avformat_LIBRARY};${FFMPEG_avutil_LIBRARY};${FFMPEG_avcodec_LIBRARY}"
        OUTPUT_VARIABLE OUTPUT)

        IF(VTK_FFMPEG_OLD_URL_FCLOSE)
          MESSAGE(STATUS "Checking if FFMPEG uses old API for url_fclose - found")
          FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
                  "Checking if FFMPEG uses old API for url_fclose (passed):\n"
                  "${OUTPUT}\n\n")
        ELSE(VTK_FFMPEG_OLD_URL_FCLOSE)
          MESSAGE(STATUS "Checking if FFMPEG uses old API for url_fclose - not found")
          FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
                  "Checking if FFMPEG uses old API for url_fclose (failed):\n"
                  "${OUTPUT}\n\n")
        ENDIF(VTK_FFMPEG_OLD_URL_FCLOSE)
    ENDIF(FFMPEG_avformat_LIBRARY)
  ENDIF("VTK_FFMPEG_OLD_URL_FCLOSE" MATCHES "^VTK_FFMPEG_OLD_URL_FCLOSE$" OR NOT "VTK_FFMPEG_CACHED_AVFORMAT" MATCHES "^${FFMPEG_avformat_LIBRARY}$")

  IF("VTK_FFMPEG_NEW_ALLOC" MATCHES "^VTK_FFMPEG_NEW_ALLOC$" OR NOT "VTK_FFMPEG_CACHED_AVFORMAT" MATCHES "^${FFMPEG_avformat_LIBRARY}$")
    IF(VTK_FFMPEG_HAS_OLD_HEADER)
      SET(VTK_FFMPEG_CDEFS "HAS_OLD_HEADER")
    ELSE(VTK_FFMPEG_HAS_OLD_HEADER)
      SET(VTK_FFMPEG_CDEFS "HAS_NEW_HEADER")
    ENDIF(VTK_FFMPEG_HAS_OLD_HEADER)

    IF(FFMPEG_avformat_LIBRARY)
      TRY_COMPILE(VTK_FFMPEG_NEW_ALLOC
        ${VTK_BINARY_DIR}/CMakeTmp
        ${VTK_CMAKE_DIR}/vtkFFMPEGTestAvAlloc.cxx
        CMAKE_FLAGS "-DINCLUDE_DIRECTORIES:STRING=${FFMPEG_INCLUDE_DIR}"
          -DCOMPILE_DEFINITIONS:STRING=-D${VTK_FFMPEG_CDEFS}
          -DCOMPILE_DEFINITIONS:STRING=-D__STDC_CONSTANT_MACROS
         "-DLINK_LIBRARIES:STRING=${FFMPEG_avformat_LIBRARY}"
        OUTPUT_VARIABLE OUTPUT)

      IF(VTK_FFMPEG_NEW_ALLOC)
        MESSAGE(STATUS "Checking if FFMPEG has avformat_alloc_context - found")
        FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeOutput.log
                "Checking if FFMPEG has avformat_alloc_context (passed):\n"
                "${OUTPUT}\n\n")
      ELSE(VTK_FFMPEG_NEW_ALLOC)
        MESSAGE(STATUS "Checking if FFMPEG has avformat_alloc_context - not found")
        FILE(APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
                "Checking if FFMPEG has avformat_alloc_context (failed):\n"
                "${OUTPUT}\n\n")
      ENDIF(VTK_FFMPEG_NEW_ALLOC)
    ENDIF(FFMPEG_avformat_LIBRARY)
    SET(VTK_FFMPEG_CACHED_AVFORMAT ${FFMPEG_avformat_LIBRARY} CACHE INTERNAL "Previous value of FFMPEG_avformat_LIBRARY" FORCE)
  ENDIF("VTK_FFMPEG_NEW_ALLOC" MATCHES "^VTK_FFMPEG_NEW_ALLOC$" OR NOT "VTK_FFMPEG_CACHED_AVFORMAT" MATCHES "^${FFMPEG_avformat_LIBRARY}$")
ENDIF (FFMPEG_INCLUDE_DIR)
