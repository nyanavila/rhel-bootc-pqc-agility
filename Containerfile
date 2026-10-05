FROM registry.redhat.io/rhel9/rhel-bootc:latest 
LABEL maintainer="Security & Infrastructure Team" 
  \ description="RHEL 9 Image Mode bootc image hardened for Cryptographic Agility" 

# 1. Install management tools and client utilities 
RUN dnf install -y \ 
    crypto-policies \ 
    crypto-policies-scripts \ 
    openssl \ 
    gnutls-utils \ 
    rhc \ 
    insights-client \ 
    foreman_ygg_worker \ 
    && dnf clean all 

# 2. Copy custom crypto-policy sub-modules 
COPY config/crypto-policies/PQC-AGILITY.policy /etc/crypto-policies/policies/modules/PQC-AGILITY.policy 
COPY config/pki/custom-ca.crt /etc/pki/ca-trust/source/anchors/custom-ca.crt 

# 3. Apply CA trust and set system-wide crypto policy 
RUN update-ca-trust && \ 
    update-crypto-policies --set DEFAULT:PQC-AGILITY 

# 4. Verify crypto-policy application 
RUN update-crypto-policies --show
