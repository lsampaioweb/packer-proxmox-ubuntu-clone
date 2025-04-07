source "null" "password" {
  communicator = "none"
}

build {
  name = "credentials"

  sources = ["source.null.password"]

  provisioner "shell-local" {
    inline = [
      # Retrieve the password from the secret manager using the cloned VM’s name.
      "cloned_vm_password=$(secret-tool lookup password '${var.clone_vm}') || exit 1",

      # Store the password under the new template’s name.
      "echo -n $cloned_vm_password | secret-tool store --label='${var.vm_name}' password '${var.vm_name}' || exit 1"
    ]
  }
}
