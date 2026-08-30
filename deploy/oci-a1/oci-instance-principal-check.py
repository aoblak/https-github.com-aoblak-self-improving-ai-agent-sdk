#!/usr/bin/env python3
import oci

signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
identity = oci.identity.IdentityClient(config={}, signer=signer)
tenancy = identity.get_tenancy(signer.tenancy_id).data
print(f"Instance principal OK; tenancy={tenancy.name}; id={tenancy.id}")
