#!/bin/bash
#
#SBATCH -A adamjan11_gpu
#SBATCH --job-name=MemPreNoEF_m7d5y23
#SBATCH --partition=a100
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --output=slurm_equi.out
#SBATCH --mail-type=end
#SBATCH --mail-user=vboosha1@jhu.edu

ml amber

amber=pmemd.cuda

init=step5_input
mini_prefix=step6.0_minimization
equi_prefix=step6.%d_minimization
prod_prefix=step7_production_noef
prod_step=step7.0


####### MINIMIZATION #########
if [ -f dihe.restraint ]; then
	sed 's/FC/250.0/g' dihe.restraint > ${mini_prefix}.rest
fi

${amber} -O -i $mini_prefix.mdin -p $init.parm7 -c $init.rst7 -o $mini_prefix.mdout -r $mini_prefix.rst7 -inf $mini_prefix.mdinfo -ref $init.rst7

echo "MINIMIZATION COMPLETE"

######### EQUILIBRATION #########

cnt=1
cntmax=10
fc=(250.0 100.0 50.0 50.0 25.0)

while [ ${cnt} -le ${cntmax} ]
do
	pcnt=$(($cnt - 1))
	istep=$(printf ${equi_prefix} ${cnt})
	pstep=$(printf ${equi_prefix} ${pcnt})
	if [${cnt} == 1]; then
		pstep=${mini_prefix}
	fi

	if [-f dihe.restraint -a ${cnt} -lt ${cntmax}]; then
		sed "s/FC/${fc[${pcnt}]}/g" dihe.restraint > ${istep}.rest
	fi

	${amber} -O -i ${istep}.mdin -p ${init}.parm7 -c ${pstep}.rst7 -o ${istep}.mdout -r ${istep}.rst7 -inf ${istep}.mdinfo -ref ${init}.rst7 -x ${istep}.nc
	echo "EQUILIBRATION" ${istep} "COMPLETE"
	cnt=$(($cnt + 1))
done

echo "EQUILIBRATION COMPLETE"


