clean:
	rm -rf build dist pip-wheel-metadata .pytest_cache
	find . -regex ".*/__pycache__" -exec rm -rf {} +
	find . -regex ".*\.egg-info" -exec rm -rf {} +

install:
	pip install .

install-pip-setuptools:
	python -m pip install -U "pip>=19.1.1, <20.0" "setuptools>=41.0.1, <42.0" wheel

lint:
	pre-commit run -a --hook-stage manual

test:
	pytest tests

e2e-tests:
	behave

secret-scan:
	trufflehog --max_depth 1 .

package: clean install
	python setup.py clean --all
	python setup.py sdist bdist_wheel

legal:
	python tools/license_and_headers.py
