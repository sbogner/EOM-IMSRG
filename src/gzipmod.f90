module gzipmod
use, intrinsic :: ISO_C_BINDING
implicit none 

interface 
   function gzOpen( path, mode ) bind(C, NAME='gzopen') 
     use, intrinsic :: ISO_C_BINDING
     character(c_char) :: path(*),mode(*) 
     type(c_ptr) :: gzOpen 
   end function
end interface


interface 
   function gzGets( file,buf,len ) bind(C, NAME='gzgets') 
     use, intrinsic :: ISO_C_BINDING
     character(c_char) :: buf(*)  
     type(c_ptr) :: gzGets 
     integer(c_int),value :: len
     type(c_ptr),value :: file
   end function
end interface

interface 
   function gzClose( file ) bind(C, NAME='gzclose') 
     use, intrinsic :: ISO_C_BINDING
     type(c_ptr) :: gzClose
     type(c_ptr),value :: file
   end function
end interface


interface 
   function gzWrite( file , buf , len) bind(C, NAME='gzwrite') 
     use, intrinsic :: ISO_C_BINDING
     character(c_char) :: buf(*) 
     type(c_ptr) :: gzWrite
     integer(c_int),value :: len
     type(c_ptr),value :: file
   end function gzWrite
end interface

contains

character(52) function read_morten_gz(handle) 
  ! THE FORMAT HERE IS   
  !  Tz  Pi  J  a b c d     V_{abcd}^J
  ! THAT'S IT. IT's 52 CHARACTERS LONG.   
  implicit none
  
  integer(c_int) :: sz
  type(c_ptr) :: buf,handle
  character(kind=C_CHAR,len=200) :: buffer
  
  sz=200 
  buf = gzGets( handle, buffer, sz ) 
  read_morten_gz = buffer(1:52) 

end function 

character(20) function read_normal_gz(handle) 
  ! THE FORMAT HERE IS   
  !  Tz  Pi  J  a b c d     V_{abcd}^J
  ! THAT'S IT. IT's 52 CHARACTERS LONG.   
  implicit none
  
  integer(c_int) :: sz
  type(c_ptr) :: buf,handle
  character(kind=C_CHAR,len=200) :: buffer
  
  sz=200 
  buf = gzGets( handle, buffer, sz ) 
  read_normal_gz = buffer(1:20) 

end function read_normal_gz


subroutine write_gz(handle,string)
  implicit none
  
  character(*) :: string
  integer(c_int) :: sz
  type(c_ptr) :: buf,handle
  integer :: xxx
  character(kind=C_CHAR,len=200) :: buffer
  
  xxx = len(trim(adjustl(string))) + 1
  sz = xxx
  buffer = trim(adjustl(string))//achar(10)
  buf = gzWrite( handle, buffer, sz ) 

end subroutine 

end module
