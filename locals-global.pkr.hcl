locals {
  path_ansible_scripts = "${path.cwd}/../ansible"

  # Fallback to the boot disk's storage pool if cloud_init_storage_pool is null, or to the default if disks is empty.
  cloud_init_storage_pool = var.cloud_init_storage_pool != null ? var.cloud_init_storage_pool : (length(var.disks) == 0) ? var.disk_default_storage_pool : lookup(var.disks[0], "storage_pool", var.disk_default_storage_pool)
}