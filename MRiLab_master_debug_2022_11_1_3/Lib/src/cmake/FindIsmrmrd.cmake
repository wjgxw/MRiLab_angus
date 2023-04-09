
# - Find ISMRMRRD
#   ISMRMRD_FOUND            - true if an ISMRMRD installation is found.
#   ISMRMRD_INCLUDE_DIR      - where to find ismrmrd.h, etc.
#   ISMRMRD_LIBRARIES        - libismrmrd.so.
#   ISMRMRD_XSD_INCLUDE_DIR  - folder containing ismrmrd.hxx (autogenerated from xsd schema)
#   ISMRMRD_XSD_SOURCE       - full path to ismrmrd.cxx (autogenerated from xsd schema)
#   ISMRMRD_SCHEMA_DIR       - where to find ismrmrd.xsd       

FIND_PATH( ISMRMRD_INCLUDE_DIR ismrmrd.h 
HINTS $ENV{ISMRMRD_HOME} PATHS /usr/local /usr PATH_SUFFIXES include ismrmrd ismrmrd/include)

FIND_PATH( ISMRMRD_XSD_INCLUDE_DIR ismrmrd.hxx
HINTS $ENV{ISMRMRD_HOME} PATHS /usr/local /usr PATH_SUFFIXES schema ismrmrd ismrmrd/schema)

FIND_PATH( ISMRMRD_SCHEMA_DIR ismrmrd.xsd 
HINTS $ENV{ISMRMRD_HOME} PATHS /usr/local /usr PATH_SUFFIXES schema ismrmrd ismrmrd/schema)

FIND_LIBRARY( ISMRMRD_LIBRARIES
              NAMES "ismrmrd"
              PATHS  /usr/local/lib ${ISMRMRD_INCLUDE_DIR}/../lib /usr/lib )

FIND_FILE( ISMRMRD_XSD_SOURCE
           NAMES "ismrmrd.cxx"
           HINTS $ENV{ISMRMRD_HOME} PATHS /usr/local /usr PATH_SUFFIXES schema ismrmrd ismrmrd/schema)

INCLUDE( "FindPackageHandleStandardArgs" )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( "Ismrmrd" DEFAULT_MSG ISMRMRD_INCLUDE_DIR ISMRMRD_LIBRARIES ISMRMRD_SCHEMA_DIR)

MARK_AS_ADVANCED( ISMRMRD_INCLUDE_DIR ISMRMRD_LIBRARIES ISMRMRD_SCHEMA_DIR)
