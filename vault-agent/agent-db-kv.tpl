{{ with secret "kv/agent/static" -}}
POSTGRES_DB={{ .Data.data.app }}
POSTGRES_USER={{ .Data.data.username }}
POSTGRES_PASSWORD={{ .Data.data.password }}
{{- end }}