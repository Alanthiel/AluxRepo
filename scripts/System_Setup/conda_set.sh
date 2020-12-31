#! /bin/bash
conda install --name Encr python==3.7 pycryptodome  json scrypt pyqt -y
conda install --name software_base python==3.7 pyqt tk pycryptodome pyinstaller pandas numpy 
conda install --name tensor_base python==3.7 tensorflow-gpu keras-gpu pandas numpy seaborn  scipy  matplotlib
