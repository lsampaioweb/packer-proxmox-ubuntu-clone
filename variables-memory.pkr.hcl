variable "memory" {
  description = "How much memory, in megabytes, to give the virtual machine. Defaults to 6144."
  type        = number
  default     = 6144
}

variable "ballooning_minimum" {
  description = "Setting this option enables KVM memory ballooning and defines the minimum amount of memory (in megabytes) the VM will have. Defaults to 1024."
  type        = number
  default     = 1024
}
