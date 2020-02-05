The following information should eventually go into a proper documentation-repo, but for now we use this README to define the Poseidon format.

# What is Poseidon?
Poseidon is a format to store, distribute and co-analyse archaeogenetic and present-day genetic data. It bridges a much-needed link between archaeological, geographical, temporal and genomic information.

Poseidon follows a modular approach, with the a single module storing information for a collection of individuals, for example those analysed in an academic publication.

Poseidon is - at this point - not a database, but it may very well become one. The more published datasets are published using the Poseidon-Module format, the more relevant it may become to discuss organising a centralised repository, with specific tools to download and intersect such a repository. For now, we define only the format for posiedon modules and see where it goes.

# Poseidon modules

A Poseidon module is a directory with data files following a layout defined in a file called `poseidon.json`. This JSON file needs to follow the [JSON-schema](https://json-schema.org) defined in `poseidon-module-schema.json`.

Here is an example for a `poseidon.json` file:

    {
        "moduleName" : "myTestModule1",
        "metaDataFile" : "annot.csv",
        "description" : "This dataset contains information in individuals published in XXX",
        "publication" : {
            "PUBMED" : "1234567",
            "Journal" : "Journal of ancient DNA",
            "Date" : "2019-04-01",
            "Author" : "Schiffels et al."
        }
        "readme" : "README.md",
        "maintainer" : {
            "name": "Stephan Schiffels",
            "email" : "stephans.email@provider.com"
        },
        "lastUpdate" : "2019-07-10",
        "version" : "1.1.0",
        "genomicData" : {}
            "genotypeData" : {
                "format" : "eigenstrat",
                "snpSet : "1240K",
                "files" : [
                    "genotypes/geno.txt",
                    "genotypes/snp.txt",
                    "genotypes/ind.txt"
                ]
            },
            "completeGenomeData" : [
                {
                    "format" : "ranfa"
                    "sampleName" : "sample1",
                    "seqFile" : "complete-genome-data/sample1.ranfa",
                    "qualFile" : "complete-genome-data/sample1_qual.ranfa",
                },
                {
                    "format" : "hetfa"
                    "sampleName" : "sample1",
                    "seqFile" : "complete-genome-data/sample1.hetfa",
                    "qualFile" : "complete-genome-data/sample1_qual.hetfa",
                }
            }
        ]
    }

This example shows that how a `poseidon.json` module defines other files that are specified using _relative paths_ from the location of the `poseidon.json` file. The layout of the poseidon module defined in this example would be:

    my-module
    ├── poseidon.json
    ├── annot.csv
    ├── README.md
    ├── genotypes
    │   ├── ind.txt
    │   ├── snp.txt
    │   ├── geno.txt
    ├── complete-genome-data
    │   ├── sample1.ranfa
    │   ├── sample1_qual.ranfa
    │   ├── sample2.ranfa
    │   ├── sample2_qual.ranfa

A Poseidon module definition file follows the schema defined in `poseidon-module-schema.json`, which also defines which fields are required or optional, and what type of genomic data can be included in which format.

The idea behind defining modules via their `poseidon.json` file is to facilitate discovery of such modules in a directory tree. A tool combining datasets can search a directory tree for `poseidon.json` files and thereby immediately have access to multiple modules, ready to make queries across datasets and comparative analyses.

## Required elements of a Poseidon Module

As defined in the schema, at the root level, a `poseidon.json` file may have the following fields:

### moduleName (required)
A name of the module. Can be any string.

### maintainer (required)
An object with two elements, "name" and "email", as shown in the example above.

### lastUpdate (required)
The date of the last update of the module, formatted as YYYY-MM-DD.

### version (required)
A version for the module, following standard semantic versioning (such as "1.1.2"). This is important so that multiple modules with the same name but different versions can be maintained in a database.

### description (required)
A short description text for the module.

### readme (optional)
A relative path to a readme file describing more details about the module.

### metaDataFile (optional)
A relative path to the metadata file describing the individuals. This file must follow a separate schema defined below.

### publication (optional)
A JSON object with required fields "Journal" (text), "Date" (date, formatted as YYYY-MM-DD) and "Author" (text), and optional fields "doi" (the doi of the publication) and "URL" (a URL pointing to the publication).

### genomicData (optional)
This is a JSON object with information about the genomic data contained in the module. The following fields are allowed:

#### genotypeData
This field is for genotyping data, i.e. information only on a given set of preselected variable positions in the human genome. This is itself a JSON object with three required fields "snpSet", "format", "files". 

The "snpSet" field requires one of the currently allowed genotyping SNP sets:
- "1240K": The snp set resulting from in-solution capture of the "1240K"-reagent defined in [Mathieson et al. 2015](https://www.nature.com/articles/nature16152)
- "390K": The snp set resulting from in-solution capture of the "390K"-reagent defined in [Haak et al. 2015](https://www.nature.com/articles/nature14317)
- "Affymetrix-HumanOrigins": The snp set used in the [Affymetrix HumanOrigins (R) Genotyping Array](http://www.affymetrix.com/support/technical/byproduct.affx?product=Axiom_GW_HuOrigin) described in [Patterson et al. 2012](https://www.genetics.org/content/192/3/1065) and with large data being published from in [Lazaridis et al. 2014](https://www.nature.com/articles/nature13673)

#### completeGenomeData
This is again a JSON object with two required fields: "freqSumFile", which is a relative path to a file in [freqSum format](https://rarecoal-docs.readthedocs.io/en/latest/rarecoal-tools.html) describing all variable positions in all individuals. The second field "bedFiles" is an array consisting of relative paths to bed files. Each bed file gives the precise genomic regions in which an individual could be called. The order of bed files is the same order as individuals listed in the freqSum file.

Note that this setup is flexible as to which individuals have diploid genotypes, and which only haploid genotype calls. Both are possible in the freqSum format.

More documentation on this to follow...

# Metadata-Format
... todo ... currently in the Google Doc on the poseidon anno file. Need to convert this into t CSV on the Web format.