export ARM_CLIENT_ID=23965206-f2a6-4723-b674-62a647cb98a5
export ARM_TENANT_ID=3940b1f0-857e-413b-8e7d-261d0842437d
export ARM_SUBSCRIPTION_ID=2422817a-728f-4761-bd14-ff8e63d0f45e

# echo "=== Login to Azure with $SERVICE_PRINCIPAL_USR ==="
# az login \
#     --service-principal \
#     -u $ARM_CLIENT_ID \
#     -p $ARM_CLIENT_SECRET \
#     --tenant $ARM_TENANT_ID >/dev/null

# echo "=== Switch to subscription $SUBSCRIPTION_ID ==="
# az account set -s $ARM_SUBSCRIPTION_ID >/dev/null