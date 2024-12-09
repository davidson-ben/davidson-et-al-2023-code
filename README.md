# davidson-et-al-2023-code

This repository contains the code and data used in the paper "**Beaching model for buoyant marine debris in bore-driven swash**" by Davidson et al., 2023, published in the Jounral _Flow_.

## Contents
-**figure#.m**: MATLAB scripts that generate Figures 3-10.  Scripts pull data from the corresponding **figure#_data.mat** file if necessary.

-**figure#_data.mat**: Data files used by MATLAB scripts to create the figures.

-**swash_part_model.m**: Function that solves for particle position, velocity, and time given input particle conditions.

-**swash_part_model_iter.m**: Function that solves for final particle position iteratively across initial velocity and Stokes number.

-**swashinertialparticle_ode.m**: The inertial particle acceleration function which is integrated to solve for the particle velocity and position.

-**swashinertialparticle_int.m**: Function that sets up the integration of **swashinertialparticle_ode.m**.

-**LICENSE**: MIT License details.

## Usage

1. **Clone the repository**:
    ```bash
    git clone https://github.com/davidson-ben/davidson-et-al-2023-code.git
    ```
2. **Navigate to the repository directory**:
    ```bash
    cd davidson-et-al-2023-code
    ```
3. **Run the MATLAB scripts**:
   
    Open MATLAB and run the desired `figure#.m` script to generate the corresponding figure.

## Requirements

- MATLAB R2022a or later

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Citation

If you use this code or data in your work, please cite the original paper:
Davidson, et al. (2023). Beaching model for buoyant marine debris in bore-driven swash. *Flow*.
