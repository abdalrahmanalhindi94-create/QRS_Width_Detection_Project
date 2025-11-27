# QRS Width Detection on Electrocardiography

A brief MATLAB project for detecting the QRS complex width in ECG signals.  
Includes the detection algorithm, paper, and presentation.

---

##  Overview
The QRS complex represents ventricular depolarization.  
Its width is essential for diagnosing:
- Arrhythmias  
- Conduction abnormalities  
- Exercise-induced changes  

This project implements a simple and effective MATLAB algorithm to detect:
- Q peak  
- R peak  
- S peak  
and compute QRS duration across rest, exercise, and recovery phases.

---

##  Repository Structure


---

## 🛠 Algorithm Summary
1. **Filtering:** Butterworth band-pass (5–15 Hz)  
2. **Differentiation:** Highlights steep slopes  
3. **R-peak detection:** Local maxima > 60% of global peak  
4. **Q & S detection:** Nearest peaks before/after R  
5. **QRS duration:**  
   `QRS_width = S_offset - Q_onset` (ms)

Tested on signals from rest, exercise, and recovery.

---



