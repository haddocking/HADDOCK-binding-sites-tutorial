#####################################
#                                   #
#  HADDOCK2.2 tools makefile        #
#                                   #
#####################################

CPP=g++
CPFLAGS=-O2

EXEC=cluster_struc contact 

all: 
	make $(EXEC)

cluster_struc: cluster_struc.cpp
	$(CPP) $(CPFLAGS) -o cluster_struc cluster_struc.cpp
	   
contact: contact.cpp
	$(CPP) $(CPFLAGS) -o contact contact.cpp

clean :
	/bin/rm $(EXEC)

