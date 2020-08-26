# HDICloner

## Overview
A tool that collect HdInisght cluster configuration and clone or prepare the script required to clone. 
This is a comamnd line tool that has the following options: 
1. Get Cluster Configuration.
2. Build Cluster from Configuration
3. Generate Make File for the creation (PowerShell, ARM templates and Action Scripts)
4. Compare two clusters and show differnces (Visual Comparison) 
5. Sync Two clusters configuration 
6. Dry Run configuration (Validate cluster configuration)

## High Level Architecture
![Artifacts/HLA.png](/Artifacts/HLA.png)

## Usage

## Setup

## Output Explained
Default Path: **<User profile Documents>\HDICloner**
        + **<Sub ID ...1234>**
        - <Sub ID ...5678>
                + **<Cluster DNS Name 1>**
                + **<Cluster DNS Name 2>**
                - <Cluster DNS Name 3>**
                        - **20082020_125322**
                                - **ARM**
                                        HDI_CLUSTER-<CLUSTER DNS NAME>.json
                                        HDI_STORAGE_<CLUSTER DNS NAME>_<Storage Name>.json
                                        HDI_VNET_<CLUSTER DNS NAME>_<vnet name.json
                                        HDI_DB_AMBARI_<CLUSTER DNS NAME>_<DB NAME>.json
                                        HDI_DB_HIVE_<CLUSTER DNS NAME>_<DB NAME>.json
                                        HDI_ACTION_SCRIPTS_<CLUSTER DNS NAME>_<DB NAME>.json
                                - **HDP**
                                        + **CONFIG_FILES**
                                        + **ENV_FILES**
                                        + **XML_FILES**
                                -Nodes
                                        + **Head**
                                        + **Worker**
                                        + **Zookeeper**
                        + **20082020_143254**
                        + **22102020_212237**
                + **<Cluster DNS Name 4>**
        + **<Sub ID ...9012>**

## Credits
