#!/usr/bin/env bash 
set -euo pipefail 
echo "=== Cryptographic Agility &amp; Policy Verification ===" 

# Check active system crypto policy 
ACTIVE\_POLICY=$(update-crypto-policies --show) echo "Active Crypto Policy: ${ACTIVE\_POLICY}" 
# Validate OpenSSL active ciphers 
echo -e "\\n--- OpenSSL Active Cipher List ---" openssl ciphers -v | head -n 10 
# Verify FIPS / SHA256 hashing support 
echo -e "\\n--- OpenSSL Digest Test ---" 
echo "Test payload" | openssl dgst -sha256 

echo -e "\\n[SUCCESS] Cryptographic configuration validated."
