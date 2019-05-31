#!/bin/sh
 ### Set the job name
 #PBS -N GidonSegev_eNa
 
 ### Declare myprogram non-rerunable
 #PBS -r n
  
 ### Combine standard error and standard out to one file.
 #PBS -j oe
  
 ### Have PBS mail you results
 #PBS -m abe
#PBS -M tom.morse@yale.edu
  
 ### Set the queue name, given to you when you get a reservation. 
#PBS -q general
  
 ### Specify the number of cpus for your job.  This example would run on 32 cpus 
 ### using 8 nodes with 4 processes per node if the cmd was PBS -l nodes=8:ppn=4
#PBS -l nodes=3:ppn=4
  
 # Switch to the working directory; by default PBS launches processes from your home directory.
 # Jobs should only be run from /home, /project, or /work; PBS returns results via NFS.
 echo Working directory is $PBS_O_WORKDIR
 cd $PBS_O_WORKDIR 

 echo Running on host `hostname`
 echo Time is `date`
 echo Directory is `pwd`
 echo This jobs runs on the following processors:
 echo `cat $PBS_NODEFILE`

 # Define number of processors
 NPROCS=`wc -l < $PBS_NODEFILE`
 # And the number or hosts
 NHOSTS=`cat $PBS_NODEFILE|uniq|wc -l`
 echo This job has allocated $NPROCS cpus

 #cleanup debris left over from last mpich job
 #mpdcleanup --file=$PBS_NODEFILE
  
 MPD_CON_EXT=`date`
 #mpdboot --file=$PBS_NODEFILE -n $NHOSTS
 #wait for mpdboot to establish communication ring
 #sleep 10
# mpiexec -n $NPROCS my_job
#mpiexec -np $NPROCS $HOME/modeldb/20121216/x86_64/special -mpi test0.hoc
mpiexec -np $NPROCS $HOME/bin/neuron/nrn/x86_64/bin/nrniv -mpi mosinit.hoc driver.hoc

 #mpdallexit
