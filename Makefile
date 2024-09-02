SRC := ai_scientist

run_and_enter_container:
	docker-compose run app bash

setup_grokking:
	poetry add einops
	cd templates/grokking && poetry run python experiment.py --out_dir run_0 && poetry run python plot.py

run:
	poetry run python launch_scientist.py --experiment=grokking --model=gpt-4o-2024-05-13 --num-ideas=2