#!/bin/bash

CLASSROOT="/deac/phy/classes/phy266"
USERS=(
    cajkct19
    fivece22
    gaow221
    grahjw21
    peakar21
    siggvr19
    swytap22
    thomjm22
    zhuy22
    salsbufr
    anderss
)

for user in ${USERS[@]}; do

target="${CLASSROOT}/${user}"
mkdir -p $target

cat <<EOF > ${target}/simple_harmonic_oscillator.py
import math

# Assign the mass (in kilograms) and spring constant (in N/m) to variables
mass = 0.5  # A typical mass value for a small object
spring_constant = 3  # A typical spring constant

# The formula for the period T of a SHO is 2π√(m/k)
# We use math.pi for π and math.sqrt for the square root
period = 2 * math.pi * math.sqrt(mass / spring_constant)

# Display the calculated period with a descriptive message
print(f"The period of the SHO is {period:.2f} seconds")
EOF

wget -O ${target}/01_introduction_to_data_science_libraries.ipynb https://raw.githubusercontent.com/GDS-Education-Community-of-Practice/DSECOP/main/Intro_to_Data_Science_Libraries/01_introduction_to_data_science_libraries.ipynb
wget -O ${target}/nuclear_data.tsv https://raw.githubusercontent.com/GDS-Education-Community-of-Practice/DSECOP/main/Intro_to_Data_Science_Libraries/nuclear_data.tsv

chown -R ${user}:phy266 $target

done
