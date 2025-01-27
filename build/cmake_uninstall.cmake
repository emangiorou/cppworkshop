if (EXISTS "/home/ubuntu/workspace/build/install_manifest.txt")
  #message (STATUS "Using install manifest: \"/home/ubuntu/workspace/build/install_manifest.txt\"")
  file (READ "/home/ubuntu/workspace/build/install_manifest.txt" files)
  string (REGEX REPLACE "\n" " " files "${files}")
  string (STRIP "${files}" files)
  string (REGEX REPLACE " " ";" files "${files}")
  list (REVERSE files)
  foreach (file ${files})
    message (STATUS "Uninstalling \"$ENV{DESTDIR}${file}\"")
    if (EXISTS "$ENV{DESTDIR}${file}")
      execute_process (
        COMMAND /usr/bin/cmake -E remove "$ENV{DESTDIR}${file}"
        OUTPUT_VARIABLE rm_out
        RESULT_VARIABLE rm_retval)
      if (NOT ${rm_retval} EQUAL 0)
        message (FATAL_ERROR "Problem when removing \"$ENV{DESTDIR}${file}\"")
      endif ()
    else ()
      message (STATUS "File \"$ENV{DESTDIR}${file}\" does not exist.")
    endif ()
  endforeach ()
endif ()

