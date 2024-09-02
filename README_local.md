poetry config virtualenvs.in-project true --local
poetry init
pythonのバージョンは>=3.11,<3.12に指定
poetry add numpy@1.26.4 
poetry add $(cat requirements.txt)

