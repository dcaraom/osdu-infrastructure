// ---- General Configuration ----

variable "prefix" {
  description = "(Required) An identifier used to construct the names of all resources in this template."
  type        = string
}

variable "data_sources_workspace_name" {
  description = "(Required) The workspace name for the data_sources terraform environment / template to reference for this template."
  type        = string
}

variable "image_repository_workspace_name" {
  description = "(Required) The workspace name for the ACR image repository terraform environment / template to reference for this template."
  type        = string
}

variable "remote_state_account" {
  description = "Remote Terraform State Azure storage account name. This is typically set as an environment variable and used for the initial terraform init."
  type        = string
}

variable "remote_state_container" {
  description = "Remote Terraform State Azure storage container name. This is typically set as an environment variable and used for the initial terraform init."
  type        = string
}

variable "resource_group_location" {
  description = "(Required) The Azure region where all resources in this template should be created."
  type        = string
}

variable "ssl_certificate_keyvault_id" {
  type        = string
  description = "The keyvault certificate keyvault resource id used to setup ssl termination on the app gateway."
}

variable "randomization_level" {
  description = "Number of additional random characters to include in resource names to insulate against unexpected resource name collisions."
  type        = number
  default     = 8
}

variable "ssl_certificate_file" {
  type        = string
  description = "The x509-based SSL certificate used to setup ssl termination on the app gateway."
  default     = ""
}

variable "ssl_keyvault_id" {
  type        = string
  description = "The keyvault resource id used for ssl termination on the app gateway."
  default     = ""
}

###
# Begin: AKS configuration
###
variable "gitops_ssh_url" {
  type        = string
  description = "(Required) ssh git clone repository URL with Kubernetes manifests including services which runs in the cluster. Flux monitors this repo for Kubernetes manifest additions/changes periodically and apply them in the cluster."
}

# generate a SSH key named identity: ssh-keygen -q -N "" -f ./identity
# or use existing ssh public/private key pair
# add deploy key in gitops repo using public key with read/write access
# assign/specify private key to "gitops_ssh_key" variable that will be used to create kubernetes secret object
# flux uses this key to read manifests in the git repo
variable "gitops_ssh_key_file" {
  type        = string
  description = "(Required) SSH key used to establish a connection to a private git repo containing the HLD manifest."
}

variable "ssh_public_key_file" {
  type        = string
  description = "(Required) The SSH public key used to setup log-in credentials on the nodes in the AKS cluster."
}

variable "aks_agent_vm_count" {
  description = "The initial number of agent pools / nodes allocated to the AKS cluster"
  type        = string
  default     = "3"
}

variable "aks_agent_vm_size" {
  type        = string
  description = "The size of each VM in the Agent Pool (e.g. Standard_F1). Changing this forces a new resource to be created."
  default     = "Standard_D2s_v3"
}

variable "flux_recreate" {
  description = "Make any change to this value to trigger the recreation of the flux execution script."
  type        = string
  default     = "false"
}

variable "flexvol_deployment_url" {
  description = "The url to the yaml file for deploying the KeyVault flex volume."
  type        = string
  default     = "https://raw.githubusercontent.com/Azure/kubernetes-keyvault-flexvol/98eb694f7b78440f3f0e2cc36260971482a499bd/deployment/kv-flexvol-installer.yaml"
}

variable "gitops_path" {
  type        = string
  description = "Path within git repo to locate Kubernetes manifests"
  default     = "providers/azure/hld-registry"
}

variable "gitops_url_branch" {
  type        = string
  description = "Branch of git repo to use for Kubernetes manifests."
  default     = "master"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.15.7"
  description = "Version of Kubernetes specified when creating the AKS managed cluster."
}

variable "gitops_poll_interval" {
  type        = string
  default     = "10s"
  description = "Controls how often Flux will apply what’s in git, to the cluster, absent new commits"
}

variable "gitops_label" {
  type        = string
  default     = "flux-sync"
  description = "Label to keep track of Flux sync progress, used to tag the Git branch"
}

variable "service_cidr" {
  default     = "10.0.0.0/16"
  description = "Used to assign internal services in the AKS cluster an IP address. This IP address range should be an address space that isn't in use elsewhere in your network environment. This includes any on-premises network ranges if you connect, or plan to connect, your Azure virtual networks using Express Route or a Site-to-Site VPN connections."
  type        = string
}

variable "dns_ip" {
  default     = "10.0.0.10"
  description = "should be the .10 address of your service IP address range"
  type        = string
}

variable "docker_cidr" {
  default     = "172.17.0.1/16"
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Default of 172.17.0.1/16."
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_prefix_aks" {
  description = "The address prefix to use for the subnet."
  type        = string
  default     = "10.10.1.0/24"
}

variable "subnet_prefix_app_gw" {
  description = "The address prefix to use for the app gateway subnet."
  type        = string
  default     = "10.10.2.0/24"
}

variable "network_plugin" {
  default     = "azure"
  type        = string
  description = "Network plugin used by AKS. Either azure or kubenet."
}

variable "network_policy" {
  default     = "azure"
  type        = string
  description = "Network policy to be used with Azure CNI. Either azure or calico."
}

variable "oms_agent_enabled" {
  type        = string
  description = "Is the Kubernetes Log Analytics OMS Agent Enabled"
  default     = "true"
}
###
# End: AKS configuration
###