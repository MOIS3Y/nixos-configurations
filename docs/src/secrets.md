# Secrets Management

> [!IMPORTANT]
> Never store sensitive information like passwords, API keys, or private SSH keys in plain text within a public repository.

To securely manage secrets across my devices, I use [sops-nix](https://github.com/Mic92/sops-nix), which integrates [SOPS](https://github.com/getsops/sops) (Secrets OPerationS) directly into the NixOS and Home Manager ecosystems.

---

## Learning Resources

> [!TIP]
> If you are new to SOPS and NixOS, I highly recommend watching this video by **Vimjoyer**:
> [Secrets Management in NixOS with sops-nix](https://youtu.be/G5f6GC7SnhU?si=TUyMDrIPlKqnf-_-)
> It provides a very clear and practical explanation of the concepts and workflow.

---

## How it Works

1. **Encryption:** Secrets are stored in encrypted YAML or JSON files within the `secrets/` directory.
2. **Key Management:** SOPS uses an `.sops.yaml` file in the repository root to define which public keys (Age or GPG) can encrypt/decrypt each file.
3. **Decryption at Runtime:** 
    - **NixOS:** Secrets are decrypted into `/run/secrets/`.
    - **Home Manager:** Secrets are decrypted into `$XDG_RUNTIME_DIR/secrets.d/`.
4. **Access:** Applications point to these paths instead of hardcoded values.

---

## Workflow: Getting Started

### 1. Generate an Age Key

I use **Age** for its modern simplicity. Generate a key for your machine:

```console
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

**Crucial Step:** You must add the public key (the one printed to the console or found in the `keys.txt` comments) to your `.sops.yaml` file. Without this, SOPS won't know how to encrypt files for you.

### 2. Creating and Editing Secrets

Use the `sops` CLI to manage files. It automatically handles encryption when you save.

```console
# Create/Edit a host-specific secret
sops secrets/hosts/desktop-workstation/secrets.yaml
```

### 3. Registering Secrets in Nix

#### System Level (`hosts/_shared/sops.nix`)
```nix
sops.defaultHostSopsFile = ../../secrets/hosts/desktop-workstation/secrets.yaml;

# Special case: user passwords needed before user creation
sops.secrets."user-password" = {
  neededForUsers = true;
};
```

#### User Level (`homes/_shared/sops/default.nix`)
```nix
sops.defaultUserSopsFile = ../../secrets/homes/stepan/secrets.yaml;
sops.secrets."github-token" = {};
```

---

## Advanced Tips

- **`neededForUsers`**: Set this to `true` for secrets that must be available *before* users are created (like the hashed password for the initial user).
- **Evaluating Code**: Remember that secrets are **not** available during Nix evaluation time. You cannot use `builtins.readFile config.sops.secrets.x.path`. You must pass the *path* to the application.
- **Updating Keys**: If you add a new host key to `.sops.yaml`, you must run `sops updatekeys <file.yaml>` on all relevant files to re-encrypt them for the new key.

> [!TIP]
> If your age key is stored in a non-standard location, you can point SOPS to it using an environment variable. This is especially useful for one-off commands:
> ```console
> export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt
> sops <file.yaml>
> ```

---

## Summary of Commands

| Action | Command |
| :--- | :--- |
| **Generate Key** | `age-keygen -o keys.txt` |
| **Edit Secret** | `sops <file.yaml>` |
| **View Secret** | `sops -d <file.yaml>` |
| **Rotate/Update Keys** | `sops updatekeys <file.yaml>` |
