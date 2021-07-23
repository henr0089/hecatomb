"""
Snakefile to add a new host genome for use with Hecatomb.

Hecatomb will filter contaminant reads from the host organism for viral metagenomes using nucleotide alignments.
The genomes need to have their viral-like sequences masked before they can be used for filtering in Hecatomb.

Michael Roach, Q2 2021
"""

import os
import sys

# IMPORT DIRECTORIES
include: "rules/00_directories.smk"

# REQUIRED CONFIG
virShred = os.path.join(DBDIR, 'hosts', 'virus_shred.fasta.gz')
hostFasta = config['HostFa']
hostName = config['HostName']
entropy = config['Entropy']

# FOR SLURM
LOGDIR = 'logs'
if not os.path.exists(LOGDIR):
    os.mkdir(LOGDIR)

# OUTPUT HOST FASTA
hostOutFasta = os.path.join(DBDIR, 'hosts', f'{hostName}_virus_masked.fasta')

# IMPORT THE RULES
include: "rules/a0_mask_host.smk"

# RUN
rule all:
    input:
        hostOutFasta