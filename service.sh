#!/bin/env bash

if [ -f override.yml ]; then
	docker compose -f compose.yml -f override.yml $@
else
	docker compose $@
fi