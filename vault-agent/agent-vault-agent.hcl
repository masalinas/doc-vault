
pid_file = "./pidfile"

auto_auth {
  method {
    type = "approle"

    config = {
      role_id_file_path = "/Users/miguel/git/vault-agent-docker/vault-agent/agent-role_id"
      secret_id_file_path = "/Users/miguel/git/vault-agent-docker/vault-agent/agent-secret_id"
      remove_secret_id_file_after_reading = false
    }
  }

  sink {
    type = "file"
    config = {
      path = "/Users/miguel/git/vault-agent-docker/vault-agent/token"
    }
  }
}

template {
  source = "/Users/miguel/git/vault-agent-docker/vault-agent/agent-kv.tpl"
  destination = "/Users/miguel/git/vault-agent-docker/vault-agent/agent-kv.html"
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
    address = "0.0.0.0:8300"
    tls_disable = true
}

vault {
  address = "http://localhost:8200"
}
