# Heart 4D Modelling
 Given data from a scientific study, we aim to prepare a heart modelling for an Electrical Impedance Analysis simulation.

## Table of Contents

- [Introduction](#introduction)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Repository Structure](#repository-structure)
  - [Code](#code)
  - [Resources](#resources)
  - [Data](#data)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Introduction

[Provide a more detailed description of the project. Mention its key features, goals, and why it might be useful.]

## Getting Started

To get a copy of this project up and running on your local machine, follow these simple steps.

### Prerequisites

Before you begin, ensure you have installed Matlab (recommanded version >= R2024a).

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/elouan50/Heart-4D-Modelling.git
    ```
2. Navigate into the project directory:
    ```bash
    cd Heart-4D-Modelling
    ```

## Repository Structure

Here's an overview of the project's structure:

```plaintext
Heart-4D-Modelling/
├── code/
│   ├── plots.mlx
│   ├── video_basic_time_evo.m
│   ├── video_unterpolated_time_evo.m
│
├── resources_plots/
│   ├── plot_check_volume.m
│   ├── plot_csv_3d_visualze.m
│   ├── ...
│
├── data/
│   ├── subject1
│   │   ├── FSI
│   │   │   ├── displacement
│   │   │   │   ├── GridVelocity_X.csv
│   │   │   │   ├── IntermediateVolumeForRepresentation.csv
│   │   │   │   ├── VolumeCurve.csv
│   │   │   │   ├── VolumeFlux.csv
│   │   │   ├── stl_geometries
│   │   │   │   ├── Myocard.stl
│   │   │   │   ├── ...
│   ├── dataset2.csv
│   │   ├── ...
│   ├── dataset3.csv
│   │   ├── ...
├── README.md
├── LICENSE
```

### Code
The code directory contains the three main scripts essential for running the project:

- plots.mlx: [All of the understanding process]
- video_basic_time_evo.m: [Export for basic output]
- video_unterpolated_time_evo.m: [Export for advanced output]

### Resources
The resources directory holds reusable scripts that are utilized by the primary scripts in the code directory:

- helper1.py: [Brief description of helper1]
- helper2.py: [Brief description of helper2]

### Data
The data directory includes the datasets and other resources required by the scripts:

- dataset1.csv: [Brief description of dataset1]
- dataset2.csv: [Brief description of dataset2]

## Usage
To use this project, follow these steps:


## Contributing
We welcome contributions! To contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (git checkout -b feature-branch).
3. Make your changes and commit them (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature-branch).
5. Create a new Pull Request.

## License
This project is licensed under the CC1.0.

## Acknowledgements


