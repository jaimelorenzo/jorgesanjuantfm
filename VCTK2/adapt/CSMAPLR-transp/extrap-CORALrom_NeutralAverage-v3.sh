#!/bin/bash

NeutralSpeakers=( "UVD" "JEC" "JLC" )
Styles=( "joa-happiness" )
ratio=( "1.00" )

OUTDIR=Male-Styles
mkdir -p $OUTDIR > /dev/null
WORKDIR="/autofs/home/gth00a/jaime.lorenzo/VCTK/Research-Demo/adapt/CSMAPLR-transp"
MODELSDIR="/autofs/home/gth07a/EXPERIMENTOS/jaime.lorenzo/CSMAPLRmodels/NeutralAverage_fromjoa-emos_NeuSpk"
NAVGDIR="/autofs/home/gth07a/EXPERIMENTOS/jaime.lorenzo/CSMAPLRmodels/joa-emos_NeuSpk/NeutralAverage"
HTSEMOBASE="/autofs/home/gth00a/jaime.lorenzo/VCTK/Research-Demo/inter-module/hts_engine/Spa/joa-neutral_fromNeutralAverage_fromjoa-emos_NeuSpk"
HTSNEUBASE="/autofs/home/gth00a/jaime.lorenzo/VCTK/Research-Demo/inter-module/hts_engine/Spa/NeutralAverage_fromjoa-emos_NeuSpk"

### STREAMSELECTION ###                                                                                                                                     

TRANSPF0=1;
TRANSPSPECT=1;
TRANSPDUR=1;
EMOBASE=0;

# ONLY PROSODY, SPECT FROM THE NEUTRAL SPEAKER

for i in ${NeutralSpeakers[*]}
do
    echo "---------------------"
    echo "It's turn of "$i
    echo "---------------------"

    for factor in ${ratio[*]}
    do
	for j in ${Styles[*]}
	do
	    HTSNEU=$HTSNEUBASE"/"$i
            HTSEMO=$HTSEMOBASE"/"$j
	    echo "---------------------"
	    echo "With Style: "$j" and control factor: "$factor
	    echo "---------------------"	    
	    TMPOUTDIR="XADAPT_BTWiN_"$j"_and_"$i"-K"$factor	    
	    bash xadapt-select.sh $WORKDIR"/"$TMPOUTDIR $MODELSDIR $NAVGDIR $j $i $factor $HTSEMO $HTSNEU $TRANSPF0 $TRANSPSPECT $TRANSPDUR $EMOBASE
	    mv "XADAPT_BTWiN_"$j"_and_"$i"-K"$factor"/"$i"-"$j"-K"$factor $OUTDIR"/"$i"-"$j"-K"$factor"-F0"$TRANSPF0"-SPECT"$TRANSPSPECT"-EMOBASE"$EMOBASE
	    rm -r $TMPOUTDIR
	done
    done
    
done
