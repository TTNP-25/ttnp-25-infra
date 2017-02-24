# TTNP-25 Nodes

This repo contains the code required for the infrastructure to manage The
Things Network in Monmouth.

## Contributing

If you want to help with the design/architecture of the system, please do the following:

   * [Fork the repo](https://github.com/TTNP-25/ttnp-25-infra/fork)
   * Create a new sub-directory for your node type
   * Commit your code
   * [Submit a Pull Request](https://github.com/ttnp-25/ttnp-25-infra/nodes/compare)

## Working on Infrastructure

The infrastructure that underpins TTNP-25 is all in source control as
Infrastructure as Code.

You can find the [Terraform](https://terraform.io) code that builds the infrastructure in the `terraform`
directory and the [Ansible](https://www.ansible.com) code that configures it in the `ansible` directory.

Finally, the [Packer](https://packer.io) code to build the instances is available at `packer`.
