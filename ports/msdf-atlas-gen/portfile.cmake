set(GIT_URL "https://github.com/Chlumsky/msdf-atlas-gen.git")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})
set(PORT_DEBUG ON)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO Chlumsky/msdf-atlas-gen
  REF b0a423bf00bff8b8776c5c6d168dc8273a8fd62f
  SHA512 806a4716f63a0bb886d149fe21e27e4b4ab4606016d62046c9fde8bf2a1ae385bf3cfe0964a0d2dbaceb56ee5e3b820e5c17b637741fbf5d9b7254e4057d401e
  HEAD_REF master
  PATCHES
    "fix-msdfgen-include.patch"
)

# vcpkg_from_github(
#     OUT_SOURCE_PATH MSDFGEN_SOURCE_PATH
#     REPO Chlumsky/msdfgen
#     REF d7ac1e084d7e790c53b6a88598c469090ca7c8cc
#     SHA512 ba01fe4bd634518a9d52af4253f71c455ddf3ca732ea5d3b045c6e3b5de965f66f7658228d1cefd0f828b8aa66e5eb0f13e8f45449f394f7faf7025b49ad1711
#     HEAD_REF master
# )

# vcpkg_from_github(
#   OUT_SOURCE_PATH ARTERY_FONT_FORMAT_SOURCE_PATH
#   REPO Chlumsky/artery-font-format
#   REF 888674220216d1d326c6f29cf89165b545279c1f
#   SHA512 cd5d0e047506f8a2a7b5fb63dd17786f7e26c264bf305c15ff86db88fde62d1c72214640afed1453834980b0af1ebfe280dae135427a9b3dd47d1feacd2df73c
#   HEAD_REF master
# )

# file(COPY "${MSDFGEN_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/msdfgen")
# file(COPY "${ARTERY_FONT_FORMAT_SOURCE_PATH}/" DESTINATION "${SOURCE_PATH}/artery-font-format")
# if(NOT EXISTS "${SOURCE_PATH}/.git")
# 	message(STATUS "Cloning and fetching submodules")
# 	vcpkg_execute_required_process(
# 	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
# 	  WORKING_DIRECTORY ${DOWNLOADS}
# 	  LOGNAME clone
# 	)
# 	vcpkg_execute_required_process(
# 	  COMMAND ${GIT} checkout tags/v1.2.2
# 	  WORKING_DIRECTORY ${DOWNLOADS}
# 	  LOGNAME clone
# 	)
# endif()

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"  
  OPTIONS 
      -DMSDF_ATLAS_INSTALL=ON
      -DMSDF_ATLAS_MSDFGEN_EXTERNAL=ON
      -DMSDF_ATLAS_NO_ARTERY_FONT=ON
      -DMSDF_ATLAS_BUILD_STANDALONE=OFF
      -DMSDF_ATLAS_USE_SKIA=OFF
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

# cleanup
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# license
file(
  INSTALL "${SOURCE_PATH}/LICENSE.txt"
  DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
  RENAME copyright) 