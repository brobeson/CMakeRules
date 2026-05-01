#[[
the_target(<target> MAY_NOT DEPEND_ON ANYTHING)
the_target(<target> MAY_NOT DEPEND_ON <target> [<target> [<target> ...] ])
#]]
function(the_target TARGET)
  if(NOT TARGET ${TARGET})
    message(SEND_ERROR "Target rules require a valid target; '${TARGET}' is not a target.")
    return()
  endif()
  cmake_parse_arguments(
    "arg"
    "MAY_NOT;DEPEND_ON;ANYTHING"
    ""
    ""
    ${ARGN}
  )
  if(NOT arg_MAY_NOT)
    message(SEND_ERROR "Target rules require the predicate 'MAY_NOT'.")
    return()
  endif()
  if(NOT arg_DEPEND_ON)
    message(SEND_ERROR "Target rules require the predicate 'DEPEND_ON'.")
    return()
  endif()
  if(NOT arg_ANYTHING AND NOT arg_UNPARSED_ARGUMENTS)
    message(SEND_ERROR "Target rule requires 'ANYTHING' or a list of target dependencies.")
    return()
  endif()
endfunction()

function(_internal_does_target_depend_on)
endfunction()

the_target(supernovas.supernovas MAY_NOT DEPEND_ON ANYTHING)
the_target(supernovas.supernovas MAY_NOT DEPEND_ON julian_date_test)
no_target(EXCEPT julian_date_test MAY DEPEND_ON Boost::unit_test_framework)
all_targets(EXCEPT ".+_test" MATCH "supernovas\.+")
