cmake_minimum_required(VERSION 3.2)

project(hl_service_mesh C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(AUTH_SERVICE "auth_service")
set(PRODUCT_SERVICE "product_service")
set(CART_SERVICE "cart_service")
set(OTHER_SERVICE "other_service")

find_package(OpenSSL)
find_package(Threads)
find_package(ZLIB)
find_package(Poco REQUIRED COMPONENTS Foundation Util Net XML JSON Crypto NetSSL)


if(NOT ${Poco_FOUND})
    message(FATAL_ERROR "Poco C++ Libraries not found.")
endif()

include_directories(${Poco_INCLUDE_DIRS})
include_directories("/usr/include/mysql")
include_directories("/usr/local/include/mysql")
link_directories("/usr/local/lib")

add_executable(${AUTH_SERVICE} auth_service/main.cpp
                                 config/config.cpp
                                 database/database.cpp
                                 database/user.cpp)
target_include_directories(${AUTH_SERVICE} PRIVATE "${CMAKE_BINARY_DIR}")
target_compile_options(${AUTH_SERVICE} PRIVATE -Wall -Wextra -pedantic -Werror )
set_target_properties(${AUTH_SERVICE} PROPERTIES LINKER_LANGUAGE CXX)
set_target_properties(${AUTH_SERVICE} PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED ON)
target_link_libraries(${AUTH_SERVICE} PRIVATE
                             ${CMAKE_THREAD_LIBS_INIT}
                             ${Poco_LIBRARIES}
                             "PocoData"
                             "PocoDataMySQL"
                             "mysqlclient"
                             ZLIB::ZLIB)

# add_executable(${PRODUCT_SERVICE} product_service/main.cpp
#                                  config/config.cpp
#                                  database/database.cpp
#                                  database/product.cpp)
# target_include_directories(${PRODUCT_SERVICE} PRIVATE "${CMAKE_BINARY_DIR}")
# target_compile_options(${PRODUCT_SERVICE} PRIVATE -Wall -Wextra -pedantic -Werror )
# set_target_properties(${PRODUCT_SERVICE} PROPERTIES LINKER_LANGUAGE CXX)
# set_target_properties(${PRODUCT_SERVICE} PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED ON)
# target_link_libraries(${PRODUCT_SERVICE} PRIVATE
#                              ${CMAKE_THREAD_LIBS_INIT}
#                              ${Poco_LIBRARIES}
#                              "PocoData"
#                              "PocoDataMySQL"
#                              "mysqlclient"
#                              ZLIB::ZLIB)

# add_executable(${CART_SERVICE} cart_service/main.cpp
#                                  config/config.cpp
#                                  database/database.cpp
#                                  database/cart.cpp)
# target_include_directories(${CART_SERVICE} PRIVATE "${CMAKE_BINARY_DIR}")
# target_compile_options(${CART_SERVICE} PRIVATE -Wall -Wextra -pedantic -Werror )
# set_target_properties(${CART_SERVICE} PROPERTIES LINKER_LANGUAGE CXX)
# set_target_properties(${CART_SERVICE} PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED ON)
# target_link_libraries(${CART_SERVICE} PRIVATE
#                              ${CMAKE_THREAD_LIBS_INIT}
#                              ${Poco_LIBRARIES}
#                              "PocoData"
#                              "PocoDataMySQL"
#                              "mysqlclient"
#                              ZLIB::ZLIB)
