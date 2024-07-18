# Heart 4D Modelling
 Given data from a scientific study, we aim to prepare a heart modelling for an Electrical Impedance Analysis simulation.

## Table of Contents

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

## Getting Started

To get a copy of this project up and running on your local machine, follow these simple steps.

### Prerequisites

Before you begin, ensure you have installed:
- `Matlab` (recommanded version `>= R2024a`)
- `MeshLab`
- `Gmsh`

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
├── instructions_meshing.pdf
├── README.md
├── LICENSE
```

### Code
The `code` directory contains the three main scripts essential for running the project:

- `plots.mlx`: All of the understanding process
- `video_basic_time_evo.m`: Export for basic output
- `video_unterpolated_time_evo.m`: Export for advanced output

### Resources
The `resources_plot` directory holds reusable scripts that are utilized by the primary scripts in the `code` directory:

- `plot_check_volume.py`: Take a look at the volume curve
- `plot_csv_3d_vizualise.m`: Plot one of the CSV data files
- ...

### Data
The `data` directory includes the datasets and other resources required by the scripts.

### Others

- `instructions_meshing.pdf`: Instructions to create a mesh with thickness, from a CSV file.


## Usage
To use this project, follow these steps:

1. Open the files in Matlab
2. Eventually set up the variables at the beginning of files
3. Run the files


## Contributing
We welcome contributions! To contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

### To go further
This project isn't perfect. For instance, a few points that would need to be further explored:
- Data format when it comes to export the video in Matlab. The CSV output file is way to big, it needs to be thought differently.
- Automating the meshing pipeline in MeshLab and Gmsh. At the moment it takes much time to transform the files.
- Pursue to prepare the Electrical Impedance Analysis, to integrate it in the software EIDORS.

We wish you the best of luck!

## License
This project is licensed under the CC0 1.0.

## Acknowledgements

- Students who worked on this repository: Elouan Colybes & Mathieu Jacq
- Many thanks to our supervisor: M.Sc. Daniel Voss
- Link to L. Obermeier study, from which all our data come from: [here](https://ieeexplore.ieee.org/document/10478556)
