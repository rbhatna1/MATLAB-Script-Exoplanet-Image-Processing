# MATLAB-Script-Exoplanet-Image-Processing

## Overview
This MATLAB script processes an image of an exoplanet using the Gerchberg-Saxton algorithm. The script performs operations such as loading an image, applying an optical system, and reconstructing the image using discrete Fourier transforms (DFT). The final processed images are saved as frames for further use or visualization.

## Functions

### Main Script
- **Description**: Orchestrates the execution of the script, including loading the image, applying the optical system, running the Gerchberg-Saxton algorithm, and saving the resulting frames.
- **Side Effects**: Displays and saves frames of the processed image.

### `loadImage`
- **Description**: Loads an indexed image of an exoplanet from a NASA website and converts it to grayscale.
- **Side Effects**: Downloads and reads the image file.
- **Input Arguments**: None.
- **Output Arguments**: `im` - Grayscale image.

### `opticalSystem`
- **Description**: Applies an optical system to the image by simulating an occulting square and modifying the image's phase in the frequency domain.
- **Side Effects**: None.
- **Input Arguments**: `im` - Grayscale image, `width` - Width of the occulting square.
- **Output Arguments**: `im` - Modified image, `Dphi` - Phase difference matrix.

### `occultSquare`
- **Description**: Applies an occulting square of a specified width to the center of the image.
- **Side Effects**: Modifies the input image.
- **Input Arguments**: `im` - Grayscale image, `width` - Width of the occulting square.
- **Output Arguments**: `im` - Modified image.

### `dft2`
- **Description**: Computes the 2D discrete Fourier transform of an image, returning the amplitude and phase.
- **Side Effects**: None.
- **Input Arguments**: `im` - Grayscale image.
- **Output Arguments**: `IMa` - Amplitude of the DFT, `IMp` - Phase of the DFT in degrees.

### `idft2`
- **Description**: Computes the inverse 2D discrete Fourier transform of an image from its amplitude and phase.
- **Side Effects**: None.
- **Input Arguments**: `IMa` - Amplitude of the DFT, `IMp` - Phase of the DFT in degrees.
- **Output Arguments**: `im` - Reconstructed image.

### `gerchbergSaxton`
- **Description**: Implements the Gerchberg-Saxton algorithm to iteratively reconstruct the image.
- **Side Effects**: Prints iteration progress to the command window.
- **Input Arguments**: `im` - Grayscale image, `maxIters` - Maximum number of iterations, `Dphi` - Phase difference matrix.
- **Output Arguments**: `images` - Cell array of reconstructed images at each iteration.

### `getFrames`
- **Description**: Converts the array of images into frames for visualization.
- **Side Effects**: Displays and captures frames of the processed images.
- **Input Arguments**: `images` - Cell array of images.
- **Output Arguments**: `frames` - Array of captured frames.

## Usage
1. **Run the Script**: Execute the main section of the script in MATLAB.
2. **View Processed Images**: The script will display and save frames of the processed images using the Gerchberg-Saxton algorithm.
