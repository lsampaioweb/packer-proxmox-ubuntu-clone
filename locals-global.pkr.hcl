locals {
  path_temp_files = "${path.cwd}/clone/tmp"
  path_password   = "${local.path_temp_files}/.password"

  path_ansible_scripts = "${path.cwd}/../ansible"
}
