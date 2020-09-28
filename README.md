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
The high level architecture is depicted in the image below. The tool gets all the relevant information from the source cluster ARM template: storage account, vnet, Ambari and Hive database information and any custom script actions.

It also copies the files that were edited posteriorly to the cluster creation such as environment variables scripts and any hdinsight-specific configuration files.

The destination cluster can then be deployed with the exact same configuration as the source cluster. Alternatively, the tool can be used to generate a make file for a posterior cluster creation. 

The HDICloner can also be used to compare and/or sync two clusters configuration.

![Artifacts/HLA.png](/Artifacts/HLA.png)

## Prerequisites
Before installing Run-HDICloner make sure you have the following prerequisites have been met:

1. PowerShell Core. You can get PowerShell Core 7.0 for Windows, Linux or macOS from [here.](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7)

## Setup
This module is published on [PowerShell Gallery](https://www.powershellgallery.com/packages/HDICloner) and can be installed using Install-Module:

Install-Module -Name HDICloner

## Usage
With this PowerShell module you can run several commands such as "Get,Make,Build,Compare,Sync".

There are five cmdlets in the module; Build-HDIClonerCluster, Make-HDIClonerClusterConfig, Compare-HDIClonerClusterConfig, Get-HDIClonerClusterConfig and Sync-HDIClonerCluster; 

Example: Get the HDInsight cluster configuration with given name and Subscription ID:

Run-HDICloner -Operation Get -SourceCluster SourceClusterdnsName -SourceSubId SourceClusterSubscriptionID  


## Output Explained

The output folder arquitecture is displayed in the image below. Each time the module is run, a new directory with the current timestamp is created under a directory tree structure containing the subscription ID and cluster DNS name. 

The ARM folder contains the json files for all resources that are part of the cluster ARM template including the storage, vnet, Ambari and hive database information and any custom action scrips. 

The HDP folder contains the environment and custom configuration files. 

The Nodes folder stores information about all the headnodes, worker nodes and zookeeper nodes that are part of the HDInsight cluster.


![Artifacts/HLA.png](/Artifacts/Output.png)

## FAQ



## Credits
