#!/usr/bin/env bash

echo "::debug::Update"
apt-get update

echo "::debug::Install Dependencies"
apt-get install -y runc containerd dmsetup
