source "proxmox-clone" "template" {
  # https://www.packer.io/plugins/builders/proxmox/clone

  # Proxmox authentication
  proxmox_url = var.proxmox_url
  username    = var.username
  token       = var.token

  # General
  node                 = var.node
  vm_id                = var.vm_id
  vm_name              = var.vm_name
  pool                 = var.pool
  bios                 = var.bios
  onboot               = var.onboot
  task_timeout         = var.task_timeout
  template_description = var.template_description

  # Clone
  clone_vm   = var.clone_vm
  full_clone = var.full_clone

  # OS
  boot = var.boot
  os   = var.os
  vga {
    type   = var.vga.type
    memory = var.vga.memory
  }

  # Cloud-Init
  cloud_init              = var.cloud_init
  cloud_init_storage_pool = var.cloud_init_storage_pool

  # System
  machine         = var.machine
  qemu_agent      = var.qemu_agent
  scsi_controller = var.scsi_controller

  # CPU
  sockets  = var.sockets
  cores    = var.cores
  cpu_type = var.cpu_type

  # Memory
  memory = var.memory

  # SSH Connection with the template
  ssh_username = var.ssh_username
  ssh_timeout  = var.ssh_timeout
}

build {
  name = var.build_name

  sources = ["source.proxmox-clone.template"]

  provisioner "ansible" {
    playbook_file = "${local.path_ansible_scripts}/template.yml"
    user          = var.ssh_username
    use_proxy     = var.use_proxy

    ansible_env_vars = ["ANSIBLE_CONFIG=${local.path_ansible_scripts}/ansible.cfg"]

    extra_arguments = [
      "--extra-vars",
      "hostname=${var.vm_name}"
    ]

    // This is a bug/workaround and I didn't like it. 
    // TODO - Find a better solution.
    ansible_ssh_extra_args = ["-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"]
  }
}
