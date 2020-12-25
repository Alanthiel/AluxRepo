#! /bin/bash
pip install --upgrade --force-reinstall --no-deps kaggle
mkdir ~/.kaggle
chmod 600 kaggle.json
cp /content/kaggle.json ~/.kaggle/kaggle.json
kaggle config set -n path -v{/content}
