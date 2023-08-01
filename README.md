# Link Budget Design Project

This repo contains my Link Budget Design Project for a course in Radiation and Propagation course during my undergraduate degree

## Project Overview

The project's goal is to design a data link modulation scheme for a CubeSat or any satellite. Several factors need to be considered, including Bit Error Rate (BER), cost, power consumption, circuit complexity, Signal-to-Noise Ratio (SNR), bandwidth, and reliability.

## Modulation Scheme Selection

The project explores different modulation schemes like FM (FSK, MSK) and other methods, weighing their advantages and disadvantages in terms of spectral efficiency, power efficiency, and circuit complexity. After careful consideration, the selected modulation scheme is OQPSK (Offset Quadrature Phase Shift Keying). This choice is justified based on its good power efficiency, less complex circuitry compared to MSK, a 3dB advantage over FSK, and better performance in the presence of reference carrier phase jitter.

## Antenna Design

The project involves calculating the Half Power Beam Width (HPBW) of the satellite antenna to ensure it encompasses the Earth's surface. A parabolic dish antenna with a diameter of 0.5 meters is chosen to conserve space on the CubeSat. The effective aperture and gain of the antenna are also computed.

## Link Budget Calculations

The project computes the data rate required for sending data within 15 minutes (time_download) and determines the minimum download rate (R_min) needed for successful data transmission. The Signal-to-Noise Ratio (SNR) is calculated to assess the link quality and capacity.

## Variables and Results

The README provides an overview of the main variables used in the calculations and their corresponding values. It includes the beam width, effective area, power efficiency, gain of transmitter and receiver, frequency, received power, noise temperatures, SNR, and link capacity.

## Conclusion

The OQPSK modulation scheme is found to be suitable for the CubeSat data link, considering various factors like power efficiency, complexity, and spectral efficiency. The link budget calculations indicate that the selected modulation scheme, antenna design, and system parameters provide a feasible and reliable data link for the CubeSat.
