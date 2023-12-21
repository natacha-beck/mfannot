echo "\n*****************************"
echo "       Executable Path       "
echo "*****************************"

echo "\nwhich git"
which git
echo "\nwhich blastall"
which blastall
echo "\nwhich hmmsearch"
which hmmsearch
echo "\nwhich exonerate"
which exonerate
echo "\nwhich flip"
which flip
echo "\nwhich umac"
which umac
echo "\nwhich HMMsearchWrapper"
which HMMsearchWrapper
echo "\nwhich cmsearch"
which cmsearch
echo "\nwhich mfannot"
which mfannot
echo "\nwhich RNAfinder"
which RNAfinder
echo "\nwhich mf2sqn"
which mf2sqn
echo "\nwhich grab-fasta"

echo "\n*****************************"
echo "       Version               "
echo "*****************************"

echo "\nPirObject commit"
git --git-dir=/PirObject/.git log    | head -1 | cut -d " " -f 2

echo "\nPirModels commit"
git --git-dir=/PirModels/.git log    | head -1 | cut -d " " -f 2

echo "\nflip commit"
git --git-dir=/flip/.git log         | head -1 | cut -d " " -f 2

echo "\numac commit"
git --git-dir=/umac/.git log         | head -1 | cut -d " " -f 2

echo "\nHMMsearchWC commit"
git --git-dir=/HMMsearchWC/.git log  | head -1 | cut -d " " -f 2

echo "\nCMsearchW commit"
git --git-dir=/CMsearchW/.git log    | head -1 | cut -d " " -f 2

echo "\nRNAfinder commit"
git --git-dir=/RNAfinder/.git log    | head -1 | cut -d " " -f 2

echo "\nmf2sqn commit"
git --git-dir=/mf2sqn/.git log       | head -1 | cut -d " " -f 2

echo "\ngrab-fasta commit"
git --git-dir=/grab-fasta/.git log   | head -1 | cut -d " " -f 2

echo "\nmfannot commit"
git --git-dir=/mfannot/.git log      | head -1 | cut -d " " -f 2

echo "\nMFannot_data commit"
git --git-dir=/MFannot_data/.git log | head -1 | cut -d " " -f 2

echo "\n*****************************"
echo "       Environment Var       "
echo "*****************************"

echo "\nRNAFINDER_CFG_PATH"
echo $RNAFINDER_CFG_PATH
echo "\nMF2SQN_LIB"
echo $MF2SQN_LIB
echo "\nMFANNOT_LIB_PATH"
echo $MFANNOT_LIB_PATH
echo "\nMFANNOT_EXT_CFG_PATH"0
echo $MFANNOT_EXT_CFG_PATH
echo "\nMFANNOT_MOD_PATH"
echo $MFANNOT_MOD_PATH
echo "\nBLASTMAT"
echo $BLASTMAT
echo "\nEGC"
echo $EGC
echo "\nERPIN_MOD_PATH"
echo $ERPIN_MOD_PATH
echo "\nPIR_DATAMODEL_PATH"
echo $PIR_DATAMODEL_PATH
echo "\nPATH"
echo $PATH

echo "\n*****************************"
echo "       Command Line          "
echo "*****************************"

if [ $# -eq 2 ]
then
    echo "mfannot -g $1 -d $2 > $2.mfannot.out\n"
    mfannot -g $1 -d $2 > $2.mfannot.out
    # Define tmp var
    mfannot_tmp=$(cat $2.mfannot.out | tail -1 |  cut -d " " -f 4)
    echo "\nmfannot_tmp=$tmp\n"
    RNAfinder -m IntronI  -D -g $1 -d $mfannot_tmp/Contig_ext/contig1 -M $mfannot_tmp/Contig_ext/contig1-IntronI.xml
    RNAfinder -m IntronII -D -g $1 -d $mfannot_tmp/Contig_ext/contig1 -M $mfannot_tmp/Contig_ext/contig1-IntronII.xml
elif [ $# -eq 1 ]
then
    echo "mfannot -d $1 > $1.mfannot.out\n"
    mfannot -d $1 > $1.mfannot.out
    mfannot_tmp=$(cat $2.mfannot.out | tail -1 |  cut -d " " -f 4)
    RNAfinder -m IntronI  -D -g 1 -d $mfannot_tmp/Contig_ext/contig1 -M $mfannot_tmp/Contig_ext/contig1-IntronI.xml
    RNAfinder -m IntronII -D -g 1 -d $mfannot_tmp/Contig_ext/contig1 -M $mfannot_tmp/Contig_ext/contig1-IntronII.xml
else
    echo "Should be 1 or 2 arguments (got $#) (genetic code and genome)"
fi
