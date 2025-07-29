 ROBUST DIGITAL FILTER DESIGN FOR NOISY SENSOR DATA

PROJECT OVERVIEW:
This project focuses on the critical task of denoising sensor data, a fundamental challenge in electronics and control systems, especially in high-precision applications like motor control and electric vehicles. Inspired by the "Study of Encoder IC AS5147U", this simulation-based study develops and evaluates robust digital filters to effectively manage noisy sensor readings in real-world environments.
Accurate sensor data is paramount for precise control algorithms. This project demonstrates the ability to analyse noisy data, design appropriate filtering solutions, and understand their practical implementation on embedded systems.

OBJECTIVES:
* To simulate a clean encoder angle signal.
* To introduce various types of realistic noise (Additive White Gaussian Noise and Impulse Noise) to the simulated signal, creating a "noisy environment".
* To design and implement two types of digital filters: Moving Average (MA) filter and Infinite Impulse Response (IIR) Butterworth Low-Pass filter.
* To quantitatively evaluate the performance of these filters using metrics like Mean Squared Error (MSE) and Signal-to-Noise Ratio (SNR).
* To conceptually understand and showcase embedded implementation of digital filters using C-code snippets, emphasizing efficient memory management for microcontrollers.

METHODOLOGY:
The project follows a systematic approach:
1.Signal Generation: A smooth, ideal encoder angle signal is simulated to represent the clean, desired output.
2.Noise Injection: Realistic noise models, including AWGN and impulse noise, are added to the clean signal to mimic imperfections from sensors like the AS5147U encoder IC.
3.Filter Design & Application:
*Moving Average (MA) Filter: A simple Finite Impulse Response (FIR) filter is implemented to smooth out random fluctuations by averaging data points within a defined window.
*IIR Butterworth Low-Pass Filter: A more complex Infinite Impulse Response (IIR) filter is designed to effectively attenuate high-frequency noise while preserving the essential low-frequency signal components.
4.Performance Analysis: The effectiveness of each filter is quantified by comparing the filtered signal against the original clean signal using:
 *Mean Squared Error (MSE): Measures the average squared difference (lower is better).
 *Signal-to-Noise Ratio (SNR): Measures signal power relative to noise power (higher is better).
5.Robustness Evaluation (Conceptual): The project setup allows for easy modification of noise parameters to test how filters perform under varying noise conditions, enabling discussions on filter parameter tuning for "robust digital filters".
6. Embedded Implementation: High-level C-code snippets illustrate how these digital filtering algorithms would be translated and optimized for real-time execution on microcontrollers, considering constraints like memory and processing power. This directly addresses the "Coding" and "C" skills required.

KEY LEARNINGS & SKILLS DEMONSTRATED:
Digital Signal Processing (DSP): Fundamental concepts of signals, noise, and digital filtering.
Digital Filter Design: Practical experience with FIR (MA) and IIR (Butterworth) filter design principles.
MATLAB & Signal Processing Toolbox: Proficient use of MATLAB for signal generation, filter implementation, simulation, and data visualization.
Problem Solving & Analysis: Identifying noise issues, designing solutions, and quantitatively assessing their effectiveness.
Embedded Systems Concepts: Understanding of real-time algorithm implementation, memory management, and microcontroller programming (using C).
Sensor Interfacing: Conceptual understanding of processing data from encoder ICs like AS5147U, relevant to "SPI Communication".


HOW TO RUN THE PROJECT:
1.Prerequisites: Ensure you have MATLAB with the Signal Processing Toolbox installed on your system.
2.Clone the Repository:
    ```bash
git clone [ https://github.com/Vaishnavi333334/-Robust-Digital-Filter-Design-for-Noisy-Sensor-Data ] ( https://github.com/Vaishnavi333334/-Robust-Digital-Filter-Design-for-Noisy-Sensor-Data )
 cd -Robust-Digital-Filter-Design-for-Noisy-Sensor-Data
  ```
3.Open in MATLAB: Launch MATLAB and navigate to the cloned repository directory (e.g., `-Robust-Digital-Filter-Design-for-Noisy-Sensor-Data`) using MATLAB's "Current Folder" pane or by typing `cd path/to/-Robust-Digital-Filter-Design-for-Noisy-Sensor-Data` in the Command Window.
4.  the Script: Open `robustdigitalfilterfornoisysensordata.m` in the MATLAB editor and click the "Run" button (green triangle) or press `F5`.
5. Observe Results:
 * Multiple figure windows will pop up, displaying the clean signal, noisy signals, and filter performance plots.
 * Quantitative performance metrics (MSE and SNR) will be printed in the MATLAB Command Window.

RESULTS & VISUALIZATIONS:
FIG 1- CLEAN ENCODER SIGNAL:
![Clean Encoder Signal](figs/https://github.com/Vaishnavi333334/-Robust-Digital-Filter-Design-for-Noisy-Sensor-Data/blob/68e14d7479e3a82f712f848936e0f284673c13de/Fig(1)CleanEncoderSignal.png?raw=true)
Clean Encoder Signal:Shows the ideal, noiseless sensor output. 

FIG 2- NOISY ENCODER SIGNALS:
<img width="1637" height="882" alt="Fig(2)NoisyEncoderSignals" src="https://github.com/user-attachments/assets/3da9149f-e5af-4f39-968a-d5dfb0d6a59f" />
Noisy Encoder Signals:Illustrates the corruption of the signal by AWGN and impulse noise.


FIG 3- MOVING AVERAGE(MA) FILTER PERFORMANCE:
<img width="1630" height="889" alt="Fig(3)MovingAverage(MA)FilterPerformance" src="https://github.com/user-attachments/assets/f554ce22-cb55-4eff-af54-79cc63e58e9e" />
Moving Average Filter Performance:Demonstrates the smoothing effect of the MA filter.

FIG 4- IIR BUTTERWORTH FILTER PERFORMANCE:
<img width="1644" height="869" alt="Fig(4)IIRbutterworthFilterPerformance" src="https://github.com/user-attachments/assets/fb0d8002-49ec-438e-9524-0828bb9fb831" />
IIR Butterworth Filter Performance:Shows the effectiveness of the IIR low-pass filter in denoising.


FIG 5-IIR FILTER FREQUENCY RESPONSE:
<img width="1632" height="883" alt="IIRFilterFrequencyResponse" src="https://github.com/user-attachments/assets/ea3f8621-bda2-46e3-b6fc-a77d73463db1" />
IIR Filter Frequency Response:Provides insight into the filter's frequency-domain characteristics.

FILTER PERFORMANCE METRICS:
<img width="1628" height="261" alt="FilterPerformanceMetrics" src="https://github.com/user-attachments/assets/c14be48b-726a-4248-83bf-8d9692f99f66" />



FUTURE WORK:
Implement the filters on actual hardware using a microcontroller (e.g., an ARM Cortex-M board) and a real AS5147U encoder via SPI.
Explore adaptive filtering techniques that can dynamically adjust to changing noise characteristics.
Integrate this denoised encoder data with a motor control algorithm (e.g., Field-Oriented Control) to evaluate its impact on motor performance.
