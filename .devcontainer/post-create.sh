#! /usr/bin/env bash

echo "Running post-create script 🛠️"

sudo chown -R remote:remote /home/remote/workspace
# sudo usermod -aG docker remote

# Install all the dependencies
echo "Downloading tools and dependencies 📦 (It can take some time...)"
go run github.com/playwright-community/playwright-go/cmd/playwright@v0.5200.1 install --with-deps

echo "Dev Container initialized 🚀"