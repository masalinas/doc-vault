# This policy allows the app (vault aggant) to access Key/Value

# List, create, update, and delete key/value secrets permissions
path "kv/data/agent/*"
{
  capabilities = ["create", "read", "update", "delete", "list"]
}
