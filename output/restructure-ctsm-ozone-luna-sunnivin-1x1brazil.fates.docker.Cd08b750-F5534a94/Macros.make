SUPPORTS_CXX := FALSE
ifeq ($(COMPILER),gnu)
  FC_AUTO_R8 :=  -fdefault-real-8 
  HAS_F2008_CONTIGUOUS := FALSE
  FFLAGS_NOOPT :=  -O0 
  FFLAGS :=   -fconvert=big-endian -ffree-line-length-none -ffixed-line-length-none 
  FIXEDFLAGS :=   -ffixed-form 
  SCC :=  gcc 
  SFC :=  gfortran 
  MPICC :=  mpicc  
  CFLAGS :=  -std=gnu99 
  MPIFC :=  mpif90 
  MPICXX :=  mpicxx 
  FREEFLAGS :=  -ffree-form 
  CXX_LINKER := FORTRAN
  SCXX :=  g++ 
endif
ifeq ($(COMPILER),gnu)
  SUPPORTS_CXX := TRUE
  ifeq ($(MPILIB),mpi-serial)
    SCC := gcc
    SFC := gfortran
  endif
endif
CPPDEFS := $(CPPDEFS)  -DCESMCOUPLED 
ifeq ($(MODEL),pop)
  CPPDEFS := $(CPPDEFS)  -D_USE_FLOW_CONTROL 
endif
ifeq ($(MODEL),ufsatm)
  FFLAGS := $(FFLAGS)  $(FC_AUTO_R8) 
  CPPDEFS := $(CPPDEFS)  -DSPMD 
endif
ifeq ($(MODEL),mom)
  FFLAGS := $(FFLAGS)  $(FC_AUTO_R8) -Duse_LARGEFILE
endif
ifeq ($(COMPILER),gnu)
  CPPDEFS := $(CPPDEFS)  -DFORTRANUNDERSCORE -DNO_R16 -DCPRGNU
  SLIBS := $(SLIBS)  -L$(HDF5_HOME)/lib -lhdf5_fortran -lhdf5 -lhdf5_hl -lhdf5hl_fortran 
  SLIBS := $(SLIBS)  -L$(NETCDF_PATH)/lib/ -lnetcdff -lnetcdf -lcurl -lblas -llapack 
  ifeq ($(compile_threaded),TRUE)
    FFLAGS := $(FFLAGS)  -fopenmp 
    CFLAGS := $(CFLAGS)  -fopenmp 
  endif
  ifeq ($(DEBUG),TRUE)
    FFLAGS := $(FFLAGS)  -g -Wall -Og -fbacktrace -ffpe-trap=zero,overflow -fcheck=bounds 
    FFLAGS := $(FFLAGS)  -g -fbacktrace -fbounds-check -ffpe-trap=invalid,zero,overflow
    CFLAGS := $(CFLAGS)  -g -Wall -Og -fbacktrace -ffpe-trap=invalid,zero,overflow -fcheck=bounds 
  endif
  ifeq ($(DEBUG),FALSE)
    FFLAGS := $(FFLAGS)  -O 
    FFLAGS := $(FFLAGS)  
    CFLAGS := $(CFLAGS)  -O 
  endif
  ifeq ($(MODEL),gptl)
    CPPDEFS := $(CPPDEFS)  -DHAVE_VPRINTF -DHAVE_GETTIMEOFDAY -DHAVE_BACKTRACE 
  endif
  ifeq ($(compile_threaded),TRUE)
    LDFLAGS := $(LDFLAGS)  -fopenmp 
  endif
endif
ifeq ($(MODEL),ufsatm)
  INCLDIR := $(INCLDIR)  -I$(EXEROOT)/atm/obj/FMS 
endif
